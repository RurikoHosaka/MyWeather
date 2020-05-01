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

class ViewController: UIViewController {
    
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
    
    
    //地域を扱うキーを設定
    let settingKey = "region_value"
    
    //modelのデータを取得
    let regionList = RegionList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //UserDefaultsのインスタンスを生成
        let settings = UserDefaults.standard
        //UserDefaultsに初期値を登録
        settings.register(defaults: [settingKey:"130010"])
        
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
    
    //APIから天気情報を取得する処理
    private func getWeatherData(row: Int){
        //UserDefaultsの取得
        let settings = UserDefaults.standard
        let regionValue = settings.string(forKey: settingKey)
        
        //RegionListからcodeに対応するnameを取得する
        for listRow in 0..<47 {
            if regionList.list[listRow].code == regionValue {
                regionData = [regionList.list[listRow].code, regionList.list[listRow].name]
            }
        }
        
        let url = "http://weather.livedoor.com/forecast/webservice/json/v1?city=\(regionData[0])"
        
        //Alamofireで通信し、データを取得
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON {(response) in
            
            switch response.result {
            case .success:
                
                //jsonを取得
                let json:JSON = JSON(response.data as Any)
                
                //取得したjsonから、必要なデータを取り出す
                let details = json["description"]["text"].string
                let dateString = json["forecasts"][row]["date"].string
                let weatherURL = json["forecasts"][row]["image"]["url"].string
                let weather = json["forecasts"][row]["telop"].string
                let high = json["forecasts"][row]["temperature"]["max"]["celsius"].string
                let low = json["forecasts"][row]["temperature"]["min"]["celsius"].string
                
                //取り出したデータを、それぞれの変数に入れる
                //データがない場合もあるので、その時は"No Data"と入れておく
                if details != nil {
                    self.details = (details?.components(separatedBy: .newlines))!  //改行で分割します。
                } else {
                    self.details = ["No Details"]
                }
                
                if dateString != nil {
                    // DateFormatter のインスタンスを作成
                    let formatter: DateFormatter = DateFormatter()
                    // 日付の書式を文字列に合わせて設定
                    formatter.dateFormat = "yyyy-MM-dd"
                    // 日時文字列からDate型の日付を生成する
                    let dt : Date  = formatter.date(from: dateString!)!
                    // 変換後の日付書式
                    formatter.dateFormat = "M/d"
                    self.dateString = formatter.string(from: dt)
                } else {
                    self.dateString = "No Data"
                }
                
                if  weatherURL != nil {
                    do {
                        print(weatherURL!)
                        let url = URL(string: weatherURL!)
                        self.data = try Data(contentsOf: url!)
                    }catch let err {
                        print("Error : \(err.localizedDescription)")
                    }
                }
                
                if weather != nil {
                    self.weather = weather!
                } else {
                    self.weather = "No Data"
                }
                
                if high != nil {
                    self.high = "\(high!)°"
                } else {
                    self.high = "No Data"
                }
                
                if low != nil {
                    self.low = "\(low!)°"
                } else {
                    self.low = "No Data"
                }
                
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
            detailsTextView.text = details[0]
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
}

