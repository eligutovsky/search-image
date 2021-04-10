//
//  SearchResultDataModel.swift
//  search image
//
//  Created by Eli Gutovsky on 09/04/2021.
//

final class SearchResultsDataModel {

    private(set) var photos: [Photo] = []

    func setSearchResults(_ photos: [Photo]) {
        self.photos = photos
    }

    func appendSearchResults(_ photos: [Photo]) {
        self.photos.append(contentsOf: photos)
    }

    func reset() {
        photos = []
    }
}
