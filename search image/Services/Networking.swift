//
//  Networking.swift
//  search image
//
//  Created by Eli Gutovsky on 09/04/2021.
//

import Foundation

final class Networking {

    private let session: URLSession

    init() {
        self.session = URLSession.shared
    }

    func perform<Response: Codable>(
        _ request: URLRequest,
        _ completion: @escaping (Result<Response, Error>) -> Void)
    {
        print(request.url!.absoluteString)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(
                    .failure(
                        CustomError.cause("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                    )
                )
                return
            }
            completion(
                Result { try JSONDecoder().decode(Response.self, from: data) }
            )
        }.resume()
    }
}
