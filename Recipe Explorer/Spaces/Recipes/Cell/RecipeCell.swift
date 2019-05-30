//
//  RecipeCell.swift
//  Recipe Explorer
//
//  Created by Furqan on 2019-05-30.
//  Copyright © 2019 Furqan. All rights reserved.
//

import UIKit
import SDWebImage

class RecipeCell: UITableViewCell {

    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundifyProfileImageView()
    }
    
    /// Sets up the UI of the cell using Recipe.
    ///
    /// - Parameter recipe: Instance of `Recipe` object.
    func setup(with recipe: Recipe) {
        titleLabel.text = recipe.title
        recipeImageView.sd_setImage(with: recipe.imageURL, placeholderImage: #imageLiteral(resourceName: "food_placeholder"))
    }
    
    /// Makes the shape of the profile image view circular.
    private func roundifyProfileImageView() {
        let dimension = min(recipeImageView.frame.width, recipeImageView.frame.height)
        recipeImageView.layer.cornerRadius = dimension / 2
        recipeImageView.layer.masksToBounds = true
    }
    
}
