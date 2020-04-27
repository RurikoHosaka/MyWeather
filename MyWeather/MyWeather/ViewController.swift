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
    var dateString:String = ""
    var weather:String = ""
    var high:String = ""
    var low:String = ""
    var region:String = ""
    
    var cityData:[String] = ["130010", "東京"]
    override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
    getWeatherData(row: 0)
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    
    private func getWeatherData(row: Int){
    
        let url = "http://weather.livedoor.com/forecast/webservice/json/v1?city=\(cityData[0])"
        
        //Alamofireで通信し、データを取得
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON {(response) in

            switch response.result {
            case .success:

                //jsonを取得
                let json:JSON = JSON(response.data as Any)

                //取得したjsonから、必要なデータを取り出す
                let dateString = json["forecasts"][row]["date"].string
                let weather = json["forecasts"][row]["telop"].string
                let high = json["forecasts"][row]["temperature"]["max"]["celsius"].string
                let low = json["forecasts"][row]["temperature"]["min"]["celsius"].string


                //取り出したデータを、それぞれの変数に入れる
                //データがない場合もあるので、その時は"No Data"と入れておく
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

            weatherLabel.text = weather
            dateLabel.text = dateString
            highLabel.text = high
            lowLabel.text = low
            regionLabel.text = cityData[1]
        }
    }
}

