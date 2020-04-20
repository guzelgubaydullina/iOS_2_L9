//
//  FullSizePhotosController.swift
//  PawApp
//
//  Created by Guzel Gubaidullina on 19.04.2020.
//  Copyright © 2020 Guzel Gubaidullina. All rights reserved.
//

import UIKit

enum PanGestureDirection {
    case unknown
    case left
    case right
}

class FullSizePhotosController: UIViewController {
    @IBOutlet weak var photoImageView1: UIImageView!
    @IBOutlet weak var photoImageView2: UIImageView!
    
    private let transformZero = CGAffineTransform(scaleX: 0.0, y: 0.0)
    private let transformIncrease = CGAffineTransform(scaleX: 1.15, y: 1.15)
    private let transformDecrease = CGAffineTransform(scaleX: 1.0, y: 1.0)
    private let transformIdentity = CGAffineTransform.identity
    
    private var panGesture: UIPanGestureRecognizer!
    private var currentPanGestureDirection: PanGestureDirection = .unknown
    
    private weak var currentImageView: UIImageView!
    private weak var nextImageView: UIImageView!
    
    var photosNames: [String] = []
    
    var selectedPhotoIndex: Int!
    private var nextPhotoIndex: Int {
        var photoIndex = 0
        if  currentPanGestureDirection == .unknown ||
            currentPanGestureDirection == .left {
            photoIndex = selectedPhotoIndex + 1
            photoIndex = min(photoIndex, photosNames.count - 1)
        } else if currentPanGestureDirection == .right {
            photoIndex = selectedPhotoIndex - 1
            photoIndex = max(photoIndex, 0)
        }
        return photoIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        configureViewController()
    }
    
    private func configureViewController() {
        currentImageView = photoImageView1
        nextImageView = photoImageView2
        
        nextImageView.alpha = 0
        nextImageView.transform = transformZero
        
        currentImageView.image = UIImage(named: photosNames[selectedPhotoIndex])
        nextImageView.image = UIImage(named: photosNames[nextPhotoIndex])
        
        if photosNames.count > 1 {
            panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
            panGesture.minimumNumberOfTouches = 1
            panGesture.maximumNumberOfTouches = 1
            currentImageView.addGestureRecognizer(panGesture)
        }
    }
    
    // MARK: - UIPanGestureRecognizer
    
    @objc private func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animatePhotoWithTransform(transformIncrease)
        case .changed:
            let translation = recognizer.translation(in: currentImageView)
            currentPanGestureDirection = translation.x > 0 ? .right : .left
            animatePhotoImageViewChanged(with: translation)
        case .ended:
            animatePhotoImageViewEnd()
        default: return
        }
    }
    
    // MARK: - Animations
        
    private func animatePhotoWithTransform(_ transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.3) {
            self.currentImageView.transform = transform
        }
    }
    
    private func animatePhotoImageViewChanged(with translation: CGPoint) {
        currentImageView.transform = CGAffineTransform(translationX: translation.x, y: 0).concatenating(transformIncrease)
    }
    
    private func animatePhotoImageViewEnd()  {
        if currentPanGestureDirection == .left {
            let isLast = selectedPhotoIndex == photosNames.count - 1
            if currentImageView.frame.maxX < view.center.x && !isLast {
                animatePhotoSwapping()
            } else {
                animatePhotoWithTransform(transformIdentity)
            }
        } else if currentPanGestureDirection == .right {
            let isLast = selectedPhotoIndex == 0
            if currentImageView.frame.minX > view.center.x && !isLast {
                animatePhotoSwapping()
            } else {
                animatePhotoWithTransform(transformIdentity)
            }
        }
    }
    
    private func animatePhotoSwapping() {
        self.nextImageView.image = UIImage(named: photosNames[nextPhotoIndex])

        UIView.animate(withDuration: 0.5,
                       animations: {
                        self.currentImageView.alpha = 0
                        self.nextImageView.alpha = 1
                        self.nextImageView.transform = .identity
        }, completion: { finished in
            self.reconfigureImages()
        })
    }
    
    private func reconfigureImages() {
        selectedPhotoIndex = nextPhotoIndex
        
        currentImageView.transform = transformZero
        currentImageView.removeGestureRecognizer(panGesture)
        nextImageView.addGestureRecognizer(panGesture)
        
        if currentImageView == photoImageView1 {
            currentImageView = photoImageView2
            nextImageView = photoImageView1
        } else if currentImageView == photoImageView2 {
            currentImageView = photoImageView1
            nextImageView = photoImageView2
        }
    }
}
