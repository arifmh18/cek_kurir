//
//  CostCell.swift
//  Cek Ongkir
//
//  Created by Muhammad Arif Hidayatulloh on 18/02/20.
//  Copyright © 2020 PT Goalkes Indonesia Jaya. All rights reserved.
//

import UIKit

class CostCell: UITableViewCell {
    
    let service : UILabel = {
        let lbl = UILabel()
        return lbl
    }()

    let price : UILabel = {
        let lbl = UILabel()
        return lbl
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUp(){
        addSubview(service)
        service.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 10.0, paddingLeft: 30.0, paddingBottom: 0, paddingRight: 0)
        price.setAnchor(top: service.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5.0, paddingLeft: 30.0, paddingBottom: 30.0, paddingRight: 30.0)
    }
    
    func setData(data:GetCost.CostItems){
        
    }

}
