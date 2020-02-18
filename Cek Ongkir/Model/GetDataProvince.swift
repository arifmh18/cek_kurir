//
//  GetDataProvince.swift
//  Cek Ongkir
//
//  Created by Muhammad Arif Hidayatulloh on 18/02/20.
//  Copyright © 2020 PT Goalkes Indonesia Jaya. All rights reserved.
//

import Foundation

struct GetDataProvince : Decodable {
    let rajaongkir : Data?
    
    struct Data : Decodable {
        let status : Status?
        let results : [Results]?
    }
    
    struct Results : Decodable {
        let province_id : String?
        let province : String?
    }
    
    struct Status : Decodable {
        let code : Int?
        let description : String?
    }
}
