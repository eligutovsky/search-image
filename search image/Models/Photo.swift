//
//  Image.swift
//  search image
//
//  Created by Eli Gutovsky on 09/04/2021.
//

import Foundation

// MARK: - Image
struct Photo: Codable {
    let id: String
    let resultDescription: String?
    let urls: Urls
    let likes: Int
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case resultDescription = "description"
        case urls, likes
        case user
    }
}
