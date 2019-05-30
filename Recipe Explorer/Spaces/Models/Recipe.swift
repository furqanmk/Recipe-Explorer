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
    
    let entry: Entry
    
    init(with entry: Entry) {
        self.entry = entry
    }
    
    var title: String? {
        return entry.fields["title"] as? String
    }
    
    var description: String? {
        return entry.fields["description"] as? String
    }
    
    var calories: Int? {
        return entry.fields["calories"] as? Int
    }
    
    var tags: [String] {
        guard let tags = entry.fields.linkedEntries(at: "tags") else {
            return []
        }
        return tags.compactMap { $0.fields["name"] as? String }
    }

    var chefName: String? {
        guard let chef = entry.fields.linkedEntry(at: "chef") else {
            return nil
        }
        return chef.fields["name"] as? String
    }

    var imageURL: URL? {
        guard let image = entry.fields.linkedAsset(at: "photo") else {
            return nil
        }
        return image.url
    }

}
