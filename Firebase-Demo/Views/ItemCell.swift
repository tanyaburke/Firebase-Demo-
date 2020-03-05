//
//  ItemCell.swift
//  Firebase-Demo
//
//  Created by Tanya Burke on 3/4/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var pricelabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    
    
    
    public func configureCell(for item: Item){
        itemLabel.text = item.itemName
        sellerNameLabel.text = "@\(item.sellerName)"
    }

}
