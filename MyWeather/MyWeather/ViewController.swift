//
//  ViewController.swift
//  MyWeather
//
//  Created by ruriko hosaka on 2020/04/24.
//  Copyright © 2020 ruriko hosaka. All rights reserved.
//

import UIKit

//podからインストールしたライブラリ
import Alamofire
import SwiftyJSON

//componentsを使用するのでインポート
import Foundation

//現在地を取得するためのライブラリ
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var region:String = ""
    var regionData:[String] = []
    var details:[String] = []
    var dateString:String = ""
    var weatherURL:URL?
    var weather:String = ""
    var high:String = ""
    var low:String = ""
    var tomorrowDateString:String = ""
    var tomorrowWeatherURL:URL?
    var tomorrowWeather:String = ""
    var tomorrowHigh:String = ""
    var tomorrowLow:String = ""
    var data:Data?
    var getCoordeFlag = 0
    
    //地域を扱うキーを設定
    let settingKey = "region_value"
    //modelのデータを取得
    let regionList = RegionList()
    
    //APIキー
    let apiKey = "29251e2deca8f2cad28bc2757ba76f78"
    //緯度経度
    var latLocation = 0.0
    var lonLocation = 0.0
    //位置情報を管理するクラスのインスタンスを生成
    // user location
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //現在日付を取得
        getTodayDate()
        
        //UserDefaultsのインスタンスを生成
        let settings = UserDefaults.standard
        //UserDefaultsに初期値を登録
        settings.register(defaults: [settingKey:"13"])
        // use popup to check and get location
        locationManager.requestWhenInUseAuthorization()
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        setupLocationManager()
        getWeatherData(row: 0)
        getWeatherData(row: 1)
        
    }
    
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var tomorrowDateLabel: UILabel!
    @IBOutlet weak var tomorrowWeatherImage: UIImageView!
    @IBOutlet weak var tomorrowWeatherLabel: UILabel!
    @IBOutlet weak var tomorrowHighLabel: UILabel!
    @IBOutlet weak var tomorrowLowLabel: UILabel!
    
    @IBAction func settingButtonAction(_ sender: Any) {
        //画面遷移を行う
        performSegue(withIdentifier:"goSetting", sender: nil)
    }
    
    @IBAction func getCoordButtonAction(_ sender: Any) {
        //現在地の緯度経度を取得する
        getCoordeFlag = 1
        setupLocationManager()
        getWeatherData(row: 0)
        getWeatherData(row: 1)
        getCoordeFlag = 0
    }
    //現在日付を取得する処理
    private func getTodayDate() {
        let dt = Date()
        let dateFormatter = DateFormatter()
        // DateFormatter を使用して書式とロケールを指定する
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "M/d", options: 0, locale: Locale(identifier: "ja_JP"))
        self.dateString = dateFormatter.string(from: dt)
    }
    
    //APIから天気情報を取得する処理
    private func getWeatherData(row: Int){
        //UserDefaultsの取得
        let settings = UserDefaults.standard
        var regionValue = ""
        if getCoordeFlag == 0 {
            regionValue = settings.string(forKey: settingKey)!
        } else {
            regionValue = "0"
        }
        //RegionListからcodeに対応するnameを取得する
        for listRow in 0..<48 {
            if regionList.list[listRow].code == regionValue {
                regionData = [regionList.list[listRow].code, regionList.list[listRow].name, regionList.list[listRow].lat, regionList.list[listRow].lon]
            }
        }
        if regionValue == "0" {
            regionData[2] = String(latLocation)
            regionData[3] = String(lonLocation)
        }
        
        let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(regionData[2])&lon=\(regionData[3])&appid=\(apiKey)&units=metric"
        
        //Alamofireで通信し、データを取得
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON {(response) in
            
            switch response.result {
            case .success:
                
                //jsonを取得
                let json:JSON = JSON(response.data as Any)
                
                //取得したjsonから、必要なデータを取り出す
                //let details = json["description"]["text"].string
                let weather = json[["weather"]].array![0]["main"].stringValue
                let iconName = json["weather"].array![0]["icon"].stringValue
                let high = Int(round(json["main"]["temp_max"].doubleValue))
                let low = Int(round(json["main"]["temp_min"].doubleValue))
                
                //取り出したデータを、それぞれの変数に入れる
                //データがない場合もあるので、その時は"No Data"と入れておく
                //if details != nil {
                //    self.details = (details?.components(separatedBy: .newlines))!  //改行で分割します。
                //} else {
                //    self.details = ["No Details"]
                //}
                
                do {
                    let url = URL(string: "http://openweathermap.org/img/wn/\(iconName)@2x.png")
                    self.data = try Data(contentsOf: url!)
                }catch let err {
                    print("Error : \(err.localizedDescription)")
                }
                self.weather = weather
                self.high = "\(high)°"
                self.low = "\(low)°"
                
                //ラベルに反映させる
                self.setWeatherData(row: row)
                
            case .failure(let error):
                print("-------- エラー ------")
                print(error)
            }
        }
    }
    //ラベルに反映させる処理
    private func setWeatherData(row: Int) {
        
        if row == 0 {
            regionLabel.text = regionData[1] + " の 天気"
            //分割時に配列になっているので、1つ目の要素だけ表示します。
            //detailsTextView.text = details[0]
            dateLabel.text = "今日 " + dateString
            weatherImage.image = UIImage(data: data!)
            weatherLabel.text = weather
            highLabel.text = high
            lowLabel.text = low
            
        } else if row == 1 {
            
            tomorrowDateLabel.text = "明日 " + dateString
            tomorrowWeatherImage.image = UIImage(data: data!)
            tomorrowWeatherLabel.text = weather
            tomorrowHighLabel.text = high
            tomorrowLowLabel.text = low
        }
    }
    //画面切り替えのタイミングで処理を行う
    override func viewDidAppear(_ animated: Bool) {
        //天気予報を更新する
        _ = getWeatherData(row: 0)
        _ = getWeatherData(row: 1)
    }
    
    //現在地を取得する処理
    func setupLocationManager() {
        // use popup to check and get location
        locationManager.requestWhenInUseAuthorization()
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    //位置情報を取得・更新するたびに呼ばれるデリゲートメソッド
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        print(location)
        latLocation = location.coordinate.latitude
        lonLocation = location.coordinate.longitude
    }
}

