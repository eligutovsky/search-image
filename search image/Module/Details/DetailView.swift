//
//  DetailView.swift
//  search image
//
//  Created by Eli Gutovsky on 09/04/2021.
//

import UIKit
import SDWebImage

class DetailView: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageDescription: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var likes: UILabel!

    private var model: Photo?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Image Detail"
        guard let model = model else { return }
        imageDescription.text = model.resultDescription
        name.text = model.user.name
        nickname.text = model.user.username
        bio.text = model.user.bio
        likes.text = String(model.likes)
        avatar.sd_setImage(with: model.user.profileImage.medium)
        image.sd_setImage(with: model.urls.small)
    }

    func setup(_ model: Photo) {
        self.model = model
    }
}
