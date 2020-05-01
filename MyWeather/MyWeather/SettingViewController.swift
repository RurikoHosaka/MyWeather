//
//  SettingViewController.swift
//  MyWeather
//
//  Created by ruriko hosaka on 2020/04/27.
//  Copyright © 2020 ruriko hosaka. All rights reserved.
//

import UIKit


class SettingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var regionSettingPicker: UIPickerView!
    @IBAction func decisionButtonAction(_ sender: Any) {
        //前画面に戻る
        _ = navigationController?.popViewController(animated: true)
    }
    
    //設定値を覚えるキーを設定
    let settingKey = "region_value"
    
    //次のViewControllerに渡す変数に初期値を設定
    var regionData:[String] = []
    
    //modelのデータを取得
    let regionList = RegionList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //regionSettingPickerのデリゲートとデータソースの通知先を設定
        regionSettingPicker.delegate = self
        regionSettingPicker.dataSource = self
        
        //UserDefaultsの取得
        let settings = UserDefaults.standard
        let regionValue = settings.string(forKey: settingKey)
        
        //Pickerの選択を合わせる
        for row in 0..<47 {
            if regionList.list[row].code == regionValue {
                regionSettingPicker.selectRow(row, inComponent: 0, animated: true)
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    //pickerの列数を決める
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //pickerの行数を決める
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return regionList.list.count
    }
    
    //pickerに表示するデータを決める
    //ここでは取得したmodelのデータのnameを表示する
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return regionList.list[row].name
    }
    
    //選択時の挙動を決める
    //次の画面に渡すために、取得したmodelのデータからcodeとnameを変数に入れる
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //UserDefaultsの設定
        let settings = UserDefaults.standard
        settings.setValue(regionList.list[row].code,forKey: settingKey)
        settings.synchronize()
        regionData = [regionList.list[row].code,regionList.list[row].name]
    }
    
}
