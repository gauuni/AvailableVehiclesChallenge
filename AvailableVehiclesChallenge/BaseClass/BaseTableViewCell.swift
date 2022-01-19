//
//  BaseTableViewCell.swift
//  AvailableVehiclesChallenge
//
//  Created by Khoi Nguyen on 1/19/22.
//

import UIKit
import RxSwift

class BaseTableViewCell: UITableViewCell {

    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
