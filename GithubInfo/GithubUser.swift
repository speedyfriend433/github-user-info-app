//
// GithubUser.swift
//
// Created by Speedyfriend67 on 14.10.24
//
 
import Foundation

struct GitHubUser: Codable {
    let login: String
    let avatar_url: String
    let name: String?
    let company: String?
    let blog: String?
    let location: String?
    let email: String?
    let bio: String?
    let public_repos: Int
    let followers: Int
    let following: Int
}