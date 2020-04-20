//
//  User.swift
//  vk_GuzelGubaydullina
//
//  Created by Guzel Gubaidullina on 02.04.2020.
//  Copyright © 2020 Guzel Gubaidullina. All rights reserved.
//

import Foundation

enum MaritalStatus {
    case married
    case divorced
    case single
    case activelyLooking
}

enum LifeStatus {
    case working
    case housewife
    case schoolboy
    case schoolgirl
    case baby
    case pensioner
}

class User {
    var name: String
    var age: Int
    var numberOfFollowers: Int
    var maritalStatus: MaritalStatus
    var lifeStatus: LifeStatus
    var avatarImageName: String
    var photosImageName: [String]
    
    init(name: String,
         age: Int,
         numberOfFollowers: Int,
         maritalStatus: MaritalStatus,
         lifeStatus: LifeStatus,
         avatarImageName: String,
         photosImageName: [String] = [String]()) {
        self.name = name
        self.age = age
        self.numberOfFollowers = numberOfFollowers
        self.maritalStatus = maritalStatus
        self.lifeStatus = lifeStatus
        self.avatarImageName = avatarImageName
        self.photosImageName = photosImageName
    }
}
