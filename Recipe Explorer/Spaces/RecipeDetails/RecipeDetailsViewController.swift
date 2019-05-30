//
//  RecipeDetailsViewController.swift
//  Recipe Explorer
//
//  Created by Furqan on 2019-05-30.
//  Copyright © 2019 Furqan. All rights reserved.
//

import UIKit
import SDWebImage

class RecipeDetailsViewController: UIViewController {
    
    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var chefNameLabel: UILabel!
    @IBOutlet private weak var tagsLabel: UILabel!
    
    private let viewModel: RecipeDetailsViewModel
    
    /// Initalizes view controller with an instance of view model.
    ///
    /// - Parameter viewModel: Instance of RecipeDetailsViewModel.
    init(viewModel: RecipeDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    /// Assigns values to UI elements from the view model.
    private func setupUI() {
        title = "Recipe Details"
        
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        chefNameLabel.text = viewModel.chefName
        tagsLabel.text = viewModel.tags.joined(separator: ", ")
        
        recipeImageView.sd_setImage(with: viewModel.imageUrl, placeholderImage: #imageLiteral(resourceName: "food_placeholder"))
    }
    
}
