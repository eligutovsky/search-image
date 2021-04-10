//
//  SearchResponse.swift
//  search image
//
//  Created by Eli Gutovsky on 09/04/2021.
//

struct SearchResponse: Codable {
    let total, totalPages: Int
    let results: [Photo]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}
