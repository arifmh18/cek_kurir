//
//  ViewController.swift
//  Cek Ongkir
//
//  Created by Muhammad Arif Hidayatulloh on 17/02/20.
//  Copyright © 2020 PT Goalkes Indonesia Jaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var utils = Utils()
    
    let tf_kota_pengirim : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Kota Pengirim"
        tf.font = UIFont.systemFont(ofSize: 12)
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.autocorrectionType = UITextAutocorrectionType.no
        tf.keyboardType = UIKeyboardType.default
        tf.returnKeyType = UIReturnKeyType.done
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        tf.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return tf
    }()
    let tf_kota_tujuan : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Kota Tujuan"
        tf.font = UIFont.systemFont(ofSize: 12)
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.autocorrectionType = UITextAutocorrectionType.no
        tf.keyboardType = UIKeyboardType.default
        tf.returnKeyType = UIReturnKeyType.done
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        tf.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return tf
    }()
    let tf_berat : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Berat (kg)"
        tf.font = UIFont.systemFont(ofSize: 12)
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.autocorrectionType = UITextAutocorrectionType.no
        tf.returnKeyType = UIReturnKeyType.done
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        tf.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tf.keyboardType = .numberPad
        return tf
    }()
    let tf_jenis : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Jenis Kurir"
        tf.font = UIFont.systemFont(ofSize: 12)
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.autocorrectionType = UITextAutocorrectionType.no
        tf.keyboardType = UIKeyboardType.default
        tf.returnKeyType = UIReturnKeyType.done
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        tf.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return tf
    }()
    let btn_cek : UIButton = {
        let btn = UIButton()
        btn.setTitle("Cek Ongkir", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        btn.backgroundColor = .red
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(cek(sender:)), for: .touchUpInside)
        return btn
    }()

    @objc func cek(sender: UIButton!) {
        self.validasi()
    }
    
    func validasi(){
        let weight = tf_berat.text ?? ""
        self.berat = (Int(weight) ?? 0) * 1000
        if id_pengirim.isEmpty{
            self.utils.showToast(controller: self, message: "Kota Pengirim Wajib Dipilih Dulu", seconds: 1)
            return
        }
        if id_tujuan.isEmpty{
            self.utils.showToast(controller: self, message: "Kota Tujuan Wajib Dipilih Dulu", seconds: 1)
            return
        }
        if berat == 0 || berat <= 0{
            self.utils.showToast(controller: self, message: "Berat Barang Tidak Boleh kurang dari 0", seconds: 1)
            return
        }
        if kurir.isEmpty{
            self.utils.showToast(controller: self, message: "Jenis Kurir Wajib Dipilih Dulu", seconds: 1)
            return
        }
        
    }
    
    func setUp(){
        view.addSubview(tf_kota_pengirim)
        view.addSubview(tf_kota_tujuan)
        view.addSubview(tf_berat)
        view.addSubview(tf_jenis)
        view.addSubview(btn_cek)
        
        tf_kota_pengirim.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 100.0, paddingLeft: 16.0, paddingBottom: 0, paddingRight: 16.0)
        tf_kota_tujuan.setAnchor(top: tf_kota_pengirim.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16.0, paddingLeft: 16.0, paddingBottom: 0, paddingRight: 16.0)
        tf_berat.setAnchor(top: tf_kota_tujuan.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16.0, paddingLeft: 16.0, paddingBottom: 0, paddingRight: 16.0)
        tf_jenis.setAnchor(top: tf_berat.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16.0, paddingLeft: 16.0, paddingBottom: 0, paddingRight: 16.0)
        btn_cek.setAnchor(top: tf_jenis.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20.0, paddingLeft: 16.0, paddingBottom: 0, paddingRight: 16.0, height: 35)
    }
    
    private var id_pengirim = ""
    private var id_tujuan = ""
    private var berat = 0
    private var kurir = ""
    var picker : [String] = ["JNE", "Pos Indonesia", "TIKI"]
    var picker_code : [String] = ["jne", "pos", "tiki"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUp()
        self.tf_kota_pengirim.addTarget(self, action: #selector(moveProvincePengirim), for: UIControl.Event.editingDidBegin)
        self.tf_kota_tujuan.addTarget(self, action: #selector(moveProvinceTujuan), for: UIControl.Event.editingDidBegin)
        createData()
        dismissKey()
        definesPresentationContext = true
    }

    @objc func moveProvincePengirim(){
        let prov = ProvinceController()
        prov.delegate = self
        prov.modalPresentationStyle = .fullScreen
        prov.status = "pengirim"
        self.present(prov, animated: true, completion: nil)
        self.tf_kota_pengirim.endEditing(true)
    }

    @objc func moveProvinceTujuan(){
        let prov = ProvinceController()
        prov.delegate = self
        prov.modalPresentationStyle = .fullScreen
        prov.status = "tujuan"
        self.present(prov, animated: true, completion: nil)
        self.tf_kota_pengirim.endEditing(true)
    }
    
    func createData(){
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        self.tf_jenis.inputView = picker
    }
    
    func dismissKey(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let ok = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(dis))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, ok], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        self.tf_jenis.inputAccessoryView = toolbar
    }
    
    @objc func dis(){
        view.endEditing(true)
    }

}

extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return picker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return picker[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectPick = picker[row]
        self.kurir = picker_code[row]
        self.tf_jenis.text = selectPick
    }
}

extension ViewController : ProvinceDelegate, CityDelegate{
    func setDataProvince(data: GetDataProvince.Results, status: String) {
        let deadlineTime = DispatchTime.now() + .milliseconds(100)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            let city = CityController()
            city.delegate = self
            city.status = status
            city.modalPresentationStyle = .fullScreen
            city.province = data.province_id ?? ""
            self.present(city, animated: true, completion: nil)
            self.tf_kota_pengirim.endEditing(true)
        }
    }
    
    func setDataCity(data: GetDataCity.Results, status: String) {
        if status == "pengirim" {
            self.tf_kota_pengirim.text = data.city_name ?? ""
            self.id_pengirim = data.city_id ?? ""
        } else {
            self.tf_kota_tujuan.text = data.city_name ?? ""
            self.id_tujuan = data.city_id ?? ""
        }
    }
    
}
