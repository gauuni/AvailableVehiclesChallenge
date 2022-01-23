//
//  PanViewController.swift
//  AvailableVehiclesChallenge
//
//  Created by Khoi Nguyen on 1/20/22.
//

import UIKit
import PanModal
import RxSwift

class PanViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, PanModalPresentable {

    let tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    var panScrollable: UIScrollView? {
        return tableView
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(UIScreen.height/3)
    }
    
    var items: [Any]!
    var selectedItem: Any?
    let pSelected = PublishSubject<Any?>()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.center.width.height.equalToSuperview()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)

        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        cell?.accessoryType = .none
        
        if let item = items[indexPath.row] as? Planet{
            cell?.textLabel?.text = item.name
            
            if let selectedItem = self.selectedItem{
                if let planet = selectedItem as? Planet,
                    item.name == planet.name{
                    cell?.accessoryType = .checkmark
                }
            }
        }
        
        if let item = items[indexPath.row] as? Vehicle,
        let name = item.name{
            cell?.textLabel?.text = String(format: "%@ (%i)", name, item.units)
            if let vehicle = selectedItem as? Vehicle,
                item.name == vehicle.name{
                cell?.accessoryType = .checkmark
            }
            if item.units == 0{
                cell?.contentView.alpha = 0.5
            }
        }
        

        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = items[indexPath.row] as? Vehicle,
           item.units == 0{
            return
        }
        let item = items[indexPath.row]
        pSelected.onNext(item)
        pSelected.onCompleted()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func panModalWillDismiss() {
        pSelected.onNext(nil)
        pSelected.onCompleted()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
