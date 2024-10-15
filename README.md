# GitHub User Info App

A beautiful and functional SwiftUI application that fetches and displays GitHub user information. This app allows users to search for GitHub profiles, view detailed user information, browse repositories, and manage favorite users for quick access.

## Features

- **Search GitHub Users**: Enter a GitHub username to fetch and display user profile information.
- **User Profile Display**: View detailed information including avatar, name, bio, followers, following, and public repositories count.
- **Repositories List**: Browse the user's public repositories with names and descriptions.
- **Favorites Management**: Add users to favorites for quick access and manage your favorite users list.
- **Responsive UI**: Clean and intuitive user interface with support for both Light and Dark modes.
- **Asynchronous Image Loading**: Efficiently load and display user avatars using `AsyncImage`.
- **Error Handling**: User-friendly error messages for network issues or invalid usernames.

## Screenshots

*Note: Replace the placeholders with actual screenshots when available.*

![Home Screen](https://github.com/user-attachments/assets/ec557092-bfe2-4a7c-b23d-7a00f3c18049)
*Home Screen with Search Functionality*

![User Profile](https://github.com/user-attachments/assets/62b071b7-731d-41d3-91e2-81671ddddb3c)
*User Profile Display with User Details*

![Repositories List](https://github.com/user-attachments/assets/f707f310-03c3-4f2f-b35b-b672d7af410b)
*List of User's Public Repositories*

![Favorites List](https://github.com/user-attachments/assets/0055ed76-905a-4ed5-b5de-3792742391b5)
*Favorites Management Screen*

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.3+

## Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/speedyfriend433/github-user-info-app.git
   ```

2. **Open the Project**

   - Navigate to the cloned directory.
   - Open `GitHubUserInfoApp.xcodeproj` with Xcode.

3. **Build and Run**

   - Select the desired simulator or device.
   - Click on the **Run** button or press `Command + R`.

## Usage

1. **Search for a User**

   - Enter a GitHub username in the search field.
   - Press the search icon to fetch user information.

2. **View User Profile**

   - View the user's avatar, name, bio, and statistics.
   - Browse through the list of public repositories.

3. **Manage Favorites**

   - Tap on the **Add to Favorites** button to save a user.
   - Access your favorite users by tapping the star icon in the navigation bar.
   - Select a favorite user to quickly view their profile.

4. **Dark Mode Support**

   - The app automatically adapts to the system's appearance settings.
   - Experience a seamless UI in both Light and Dark modes.

## Project Structure

- **Models**
  - `GitHubUser.swift`: Defines the `GitHubUser` data model conforming to `Codable`.
  - `Repository.swift`: Defines the `Repository` data model for user repositories.

- **ViewModels**
  - `GitHubAPI.swift`: Handles API requests to GitHub and manages favorite users.

- **Views**
  - `ContentView.swift`: The main view containing the search functionality and user profile display.
  - `StatisticView.swift`: A reusable component to display user statistics.
  - `RepositoryRow.swift`: Displays individual repository information.
  - `FavoriteUsersView.swift`: Manages and displays the list of favorite users.

## API Rate Limiting

- **Note**: Unauthenticated requests to GitHub API are limited to 60 requests per hour.
- **Recommendation**: For higher rate limits, consider implementing OAuth authentication with GitHub.

## Contributing

Contributions are welcome! Please follow these steps:

1. **Fork the Repository**
2. **Create a Feature Branch**

   ```bash
   git checkout -b feature/YourFeature
   ```

3. **Commit Your Changes**

   ```bash
   git commit -m "Add YourFeature"
   ```

4. **Push to the Branch**

   ```bash
   git push origin feature/YourFeature
   ```

5. **Open a Pull Request**

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

- **GitHub**: [speedyfriend433](https://github.com/speedyfriend433)
- **Email**: speedyfriend433@gmail.com

## Acknowledgments

- **GitHub API**: For providing the public API to fetch user data.
- **SwiftUI**: For the powerful UI framework.
- **Community**: Thanks to all the contributors and users for their support.

---

Feel free to customize this README file by adding actual screenshots, updating contact information, and including any additional sections that are relevant to your project.
