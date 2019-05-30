//
//  RecipesCoordinator.swift
//  Recipe Explorer
//
//  Created by Furqan on 2019-05-30.
//  Copyright © 2019 Furqan. All rights reserved.
//

import UIKit

final class RecipesCoordinator {
    
    // - MARK: Properties
    
    private let navigationController: UINavigationController
    
    // - MARK: Initializers
    
    /// Initializer for recipes flow coordinator
    ///
    /// - Parameters:
    ///   - navigationController: navigation Controller
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // - MARK: Public methods
    
    /// Start view controller for the coordinator
    ///
    /// - Returns: start view controller
    func start() -> UIViewController {
        return configuredRecipesViewController()
    }
    
    // - MARK: Private methods
    
    /// Creates a configured instance of RecipesViewController.
    ///
    /// - Returns: Instance of RecipesViewController
    private func configuredRecipesViewController() -> RecipesViewController {
        let viewModel = RecipesViewModel(onRecipeSelected: { recipe in
            self.showRecipeDetails(for: recipe)
        })
        return RecipesViewController(with: viewModel)
    }
    
    /// Creates a configured instance of RecipeDetailsViewController
    /// and pushes it to the navigation controller.
    ///
    /// - Parameter recipe: Instance of recipe to configure the view controller with
    private func showRecipeDetails(for recipe: Recipe) {
        let viewModel = RecipeDetailsViewModel(with: recipe)
        let viewController = RecipeDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
