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
    
    private static let spaceId = "kk2bw5ojx476"
    private static let environmentId = "master"
    private static let contentType = "recipe"
    private static let accessToken = "7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c"
    
    /// Requests reviews.
    ///
    /// - Parameter onComplete: call back with a list of reviews.
    static func fetchRecipes(onComplete: @escaping (RecipeResult)->Void) {

        // Retain the client as a property on a type you define so that
        // the client's asynchronous network callbacks are executed.
        let client = Client(spaceId: spaceId,
                            environmentId: environmentId,
                            accessToken: accessToken)
        
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
