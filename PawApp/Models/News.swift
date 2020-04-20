//
//  News.swift
//  vk_GuzelGubaydullina
//
//  Created by Guzel Gubaidullina on 12.04.2020.
//  Copyright © 2020 Guzel Gubaidullina. All rights reserved.
//

import Foundation

class News {
    var isLiked: Bool = false
    
    let avatarImageName: String
    let authorName: String
    let date: String
    let newsText: String
    let newsImageName: String
    
    var likesCount: Int
    var commentsCount: Int
    var sharesCount: Int
    var viewsCount: Int
    
    init(avatarImageName: String,
         authorName: String,
         date: String = "Today 19:19",
         newsText: String,
         newsImageName: String,
         likesCount: Int = Int.random(in: 0...35),
         commentsCount: Int = Int.random(in: 0...100),
         sharesCount: Int = Int.random(in: 0...150),
         viewsCount: Int = Int.random(in: 50...1000)) {
        self.avatarImageName = avatarImageName
        self.authorName = authorName
        self.date = date
        self.newsText = newsText
        self.newsImageName = newsImageName
        self.likesCount = likesCount
        self.commentsCount = commentsCount
        self.sharesCount = sharesCount
        self.viewsCount = viewsCount
    }
}
