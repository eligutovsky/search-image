//
//  User.swift
//  search image
//
//  Created by Eli Gutovsky on 09/04/2021.
//

import Foundation

// MARK: - User
struct User: Codable {
    let id: String
    let username, name, firstName: String
    let lastName: String?
    let bio: String?
    let links: UserLinks
    let profileImage: ProfileImage

    enum CodingKeys: String, CodingKey {
        case id
        case username, name
        case firstName = "first_name"
        case lastName = "last_name"
        case bio, links
        case profileImage = "profile_image"
    }
}

// MARK: - UserLinks
struct UserLinks: Codable {
    let linksSelf, html, photos, likes: String
    let portfolio, following, followers: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes, portfolio, following, followers
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small, medium, large: URL
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small, thumb: URL
}
