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
    var dateString:String = ""
    var weatherURL:URL?
    var weather:String = ""
    var high:String = ""
    var low:String = ""
    var data:Data?
    var getCoordeFlag = 0
    var timeFirst = ""
    var timeSecond = ""
    var timeThird = ""
    var timeFourth = ""
    var timeFifth = ""
    var timeSixth = ""
    var timeSeventh = ""
    var timeEighth = ""
    var timeNinth = ""
    var timeTenth = ""
    var weatherFirst:Data?
    var weatherSecond:Data?
    var weatherThird:Data?
    var weatherFourth:Data?
    var weatherFifth:Data?
    var weatherSixth:Data?
    var weatherSeventh:Data?
    var weatherEighth:Data?
    var weatherNinth:Data?
    var weatherTenth:Data?
    
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
    
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var firstWeatherLabel: UILabel!
    @IBOutlet weak var secondWeatherLabel: UILabel!
    @IBOutlet weak var thirdWeatherLabel: UILabel!
    @IBOutlet weak var fourthWeatherLabel: UILabel!
    @IBOutlet weak var fifthWeatherLabel: UILabel!
    @IBOutlet weak var sixthWeatherLabel: UILabel!
    @IBOutlet weak var seventhWeatherLabel: UILabel!
    @IBOutlet weak var eighthWeatherLabel: UILabel!
    @IBOutlet weak var ninthWeatherLabel: UILabel!
    @IBOutlet weak var tenthWeatherLabel: UILabel!
    @IBOutlet weak var firstWeatherImage: UIImageView!
    @IBOutlet weak var secondWeatherImage: UIImageView!
    @IBOutlet weak var thirdWeatherImage: UIImageView!
    @IBOutlet weak var fourthWeatherImage: UIImageView!
    @IBOutlet weak var fifthWeatherImage: UIImageView!
    @IBOutlet weak var sixthWeatherImage: UIImageView!
    @IBOutlet weak var seventhWeatherImage: UIImageView!
    @IBOutlet weak var eighthWeatherImage: UIImageView!
    @IBOutlet weak var ninthWeatherImage: UIImageView!
    @IBOutlet weak var tenthWeatherImage: UIImageView!
    
    @IBAction func settingButtonAction(_ sender: Any) {
        //画面遷移を行う
        performSegue(withIdentifier:"goSetting", sender: nil)
    }
    
    @IBAction func getCoordButtonAction(_ sender: Any) {
        //現在地の緯度経度を取得する
        getCoordeFlag = 1
        setupLocationManager()
        getWeatherData()
        getWeatherDataEveryThreeHours()
        getCoordeFlag = 0
    }
    
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
        getWeatherData()
        getWeatherDataEveryThreeHours()
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
    private func getWeatherData(){
        //UserDefaultsの取得
        let settings = UserDefaults.standard
        var regionValue = ""
        if getCoordeFlag == 0 {
            regionValue = settings.string(forKey: settingKey)!
            //regionValue = "13"
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
        
        //今日の天気予報を取得
        let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(regionData[2])&lon=\(regionData[3])&appid=\(apiKey)&units=metric"
        
        //Alamofireで通信し、データを取得
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON {(response) in
            
            switch response.result {
            case .success:
                
                //jsonを取得
                let json:JSON = JSON(response.data as Any)
                
                //取得したjsonから、必要なデータを取り出す
                let weather = json["weather"].array![0]["main"].stringValue
                let iconName = json["weather"].array![0]["icon"].stringValue
                let high = Int(round(json["main"]["temp_max"].doubleValue))
                let low = Int(round(json["main"]["temp_min"].doubleValue))
                
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
                self.setWeatherData(row:0)
                
            case .failure(let error):
                print("-------- エラー ------")
                print(error)
            }
        }
    }
    //APIから天気情報を取得する処理
    private func getWeatherDataEveryThreeHours(){
        //3時間ごとの天気予報を取得
        let url = "http://api.openweathermap.org/data/2.5/forecast?lat=\(regionData[2])&lon=\(regionData[3])&appid=\(apiKey)&units=metric&cnt=10"
        
        //Alamofireで通信し、データを取得
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON {(response) in
            
            switch response.result {
            case .success:
                
                //jsonを取得
                let json:JSON = JSON(response.data as Any)
                var city:String = ""
                for cell in 0..<10 {
                    //取得したjsonから、必要なデータを取り出す
                    let iconName = json["list"].array![cell]["weather"].array![0]["icon"].stringValue
                    let time = json["list"].array![cell]["dt"].stringValue
                    city = json["city"]["name"].stringValue
                    // UNIX時間 "dateUnix" をNSDate型 "date" に変換
                    let dateUnix: TimeInterval = TimeInterval(time)!
                    let dt = NSDate(timeIntervalSince1970: dateUnix)
                    // NSDate型を日時文字列に変換するためのNSDateFormatterを生成
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "H時"
                    do {
                        let url = URL(string: "http://openweathermap.org/img/wn/\(iconName)@2x.png")
                        if cell == 0 {
                            self.weatherFirst = try Data(contentsOf: url!)
                            self.timeFirst = dateFormatter.string(from: dt as Date)
                        }else if cell == 1 {
                            self.weatherSecond = try Data(contentsOf: url!)
                            self.timeSecond = dateFormatter.string(from: dt as Date)
                        }else if cell == 2 {
                            self.weatherThird = try Data(contentsOf: url!)
                            self.timeThird = dateFormatter.string(from: dt as Date)
                        }else if cell == 3 {
                            self.weatherFourth = try Data(contentsOf: url!)
                            self.timeFourth = dateFormatter.string(from: dt as Date)
                        }else if cell == 4 {
                            self.weatherFifth = try Data(contentsOf: url!)
                            self.timeFifth = dateFormatter.string(from: dt as Date)
                        }else if cell == 5 {
                            self.weatherSixth = try Data(contentsOf: url!)
                            self.timeSixth = dateFormatter.string(from: dt as Date)
                        }else if cell == 6 {
                            self.weatherSeventh = try Data(contentsOf: url!)
                            self.timeSeventh = dateFormatter.string(from: dt as Date)
                        }else if cell == 7 {
                            self.weatherEighth = try Data(contentsOf: url!)
                            self.timeEighth = dateFormatter.string(from: dt as Date)
                        }else if cell == 8 {
                            self.weatherNinth = try Data(contentsOf: url!)
                            self.timeNinth = dateFormatter.string(from: dt as Date)
                        }else if cell == 9 {
                            self.weatherTenth = try Data(contentsOf: url!)
                            self.timeTenth = dateFormatter.string(from: dt as Date)
                        }
                    }catch let err {
                        print("Error : \(err.localizedDescription)")
                    }
                    
                }
                print(city)
                //ラベルに反映させる
                self.setWeatherData(row:1)
                
            case .failure(let error):
                print("-------- エラー ------")
                print(error)
            }
        }
    }
    //ラベルに反映させる処理
    private func setWeatherData(row: Int) {
        
        if row == 0{
            regionLabel.text = regionData[1] + " の 天気"
            dateLabel.text = "今日 " + dateString
            weatherImage.image = UIImage(data: data!)
            weatherLabel.text = weather
            highLabel.text = high
            lowLabel.text = low
        } else if row == 1{
            firstWeatherLabel.text = timeFirst
            secondWeatherLabel.text = timeSecond
            thirdWeatherLabel.text = timeThird
            fourthWeatherLabel.text = timeFourth
            fifthWeatherLabel.text = timeFifth
            sixthWeatherLabel.text = timeSixth
            seventhWeatherLabel.text = timeSeventh
            eighthWeatherLabel.text = timeEighth
            ninthWeatherLabel.text = timeNinth
            tenthWeatherLabel.text = timeTenth
            firstWeatherImage.image = UIImage(data: weatherFirst!)
            secondWeatherImage.image = UIImage(data: weatherSecond!)
            thirdWeatherImage.image = UIImage(data: weatherThird!)
            fourthWeatherImage.image = UIImage(data: weatherFourth!)
            fifthWeatherImage.image = UIImage(data: weatherFifth!)
            sixthWeatherImage.image = UIImage(data: weatherSixth!)
            seventhWeatherImage.image = UIImage(data: weatherSeventh!)
            eighthWeatherImage.image = UIImage(data: weatherEighth!)
            ninthWeatherImage.image = UIImage(data: weatherNinth!)
            tenthWeatherImage.image = UIImage(data: weatherTenth!)
        }
    }
    //画面切り替えのタイミングで処理を行う
    override func viewDidAppear(_ animated: Bool) {
        //天気予報を更新する
        _ = getWeatherData()
        _ = getWeatherDataEveryThreeHours()
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
