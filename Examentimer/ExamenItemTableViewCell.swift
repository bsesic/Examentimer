//
//  ExamenItemTableViewCell.swift
//  Examentimer
//
//  Created by Benjamin Schnabel on 12.06.19.
//  Copyright © 2019 Acheros. All rights reserved.
//

import UIKit

class ExamenItemTableViewCell: UITableViewCell {
    var examenItemBooks:Int = 7
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

    }
 
    @IBAction func checkItem(_ sender: UIButton) {
        removeItemfromStack()
    }
    
    func removeItemfromStack(){
        if examenItemBooks <= 0 {
            examenItemBooks = 0
        }

    }
    
}
