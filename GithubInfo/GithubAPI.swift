//
// GithubAPI.swift
//
// Created by Speedyfriend67 on 14.10.24
//
 
import Foundation

struct Repository: Codable, Identifiable {
    let id: Int
    let name: String
    let html_url: String
    let description: String?
}

class GitHubAPI {
    static let shared = GitHubAPI()
    
    private var favoriteUsers: [String] = []
    
    func fetchUser(username: String, completion: @escaping (Result<GitHubUser, Error>) -> Void) {
        let urlString = "https://api.github.com/users/\(username)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Wrong URL.", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.setValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "There is no data.", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(GitHubUser.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchRepositories(username: String, completion: @escaping (Result<[Repository], Error>) -> Void) {
        let urlString = "https://api.github.com/users/\(username)/repos"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Wrong URL.", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.setValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "There is no data.", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let repos = try decoder.decode([Repository].self, from: data)
                completion(.success(repos))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
   
    func addFavoriteUser(username: String) {
        if !favoriteUsers.contains(username) {
            favoriteUsers.append(username)
        }
    }
    
    func removeFavoriteUser(username: String) {
        favoriteUsers.removeAll { $0 == username }
    }
   
    func getFavoriteUsers() -> [String] {
        return favoriteUsers
    }
}