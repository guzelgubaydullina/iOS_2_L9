//
//  LikesButton.swift
//  vk_GuzelGubaydullina
//
//  Created by Guzel Gubaidullina on 05.04.2020.
//  Copyright © 2020 Guzel Gubaidullina. All rights reserved.
//

import UIKit

class LikesButton: UIButton {
    private var isLiked = false
    var likesCountLabel: UILabel = {
        let likesCountLabel = UILabel()
        likesCountLabel.text = "\(Int.random(in: 0...100))"
        likesCountLabel.font = UIFont.systemFont(ofSize: 15,
                                                 weight: .regular)
        likesCountLabel.numberOfLines = 1
        likesCountLabel.translatesAutoresizingMaskIntoConstraints = false
        return likesCountLabel
    }()
        
    var heartImageView: UIImageView = {
        let heartImageView = UIImageView()
        heartImageView.image = UIImage(named: "icon_heart")
        heartImageView.contentMode = .scaleAspectFill
        heartImageView.tintColor = UIColor.red.withAlphaComponent(0.5)
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        return heartImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        addSubview(heartImageView)
        
        NSLayoutConstraint.activate([
            heartImageView.widthAnchor.constraint(equalToConstant: frame.size.height),
            heartImageView.heightAnchor.constraint(equalToConstant: frame.size.height),
            heartImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            heartImageView.topAnchor.constraint(equalTo: topAnchor),
            heartImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        addSubview(likesCountLabel)
        NSLayoutConstraint.activate([
            likesCountLabel.leadingAnchor.constraint(equalTo: heartImageView.trailingAnchor, constant: 8),
            likesCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            likesCountLabel.topAnchor.constraint(equalTo: topAnchor),
            likesCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func updateLikesCount() {
        var currentLikesCount = Int(likesCountLabel.text!)!
        isLiked = !isLiked
        currentLikesCount += isLiked ? 1 : -1
        currentLikesCount = max(currentLikesCount, 0)
        likesCountLabel.text = "\(currentLikesCount)"
        heartImageView.tintColor = isLiked ? UIColor.red : UIColor.red.withAlphaComponent(0.5)
    }
}
