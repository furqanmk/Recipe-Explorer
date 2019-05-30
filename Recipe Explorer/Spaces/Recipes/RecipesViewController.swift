//
//  RecipesViewController.swift
//  Recipe Explorer
//
//  Created by Furqan on 2019-05-30.
//  Copyright © 2019 Furqan. All rights reserved.
//

import UIKit

class RecipesViewController: UITableViewController {
    
    private let viewModel: RecipesViewModel
    private let RecipeCellReuseId = "RecipeCell"
    
    init(with viewModel: RecipesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.uiDelegate = self
        viewModel.viewDidLoad()
        
        // Set the title on the navigation bar
        title = "Tempelhof Recipes"
        // Register RecipeCell nib on the tableView
        tableView.register(UINib(nibName: RecipeCell.className, bundle: nil),
                           forCellReuseIdentifier: RecipeCell.className)
        // Enable automatic height on cells
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.className, for: indexPath) as? RecipeCell else {
            return UITableViewCell()
        }
        cell.setup(with: viewModel.recipes[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRecipe(at: indexPath.row)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Detects when user scrolls to the bottom of the table view
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height) {
            viewModel.didReachPageEnd()
        }
    }
    
}

extension RecipesViewController: RecipesViewUIDelegate {
    
    func updated(state: ViewState) {
        switch state {
        case .fetching:
            let activityIndicatorFrame = CGRect(origin: .zero, size: CGSize(width: tableView.bounds.width, height: 44))
            let indicatorFooter = UIActivityIndicatorView(frame: activityIndicatorFrame)
            indicatorFooter.color = .gray
            indicatorFooter.startAnimating()
            tableView.tableFooterView = indicatorFooter
        case .fetched:
            tableView.reloadData()
            tableView.tableFooterView = nil
        case .failed(let error):
            present(UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert),
                    animated: true)
            tableView.tableFooterView = nil
        }
    }
    
}
