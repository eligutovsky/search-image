//
//  SearchService.swift
//  search image
//
//  Created by Eli Gutovsky on 09/04/2021.
//

import Foundation

final class SearchService {

    private let networking: Networking
    private let requestBuidler: URLRequestBuilder

    init(networking: Networking,
         requestBuidler: URLRequestBuilder) {
        self.networking = networking
        self.requestBuidler = requestBuidler
    }

    func fetchSearchResult(_ request: SearchRequest, _ completion: @escaping (Result<SearchResponse, Error>) -> Void) throws {
        let request = try requestBuidler.buildSearchImageURLRequest(request)
        networking.perform(request, completion)
    }

}

final class URLRequestBuilder {

    func buildSearchImageURLRequest(_ request: SearchRequest) throws -> URLRequest {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = API.host
        urlComponent.path = "/search/photos"
        urlComponent.queryItems = [
            URLQueryItem(name: "client_id", value: API.clientID),
            URLQueryItem(name: "page", value: String(request.page)),
            URLQueryItem(name: "query", value: request.query),
            URLQueryItem(name: "per_page", value: "20")
        ]
        guard let url = urlComponent.url else {
            throw CustomError.cause("Unable to build url")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }

}
