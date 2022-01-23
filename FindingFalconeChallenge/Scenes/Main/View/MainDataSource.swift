//
//  MainDataSource.swift
//  FindingFalconeChallenge
//
//  Created by Khoi Nguyen on 1/24/22.
//

import Foundation
import IGListKit

class MainDataSource: NSObject, ListAdapterDataSource{

    var data: [Destination] = []
    
    // MARK: ListAdapterDataSource
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data as [ListDiffable]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        let sectionController = MainSectionController()
//        sectionController.delegate = self
        return sectionController
        
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}
