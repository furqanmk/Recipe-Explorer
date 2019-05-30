//
//  RecipeDetailsViewModel.swift
//  Recipe Explorer
//
//  Created by Furqan on 2019-05-30.
//  Copyright © 2019 Furqan. All rights reserved.
//

import Foundation

final class RecipeDetailsViewModel {
    
    // - MARK: Private properties
    
    private let recipe: Recipe
    
    // - MARK: Initializers
    
    /// Initializes view model for RecipeDetailsViewController
    ///
    /// - Parameter Recipe: Instance of a Recipe object.
    init(with recipe: Recipe) {
        self.recipe = recipe
    }
    
    // - MARK: Public properties
    
    var title: String? {
        return recipe.title
    }
    
    var description: String? {
        return recipe.description
    }
    
    var chefName: String? {
        return recipe.chefName
    }
    
    var tags: [String] {
        return recipe.tags
    }
    
    var imageUrl: URL? {        
        return recipe.imageURL
    }
    
}
