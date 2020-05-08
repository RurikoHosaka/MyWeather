//
//  CityModel.swift
//  MyWeather
//
//  Created by ruriko hosaka on 2020/04/28.
//  Copyright © 2020 ruriko hosaka. All rights reserved.
//

import Foundation

class RegionModel {
    
    //地域の名前とURLを追加するプロパティ
    let code: String
    let name: String
    let lat: String
    let lon: String
    
    init(regionCode:String, regionName:String, latitude:String, longitude:String){
        code = regionCode
        name = regionName
        lat = latitude
        lon = longitude
    }
    
}

