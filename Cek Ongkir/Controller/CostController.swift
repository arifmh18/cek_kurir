//
//  CostController.swift
//  Cek Ongkir
//
//  Created by Muhammad Arif Hidayatulloh on 18/02/20.
//  Copyright © 2020 PT Goalkes Indonesia Jaya. All rights reserved.
//

import UIKit
import Moya

class CostController: UIViewController {
    
    private var cost_cell = "cost_cell"
    var dataCost = [GetCost.CostItems]()

    let table_cost : UITableView = {
        let tbl = UITableView()
        return tbl
    }()
    let btn : UIButton = {
        let btn = UIButton()
        btn.setTitle("Ok", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        btn.backgroundColor = .red
        btn.setTitleColor(.white, for: .normal)
//        btn.addTarget(self, action: #selector(cek(sender:)), for: .touchUpInside)
        return btn
    }()

    func setUp(){
        view.addSubview(table_cost)
        view.addSubview(btn)
        table_cost.register(CityCell.self, forCellReuseIdentifier: cost_cell)
        table_cost.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10.0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }

    var pengirim = ""
    var tujuan = ""
    var jenis = ""
    var berat = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func callData(){
        let callNet = MoyaProvider<DataNetwork>()
        callNet.request(.cost(origin: pengirim, destination: tujuan, weight: berat, courier: jenis)) { (result) in
            switch result{
            case .success(let respon):
                do{
                    let response = try respon.filterSuccessfulStatusCodes()
                    let data = try response.map(GetCost.self)
                    
                    self.dataCost = data.rajaongkir?.results?[0].costs?[0].cost ?? []
                    self.table_cost.delegate = self
                    self.table_cost.dataSource = self
                    
                    DispatchQueue.main.async {
                        self.table_cost.reloadData()
                    }
                } catch{
                    print("error")
                }
            case .failure(_):
                print("Masuk Failure")
            }
            
        }
    }
    
}

extension CostController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataCost[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: cost_cell, for: indexPath) as! CostCell
        cell.setData(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }

}
