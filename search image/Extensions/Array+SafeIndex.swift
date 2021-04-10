//
//  Array+SafeIndex.swift
//  search image
//
//  Created by Eli Gutovsky on 09/04/2021.
//

extension Array {

    subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }

}

