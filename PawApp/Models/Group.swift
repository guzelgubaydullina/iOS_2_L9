//
//  Group.swift
//  vk_GuzelGubaydullina
//
//  Created by Guzel Gubaidullina on 02.04.2020.
//  Copyright © 2020 Guzel Gubaidullina. All rights reserved.
//

import Foundation

enum GroupType {
    case opened
    case closed
}

enum GroupTheme {
    case unknown
    case education
    case hobby
    case travel
    case sport
    case news
}

class Group {
    var name: String
    var type: GroupType
    var theme: GroupTheme
    var avatarImageName: String
    var numberOfFollowers: Int
    
    init(name: String,
         type: GroupType = .opened,
         theme: GroupTheme = .unknown,
         avatarImageName: String,
         numberOfFollowers: Int = 0) {
        self.name = name
        self.type = type
        self.theme = theme
        self.avatarImageName = avatarImageName
        self.numberOfFollowers = numberOfFollowers

    }
}

extension Group: Equatable {
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.name == rhs.name
    }
}
