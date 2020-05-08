//
//  CityList.swift
//  MyWeather
//
//  Created by ruriko hosaka on 2020/04/28.
//  Copyright © 2020 ruriko hosaka. All rights reserved.
//

import Foundation

class RegionList {
    
    var list = [RegionModel]()
    
    //都道府県情報をリストに追加
    //緯度経度は県庁所在地の位置
    init() {
        list.append(RegionModel(regionCode: "1", regionName: "北海道", latitude: "43.06417", longitude:"141.34694"))
        list.append(RegionModel(regionCode: "2", regionName: "青森県", latitude: "40.82444", longitude:"140.74"))
        list.append(RegionModel(regionCode: "3", regionName: "岩手県", latitude: "39.70361", longitude:"141.1525"))
        list.append(RegionModel(regionCode: "4", regionName: "宮城県", latitude: "38.26889", longitude:"140.87194"))
        list.append(RegionModel(regionCode: "5", regionName: "秋田県", latitude: "39.71861", longitude:"140.1025"))
        list.append(RegionModel(regionCode: "6", regionName: "山形県", latitude: "38.24056", longitude:"140.36333"))
        list.append(RegionModel(regionCode: "7", regionName: "福島県", latitude: "37.75", longitude:"140.46778"))
        list.append(RegionModel(regionCode: "8", regionName: "茨城県", latitude: "36.56583,", longitude:"140.44667"))
        list.append(RegionModel(regionCode: "9", regionName: "栃木県", latitude: "36.56583", longitude:"139.88361"))
        list.append(RegionModel(regionCode: "10", regionName: "群馬県", latitude: "36.39111", longitude:"139.06083"))
        list.append(RegionModel(regionCode: "11", regionName: "埼玉県", latitude: "35.85694", longitude:"139.64889"))
        list.append(RegionModel(regionCode: "12", regionName: "千葉県", latitude: "35.60472", longitude:"140.12333"))
        list.append(RegionModel(regionCode: "13", regionName: "東京都", latitude: "35.68944", longitude:"139.69167"))
        list.append(RegionModel(regionCode: "14", regionName: "神奈川県", latitude: "35.44778", longitude:"139.6425"))
        list.append(RegionModel(regionCode: "15", regionName: "新潟県", latitude: "37.90222", longitude:"139.02361"))
        list.append(RegionModel(regionCode: "16", regionName: "富山県", latitude: "36.69528", longitude:"137.21139"))
        list.append(RegionModel(regionCode: "17", regionName: "石川県", latitude: "36.59444", longitude:"136.62556"))
        list.append(RegionModel(regionCode: "18", regionName: "福井県", latitude: "36.06528", longitude:"136.22194"))
        list.append(RegionModel(regionCode: "19", regionName: "山梨県", latitude: "35.66389", longitude:"138.56833"))
        list.append(RegionModel(regionCode: "20", regionName: "長野県", latitude: "36.65139", longitude:"138.18111"))
        list.append(RegionModel(regionCode: "21", regionName: "岐阜県", latitude: "35.39111", longitude:"136.72222"))
        list.append(RegionModel(regionCode: "22", regionName: "静岡県", latitude: "34.97694", longitude:"138.38306"))
        list.append(RegionModel(regionCode: "23", regionName: "愛知県", latitude: "35.18028", longitude:"136.90667"))
        list.append(RegionModel(regionCode: "24", regionName: "三重県", latitude: "34.73028", longitude:"136.50861"))
        list.append(RegionModel(regionCode: "25", regionName: "滋賀県", latitude: "35.00444", longitude:"135.86833"))
        list.append(RegionModel(regionCode: "26", regionName: "京都府", latitude: "35.02139", longitude:"135.75556"))
        list.append(RegionModel(regionCode: "27", regionName: "大阪府", latitude: "34.68639", longitude:"135.52"))
        list.append(RegionModel(regionCode: "28", regionName: "兵庫県", latitude: "34.69139", longitude:"135.18306"))
        list.append(RegionModel(regionCode: "29", regionName: "奈良県", latitude: "34.68528", longitude:"135.83278"))
        list.append(RegionModel(regionCode: "30", regionName: "和歌山県", latitude: "34.22611", longitude:"135.1675"))
        list.append(RegionModel(regionCode: "31", regionName: "鳥取県", latitude: "35.50361", longitude:"134.23833"))
        list.append(RegionModel(regionCode: "32", regionName: "島根県", latitude: "35.47222", longitude:"133.05056"))
        list.append(RegionModel(regionCode: "33", regionName: "岡山県", latitude: "34.66167", longitude:"133.935"))
        list.append(RegionModel(regionCode: "34", regionName: "広島県", latitude: "34.39639", longitude:"132.45944"))
        list.append(RegionModel(regionCode: "35", regionName: "山口県", latitude: "34.18583", longitude:"131.47139"))
        list.append(RegionModel(regionCode: "36", regionName: "徳島県", latitude: "34.06583", longitude:"134.55944"))
        list.append(RegionModel(regionCode: "37", regionName: "香川県", latitude: "34.34028", longitude:"134.04333"))
        list.append(RegionModel(regionCode: "38", regionName: "愛媛県", latitude: "33.84167", longitude:"132.76611"))
        list.append(RegionModel(regionCode: "39", regionName: "高知県", latitude: "33.55972", longitude:"133.53111"))
        list.append(RegionModel(regionCode: "40", regionName: "福岡県", latitude: "33.60639", longitude:"130.41806"))
        list.append(RegionModel(regionCode: "41", regionName: "佐賀県", latitude: "33.24944", longitude:"130.29889"))
        list.append(RegionModel(regionCode: "42", regionName: "長崎県", latitude: "32.74472", longitude:"129.87361"))
        list.append(RegionModel(regionCode: "43", regionName: "熊本県", latitude: "32.78972", longitude:"130.74167"))
        list.append(RegionModel(regionCode: "44", regionName: "大分県", latitude: "33.23806", longitude:"131.6125"))
        list.append(RegionModel(regionCode: "45", regionName: "宮崎県", latitude: "31.91111", longitude:"131.42389"))
        list.append(RegionModel(regionCode: "46", regionName: "鹿児島県", latitude: "31.56028", longitude:"130.55806"))
        list.append(RegionModel(regionCode: "47", regionName: "沖縄県", latitude: "26.2125", longitude:"127.68111"))
    }
}
