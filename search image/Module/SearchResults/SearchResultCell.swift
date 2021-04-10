//
//  SearchResultCell.swift
//  search image
//
//  Created by Eli Gutovsky on 09/04/2021.
//

import UIKit
import SDWebImage

class SearchResultCell: UITableViewCell {

    static let reuseIdentifier = String(describing: SearchResultCell.self)

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        cellImage.contentMode = .scaleAspectFill
        cellImage.layer.cornerRadius = cellImage.bounds.height / 2
        cellImage.layer.masksToBounds = true
    }

    override func prepareForReuse() {
        cellImage.image = nil
        cellLabel.text = nil
        super.prepareForReuse()
    }

    func setup(_ photo: Photo) {
        cellImage.sd_setImage(with: photo.urls.thumb)
        cellLabel.text = photo.resultDescription
    }
    
}
