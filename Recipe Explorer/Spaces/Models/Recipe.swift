//
//  Recipe.swift
//  Recipe Explorer
//
//  Created by Furqan on 2019-05-30.
//  Copyright © 2019 Furqan. All rights reserved.
//

import Foundation

struct Recipe: Decodable {
    let title: String
    let description: String
    let tags: [String]
    let imageUrl: String?
    let chefName: String?
}
