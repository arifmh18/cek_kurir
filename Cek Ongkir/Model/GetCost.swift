//
//  GetCost.swift
//  Cek Ongkir
//
//  Created by Muhammad Arif Hidayatulloh on 18/02/20.
//  Copyright © 2020 PT Goalkes Indonesia Jaya. All rights reserved.
//

import Foundation

struct GetCost : Decodable {
    let rajaongkir : Data?
    
    struct Data : Decodable {
        let results : [Results]?
    }
    
    struct Results : Decodable {
        let name : String?
        let costs : [Cost]?
    }
    
    struct Cost : Decodable {
        let service : String?
        let description : String?
        let cost : [CostItems]?
    }
    
    struct CostItems : Decodable {
        let value : Int?
        let etd : String?
        let note : String?
    }
}
