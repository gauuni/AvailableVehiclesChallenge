//
//  MainCell.swift
//  AvailableVehiclesChallenge
//
//  Created by Khoi Nguyen on 1/19/22.
//

import UIKit
import SnapKit
import RxSwift

typealias MainCellData = (title: String?, planet: Planet?, vehicle: Vehicle?)

class MainCell: UITableViewCell {

    private let lblTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let lblPlanet: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let lblVehicle: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    let pPlanet = PublishSubject<MainCell>()
    let pVehicle = PublishSubject<MainCell>()
    
    var data: MainCellData?{
        didSet{
            guard let data = data
            else{ return }
            lblTitle.text = data.title
            lblPlanet.text = data.planet?.name ?? "Select planet"
            lblVehicle.text = data.vehicle?.name ?? "Select vehicle"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction private func planetPressed(){
        pPlanet.onNext(self)
    }

    @IBAction private func vehiclePressed(){
        pVehicle.onNext(self)
    }
    
}
