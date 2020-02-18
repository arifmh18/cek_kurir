//
//  ProvinceCell.swift
//  Cek Ongkir
//
//  Created by Muhammad Arif Hidayatulloh on 18/02/20.
//  Copyright © 2020 PT Goalkes Indonesia Jaya. All rights reserved.
//

import UIKit

class ProvinceCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    let label : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12)
        return lbl
    }()
    
    let icon : UIImageView = {
        let img = UIImageView()
        
        return img
    }()
    
    func setUp(){
        addSubview(label)
        label.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 30.0, paddingBottom: 0, paddingRight: 0)
    }
    
    func setData(data: GetDataProvince.Results){
        setUp()
        self.label.text = data.province ?? ""
    }
}
