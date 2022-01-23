//
//  MainSectionController.swift
//  AvailableVehiclesChallenge
//
//  Created by Nguyen Khoi Nguyen on 1/20/22.
//

import IGListKit
import RxSwift

protocol MainSectionControllerDelegate {
    func mainSectionController(_ sectionController: MainSectionController, didSelect type: ListType)
}

class MainSectionController: ListSectionController {
    var data: Destination!
    var delegate: MainSectionControllerDelegate?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
    }
}

// MARK: - Data Provider
extension MainSectionController {
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        
        let width: CGFloat = collectionContext?.containerSize.width ?? 0
        return CGSize(width: width, height: 88)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext?.dequeueReusableCell(of: MainCell.self,
                                                          for: self,
                                                          at: index) as! MainCell
        cell.binding(title: "Destination \(data.id)",
                     planet: data.planet,
                     vehicle: data.vehicle)
        cell.delegate = self
        return cell
    }
    
    override func didUpdate(to object: Any) {
        data = object as? Destination
    }
    
    override func didSelectItem(at index: Int) {
        
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) {}
}

extension MainSectionController: MainCellDelegate{
    func mainCell(_ cell: MainCell, didSelect type: ListType) {
        delegate?.mainSectionController(self, didSelect: type)
    }
}
