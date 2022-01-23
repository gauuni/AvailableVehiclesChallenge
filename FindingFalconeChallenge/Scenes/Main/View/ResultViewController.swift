//
//  ResultViewController.swift
//  FindingFalconeChallenge
//
//  Created by Khoi Nguyen on 1/22/22.
//

import UIKit
import SnapKit
import RxSwift

class ResultViewController: BaseViewController {

    private let btnStartAgain: UIButton = {
        let button = UIButton()
        button.setTitle("Start Again", for: .normal)
        button.setBorder(borderWidth: 1, borderColor: .white, cornerRadius: 8)
        return button
    }()
    
    private let imgViewBg: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.image = UIImage(named: "bg_Result")
        return imgView
    }()
    
    private let lblResult: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        return label
    }()
    
    let pStartAgain = PublishSubject<Void>()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    var result: FindResult!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    

    private func setupView(){
        view.addSubview(imgViewBg)
        imgViewBg.snp.makeConstraints{
            $0.center.width.height.equalToSuperview()
        }
        
        view.addSubview(lblResult)
        lblResult.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().offset(64)
//            $0.height.lessThanOrEqualToSuperview().multipliedBy(0.8)
        }
        
        btnStartAgain.addTarget(self, action: #selector(startAgainPressed), for: .touchUpInside)
        view.addSubview(btnStartAgain)
        btnStartAgain.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.width.greaterThanOrEqualTo(120)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().offset(32)
        }

        var resultStr = ""
        
        guard let status = result.status?.lowercased()
        else{ return }
        
        switch status{
        case "success":
            if let planetName = result.planetName{
                resultStr = "Success! Congratulations on Finding Falcone. King Shan is mighty please"
                resultStr.append("\n\n")
                resultStr.append("Time taken: \(result.takenTime)")
                resultStr.append("\nPlanet found: \(planetName)")
            }
        case "false":
            resultStr = "Mission failed!!!"
        default:
            resultStr = "Cannot define"
        }
        
        lblResult.text = resultStr

    }
    
    @IBAction private func startAgainPressed(){
        pStartAgain.onNext(())
        pStartAgain.onCompleted()
        self.navigationController?.popViewController(animated: true)
    }

}
