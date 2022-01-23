//
//  MainViewControllerTests.swift
//  FindingFalconeChallengeTests
//
//  Created by Khoi Nguyen on 1/24/22.
//

import XCTest
import IGListKit

@testable import FindingFalconeChallenge

class MainViewControllerTests: XCTestCase {

    var model: MainModel!
    var viewController: MainViewController!
    var viewModel: MainViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        model = MainModel()
        viewModel = MainViewModel(model: model)
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
        viewController.setup(viewModel: viewModel)

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
        viewModel = nil
        model = nil
    }

    func testInitializeDataToAdapter() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        viewModel.initializeData()
        viewController.adapter.dataSource = viewController
        viewController.adapter.collectionView = viewController.collectionView
 
        viewController.adapter.performUpdates(animated: true, completion: nil)
        XCTAssertEqual(viewController.adapter.collectionView!.numberOfSections, 4)
    }


}
