//
//  Recipe.swift
//  Recipe Explorer
//
//  Created by Furqan on 2019-05-30.
//  Copyright © 2019 Furqan. All rights reserved.
//

import Foundation
import Contentful

struct Recipe {
    
    let title: String?
    let description: String?
    let tags: [String]
    let chefName: String?
    let imageURL: URL?
    
    init(title: String?,
         description: String?,
         chefName: String?,
         imageURL: URL?,
         tags: [String]) {
        self.title = title
        self.description = description
        self.chefName = chefName
        self.imageURL = imageURL
        self.tags = tags
    }
    
    init(with entry: Entry) {
        let title = entry.fields["title"] as? String
        let description = entry.fields["description"] as? String
        let chefName = entry.fields.linkedEntry(at: "chef")?.fields["name"] as? String
        let imageURL = entry.fields.linkedAsset(at: "photo")?.url
        let tags: [String]
        if let tagEntries = entry.fields.linkedEntries(at: "tags") {
            tags = tagEntries.compactMap { $0.fields["name"] as? String }
        } else {
            tags = []
        }
        self.init(title: title, description: description, chefName: chefName, imageURL: imageURL, tags: tags)
    }
    
}
