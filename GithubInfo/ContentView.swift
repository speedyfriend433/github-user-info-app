//
// ContentView.swift
//
// Created by Speedyfriend67 on 14.10.24
//
 
import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var user: GitHubUser?
    @State private var repositories: [Repository] = []
    @State private var errorMessage: String?
    @State private var isFavorite: Bool = false
    @State private var showingFavorites: Bool = false
    @State private var favoriteUsers: [String] = []
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter GitHub username.", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading)
                    
                    Button(action: fetchUser) {
                        Image(systemName: "magnifyingglass")
                            .padding()
                    }
                }
                .padding(.top)
                
                if let user = user {
                    ScrollView {
                        VStack(spacing: 16) {

                            if let url = URL(string: user.avatar_url) {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .padding(.top)
                            }
                            
                            Text(user.name ?? user.login)
                                .font(.title)
                                .bold()
                            
                            Text(user.bio ?? "")
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                            HStack(spacing: 20) {
                                StatisticView(title: "Repositories", count: user.public_repos)
                                StatisticView(title: "Followers", count: user.followers)
                                StatisticView(title: "Following", count: user.following)
                            }
                            
                            Button(action: toggleFavorite) {
                                HStack {
                                    Image(systemName: isFavorite ? "star.fill" : "star")
                                    Text(isFavorite ? "Remove favorites" : "Add to favorite")
                                }
                                .padding()
                                .background(Color.yellow)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                            }
                            
                            if !repositories.isEmpty {
                                Text("Public Repositories")
                                    .font(.headline)
                                    .padding(.top)
                                
                                ForEach(repositories) { repo in
                                    RepositoryRow(repository: repo)
                                }
                            }
                        }
                        .padding()
                    }
                } else if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    Spacer()
                }
            }
            .navigationTitle("GitHub user search")
            .navigationBarItems(trailing: Button(action: {
                favoriteUsers = GitHubAPI.shared.getFavoriteUsers()
                showingFavorites = true
            }) {
                Image(systemName: "star")
            })
            .sheet(isPresented: $showingFavorites) {
                FavoriteUsersView(usernames: $favoriteUsers, selectUser: { selectedUsername in
                    username = selectedUsername
                    fetchUser()
                    showingFavorites = false
                })
            }
        }
    }
    
    func fetchUser() {
        self.user = nil
        self.errorMessage = nil
        self.repositories = []
        self.isFavorite = GitHubAPI.shared.getFavoriteUsers().contains(username)
        
        GitHubAPI.shared.fetchUser(username: username.trimmingCharacters(in: .whitespacesAndNewlines)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self.user = user
                    fetchRepositories()
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchRepositories() {
        guard let username = user?.login else { return }
        
        GitHubAPI.shared.fetchRepositories(username: username) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let repos):
                    self.repositories = repos
                case .failure(let error):
                    print("Failed to import the repository.: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func toggleFavorite() {
        guard let username = user?.login else { return }
        if isFavorite {
            GitHubAPI.shared.removeFavoriteUser(username: username)
        } else {
            GitHubAPI.shared.addFavoriteUser(username: username)
        }
        isFavorite.toggle()
    }
}

struct StatisticView: View {
    let title: String
    let count: Int
    
    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
            Text("\(count)")
                .font(.headline)
        }
    }
}

struct RepositoryRow: View {
    let repository: Repository
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(repository.name)
                .font(.headline)
            Text(repository.description ?? "")
                .font(.subheadline)
                .foregroundColor(.gray)
            Divider()
        }
        .padding(.vertical, 4)
        .padding(.horizontal)
    }
}

struct FavoriteUsersView: View {
    @Binding var usernames: [String]
    var selectUser: (String) -> Void
    
    var body: some View {
        NavigationView {
            List(usernames, id: \.self) { username in
                Button(action: {
                    selectUser(username)
                }) {
                    Text(username)
                }
            }
            .navigationTitle("Favorite user")
        }
    }
}