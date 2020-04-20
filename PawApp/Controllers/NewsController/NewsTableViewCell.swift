//
//  NewsTableViewCell.swift
//  vk_GuzelGubaydullina
//
//  Created by Guzel Gubaidullina on 12.04.2020.
//  Copyright © 2020 Guzel Gubaidullina. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    var news: News?
    
    @IBOutlet weak var authorImageView: RoundedImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var sharesCountLabel: UILabel!
    @IBOutlet weak var viewsCountLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        
        authorImageView.image = nil
        authorLabel.text = nil
        dateLabel.text = nil
        
        newsTextLabel.text = nil
        newsImageView.image = nil
        
        likesCountLabel.text = nil
        commentsCountLabel.text = nil
        sharesCountLabel.text = nil
        viewsCountLabel.text = nil
    }
    
    func configure(with news: News) {
        self.news = news
        
        authorImageView.image = UIImage(named: news.avatarImageName)
        authorLabel.text = news.authorName
        dateLabel.text = news.date
        
        newsTextLabel.text = news.newsText
        newsImageView.image = UIImage(named: news.newsImageName)
        
        likeButton.tintColor = news.isLiked ? UIColor.red : UIColor.red.withAlphaComponent(0.5)
        likesCountLabel.text = "\(news.likesCount)"
        commentsCountLabel.text = "\(news.commentsCount)"
        sharesCountLabel.text = "\(news.sharesCount)"
        viewsCountLabel.text = "\(news.viewsCount)"
        
        news.viewsCount += 1
    }

    @IBAction func actionLikesButtonTapped(_ sender: UIButton) {
        guard let news = news else {
            return
        }
        news.isLiked = !news.isLiked
        news.likesCount += news.isLiked ? 1 : -1
        news.likesCount = max(news.likesCount, 0)
        likeButton.pulsate()
        likeButton.tintColor = news.isLiked ? UIColor.red : UIColor.red.withAlphaComponent(0.5)
        likesCountLabel.text = "\(news.likesCount)"
    }
        
    @IBAction func actionCommentButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func actionShareButtonTapped(_ sender: UIButton) {
        
    }
}

