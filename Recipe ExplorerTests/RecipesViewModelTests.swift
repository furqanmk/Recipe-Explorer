//
//  RecipesViewModelTests.swift
//  Recipe ExplorerTests
//
//  Created by Furqan on 2019-05-30.
//  Copyright © 2019 Furqan. All rights reserved.
//

import XCTest
@testable import Recipe_Explorer

class RecipesViewModelTests: XCTestCase {
    
    private var uiDelegate: RecipesViewUIDelegateMock!
    private var viewModel: RecipesViewModel!
    private var onRecipeSelectedCalled = false

    override func setUp() {
        super.setUp()
        
        setupObjects()
    }
    
    func testFetchSuccessful() {
        let expectation = self.expectation(description: "Fetch")
        uiDelegate.expectation = expectation
        RecipeDataProviderMock.shouldSucceed = true
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(uiDelegate.fetchSuccessful)
    }
    
    func testFetchFailed() {
        let expectation = self.expectation(description: "Fetch")
        uiDelegate.expectation = expectation
        RecipeDataProviderMock.shouldSucceed = false
        viewModel.viewDidLoad()
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertFalse(uiDelegate.fetchSuccessful)
    }
    
    private func setupObjects() {
        self.uiDelegate = RecipesViewUIDelegateMock()
        
        onRecipeSelectedCalled = false
        let onRecipeSelected: (Recipe)->() = { [weak self] response in
            self?.onRecipeSelectedCalled = true
        }
        
        viewModel = RecipesViewModel(dataProvider: RecipeDataProviderMock.self,
                                     onRecipeSelected: onRecipeSelected)
        viewModel.uiDelegate = uiDelegate
    }
}

class RecipeDataProviderMock: RecipeDataProvider {
    static var shouldSucceed = true
    
    override class func fetchRecipes(onComplete: @escaping (Response)->Void) {
        if shouldSucceed {
            onComplete(.sucess([Recipe(title: "",
                                       description: "",
                                       chefName: "",
                                       imageURL: nil,
                                       tags: [])]))
        } else {
            onComplete(.failure(NSError()))
        }
    }
}

class RecipesViewUIDelegateMock: RecipesViewUIDelegate {
    var expectation: XCTestExpectation!
    var fetchSuccessful: Bool!
    
    func updated(state: ViewState) {
        switch state {
        case .fetched:
            fetchSuccessful = true
            expectation.fulfill()
        case .failed(_):
            fetchSuccessful = false
            expectation.fulfill()
        default:
            return
        }
    }
}
