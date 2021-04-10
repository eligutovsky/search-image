//
//  CustomError.swift
//  search image
//
//  Created by Eli Gutovsky on 09/04/2021.
//

import Foundation

enum CustomError: LocalizedError {
    case cause(String)

    var errorDescription: String {
        switch self {
        case let .cause(text):
            return text
        }
    }
}
