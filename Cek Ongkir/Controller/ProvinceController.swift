//
//  ProvinceController.swift
//  Cek Ongkir
//
//  Created by Muhammad Arif Hidayatulloh on 18/02/20.
//  Copyright © 2020 PT Goalkes Indonesia Jaya. All rights reserved.
//

import UIKit
import Moya

protocol ProvinceDelegate : AnyObject {
    func setDataProvince(data: GetDataProvince.Results, status: String)
}

class ProvinceController: UIViewController {
    
    private var province_cell = "province_cell"
    let prov_table : UITableView = {
        let table = UITableView()
        return table
    }()

    func setUp(){
        view.addSubview(prov_table)
        prov_table.register(ProvinceCell.self, forCellReuseIdentifier: province_cell)
        prov_table.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10.0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Pilih Provinsi"
        self.setUp()
        self.callData()
        
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeThatFits(CGSize(width: CGFloat(self.view.frame.size.width - 50), height: 50.0))

            self.prov_table.tableHeaderView = controller.searchBar

            return controller
        })()

        // Reload the table
        self.prov_table.reloadData()

    }
    
    weak var delegate: ProvinceDelegate?
    var status = ""
    var resultSearchController = UISearchController()
    var filteredTableData = [GetDataProvince.Results]()
    var dataProv = [GetDataProvince.Results]()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    func callData(){
        let callNet = MoyaProvider<DataNetwork>()
        callNet.request(.province) { (result) in
            switch result{
            case .success(let respon):
                do{
                    let response = try respon.filterSuccessfulStatusCodes()
                    let data = try response.map(GetDataProvince.self)
                    
                    self.dataProv = data.rajaongkir?.results ?? []
                    self.prov_table.delegate = self
                    self.prov_table.dataSource = self
                    
                    DispatchQueue.main.async {
                        self.prov_table.reloadData()
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

extension ProvinceController : UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)

        var temp : [GetDataProvince.Results] = []
        for i in 0 ..< dataProv.count{
            if (dataProv[i].province?.lowercased().contains(searchController.searchBar.text!.lowercased()) ?? false) {
                temp.append(dataProv[i])
            }
        }
        self.filteredTableData = temp
        self.prov_table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  (resultSearchController.isActive) {
            return filteredTableData.count
        } else {
            return dataProv.count
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: province_cell, for: indexPath) as! ProvinceCell
        if (resultSearchController.isActive) {
            let data = filteredTableData[indexPath.item]
            cell.setData(data: data)
            return cell
        } else {
            let data = dataProv[indexPath.item]
            cell.setData(data: data)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if resultSearchController.isActive {
            self.delegate?.setDataProvince(data: filteredTableData[indexPath.row], status: status)
            self.dismiss(animated: true, completion: nil)
//            self.navigationController?.popViewController(animated: true)
            resultSearchController.isActive = false
        } else {
            self.delegate?.setDataProvince(data: dataProv[indexPath.row], status: status)
            self.dismiss(animated: true, completion: nil)
//            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
