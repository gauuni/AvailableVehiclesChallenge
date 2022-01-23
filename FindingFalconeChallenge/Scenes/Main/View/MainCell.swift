//
//  MainCell.swift
//  AvailableVehiclesChallenge
//
//  Created by Khoi Nguyen on 1/19/22.
//

import UIKit
import SnapKit
import RxSwift


protocol MainCellDelegate{
    func mainCell(_ cell: MainCell, didSelect type: ListType)
}

class MainCell: UICollectionViewCell {
    
    private static let textColor: UIColor = .white
    private let lblTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = textColor
        return label
    }()
    
    private let lblPlanet: UILabel = {
        let label = UILabel()
        label.textColor = textColor
        return label
    }()
    
    private let lblVehicle: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = textColor
        return label
    }()
    
    func binding(title: String?, planet: Planet?, vehicle: Vehicle?){
        lblTitle.text = title
        lblPlanet.text = planet?.name ?? "Select planet"
        lblVehicle.text = vehicle?.name ?? "Select vehicle"
    }
    
    var delegate: MainCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(lblTitle)
        lblTitle.snp.makeConstraints{
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-32)
        }
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.addArrangedSubview(lblPlanet)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(lblVehicle)
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints{
            $0.top.equalTo(lblTitle.snp.bottom).offset(16)
            $0.centerX.width.equalTo(lblTitle)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        lblPlanet.add(target: self, action: #selector(planetPressed))
        lblVehicle.add(target: self, action: #selector(vehiclePressed))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        // note: don't change the width
        newFrame.size.height = ceil(size.height)
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
    
    @IBAction private func planetPressed(){
        delegate?.mainCell(self, didSelect: .planet)
    }
    
    @IBAction private func vehiclePressed(){
        delegate?.mainCell(self, didSelect: .vehicle)
    }
    
}
