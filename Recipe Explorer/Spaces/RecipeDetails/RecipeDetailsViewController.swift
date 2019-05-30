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
        title = viewModel.title
        descriptionLabel.text = viewModel.description
        chefNameLabel.text = viewModel.chefName
        tagsLabel.text = viewModel.tags.joined(separator: ", ")
        
        recipeImageView.image = #imageLiteral(resourceName: "food_placeholder")
        if let imageUrl = viewModel.imageUrl {
            recipeImageView.sd_setImage(with: imageUrl)
        }
        roundifyProfileImageView()
    }
    
    /// Makes the shape of the profile image view circular.
    private func roundifyProfileImageView() {
        let dimension = min(recipeImageView.frame.width, recipeImageView.frame.height)
        recipeImageView.layer.cornerRadius = dimension / 2
        recipeImageView.layer.masksToBounds = true
    }
    
}
