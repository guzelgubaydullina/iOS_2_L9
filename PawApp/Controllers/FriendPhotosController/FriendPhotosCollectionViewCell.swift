//
//  FriendsPhotosCollectionViewCell.swift
//  vk_GuzelGubaydullina
//
//  Created by Guzel Gubaidullina on 01.04.2020.
//  Copyright © 2020 Guzel Gubaidullina. All rights reserved.
//

import UIKit

class FriendPhotosCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var friendPhotoImageView: UIImageView!
    @IBOutlet weak var likesButton: LikesButton!
    
    @IBAction func actionLikesButtonTapped(_ sender: LikesButton) {
        sender.updateLikesCount()
        sender.heartImageView.pulsate()
    }
}
