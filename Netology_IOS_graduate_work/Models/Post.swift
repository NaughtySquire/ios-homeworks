//
//  Post.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 28.04.2022.
//

import Foundation
public struct Post{
    public var title: String
    public var author: String
    public var description: String
    public var imageName: String
    public var likes: Int
    public var views: Int
    public init(title: String = "", author: String = "", description: String = "", imageName: String = "", likes: Int = 0, views: Int = 0) {
        self.title = title
        self.author = author
        self.description = description
        self.imageName = imageName
        self.likes = likes
        self.views = views
    }
}
