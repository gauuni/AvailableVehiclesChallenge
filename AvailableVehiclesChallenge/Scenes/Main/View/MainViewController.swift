//
//  ViewController.swift
//  AvailableVehiclesChallenge
//
//  Created by Khoi Nguyen on 1/17/22.
//

import UIKit
import RxSwift
import SnapKit
import SwiftyExtension

class MainViewController: BaseViewController {

    let numberOfPlanets = 4
    
    private let lblTitle: UILabel = {
        let label = UILabel()
        label.text = "Select planets you want to search in"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(MainCell.self, forCellReuseIdentifier: "MainCell")
        return tableView
    }()
    
    private let lblTime: UILabel = {
        let label = UILabel()
        label.text = "Time taken: 0"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let btnFind: UIButton = {
        let button = UIButton()
        button.setTitle("Find Falcone", for: .normal)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addSubview(lblTitle)
        lblTitle.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-32)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.top.equalTo(lblTitle.snp.bottom).offset(16)
            $0.centerX.width.equalTo(lblTitle)
        }
        
        let viewContainer = UIView()
        viewContainer.backgroundColor = .yellow

        viewContainer.addSubview(lblTime)
        lblTime.snp.makeConstraints{
            $0.top.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-32)
        }
        
        viewContainer.addSubview(btnFind)
        btnFind.snp.makeConstraints{
            $0.top.equalTo(lblTime.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.greaterThanOrEqualTo(120)
            $0.height.equalTo(50)
            $0.bottom.greaterThanOrEqualToSuperview().offset(-32)
        }
        
        view.addSubview(viewContainer)
        viewContainer.snp.makeConstraints{
            $0.top.equalTo(tableView.snp.bottom).offset(16)
            $0.centerX.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Finding Falcone!"
        
        let rightBarBtn = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetPressed))
        self.navigationItem.rightBarButtonItem = rightBarBtn
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    @IBAction private func resetPressed(){
        
    }

}

private extension MainViewController{
    var mainViewModel: MainViewModel{
        return self.viewModel as! MainViewModel
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfPlanets
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: MainCell.self) as! MainCell
        let data = MainCellData("Destination \(indexPath.row+1)", nil, nil)
        cell.data = data
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

