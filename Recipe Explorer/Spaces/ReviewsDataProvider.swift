//
//  RecipeDataProvider.swift
//  Recipe Explorer
//
//  Created by Furqan on 2019-05-30.
//  Copyright © 2019 Furqan. All rights reserved.
//

import Foundation
import Contentful

enum FetchError: Error {
    case invalidUrl
    case noData
    case parsingFailed
}

final class RecipeDataProvider {
    
    enum RecipeResult {
        case sucess([Recipe])
        case failure(Error)
    }
    
    /// Requests recipes.
    ///
    /// - Parameter onComplete: call back with a list of reviews.
    static func fetchRecipes(onComplete: @escaping (RecipeResult)->Void) {

        let contentType = "recipe"
        let client = Client(spaceId: Configuration.contentfulSpaceId(),
                            environmentId: Configuration.contentfulEnvironmentId(),
                            accessToken: Configuration.contentfulAccessToken())
        let query = Query.where(contentTypeId: contentType)
        
        client.fetchArray(of: Entry.self, matching: query) { (result: Result<ArrayResponse<Entry>>) in
            switch result {
            case .success(let arrayResponse):
                let entries = arrayResponse.items
                onComplete(.sucess(entries.map(Recipe.init)))
            case .error(let error):
                onComplete(.failure(error))
            }
        }
    }
}
