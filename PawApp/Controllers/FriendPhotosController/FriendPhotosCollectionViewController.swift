//
//  FriendsPhotosCollectionViewController.swift
//  vk_GuzelGubaydullina
//
//  Created by Guzel Gubaidullina on 01.04.2020.
//  Copyright © 2020 Guzel Gubaidullina. All rights reserved.
//

import UIKit

class FriendPhotosCollectionViewController: UICollectionViewController {
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
                
        title = user?.name ?? ""
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user?.photosImageName.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendPhotosCollectionViewCell", for: indexPath) as! FriendPhotosCollectionViewCell
        
        guard let photo = user?.photosImageName[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.friendPhotoImageView.image = UIImage(named: photo)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueShowFullSizePhotos" {
            guard let viewController = segue.destination as? FullSizePhotosController,
                let photosImageName = user?.photosImageName,
                let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first else {
                    return
            }
            
            viewController.photosNames = photosImageName
            viewController.selectedPhotoIndex = selectedIndexPath.row
            
//            var user: User? = nil
//            if filteredUsers.isEmpty {
//                let sectionTitle = sectionTitles[selectedIndexPath.section]
//                user = userGroups[sectionTitle]?[selectedIndexPath.row]
//            } else {
//                user = filteredUsers[selectedIndexPath.row]
//            }
//            viewController.user = user!
        }
    }
}

extension FriendPhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width / 3) - 1,
                      height: (view.frame.size.width / 3) - 1)
    }
}
