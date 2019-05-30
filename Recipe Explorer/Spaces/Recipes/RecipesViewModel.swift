//
//  RecipesViewModel.swift
//  Recipe Explorer
//
//  Created by Furqan on 2019-05-30.
//  Copyright © 2019 Furqan. All rights reserved.
//

import Foundation

protocol RecipesViewUIDelegate: class {
    /// To inform the delegate about an updated model state.
    ///
    /// - Parameter state: State of the model.
    func updated(state: ViewState)
}

enum ViewState {
    case fetching, fetched, failed(Error)
}

final class RecipesViewModel {
    
    // - MARK: Properties
    
    var uiDelegate: RecipesViewUIDelegate?
    var recipes: [Recipe] = []
    private let onRecipeSelected: (Recipe)->Void
    
    // - MARK: Initializers
    
    /// Initializes view model for RecipesViewController.
    ///
    /// - Parameter onRecipeSelected: Call back to be triggered when a Recipe is selected.
    init(onRecipeSelected: @escaping (Recipe)->Void) {
        self.onRecipeSelected = onRecipeSelected
    }
    
    // - MARK: Public methods
    
    /// To inform view model that view has loaded.
    /// View model fetches the first page of Recipes.
    func viewDidLoad() {
        fetchRecipes()
    }
    
    /// To inform the view model that a Recipe was tapped.
    /// View model executes call back for Recipe selection from coordinator.
    ///
    /// - Parameter row: Index of the Recipe tapped.
    func didSelectRecipe(at index: Int) {
        onRecipeSelected(recipes[index])
    }
    
    // - MARK: Private methods
    
    /// Sends request to fetch Recipes from the backend.
    ///
    /// - Parameter page: Value of RequestPage. Enables pagination.
    private func fetchRecipes() {
        uiDelegate?.updated(state: .fetching)
        RecipeDataProvider.fetchRecipes() { [weak self] result in
            let state: ViewState
            switch result {
            case .sucess(let recipes):
                state = .fetched
                self?.recipes += recipes
                
            case .failure(let error):
                state = .failed(error)
            }
            
            DispatchQueue.main.async {
                self?.uiDelegate?.updated(state: state)
            }
        }
    }
    
}
