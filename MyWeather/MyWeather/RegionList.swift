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
    init() {
        list.append(RegionModel(regionCode: "016010", regionName: "北海道"))
        list.append(RegionModel(regionCode: "020010", regionName: "青森県"))
        list.append(RegionModel(regionCode: "030010", regionName: "岩手県"))
        list.append(RegionModel(regionCode: "040010", regionName: "宮城県"))
        list.append(RegionModel(regionCode: "050010", regionName: "秋田県"))
        list.append(RegionModel(regionCode: "060010", regionName: "山形県"))
        list.append(RegionModel(regionCode: "070010", regionName: "福島県"))
        list.append(RegionModel(regionCode: "080010", regionName: "茨城県"))
        list.append(RegionModel(regionCode: "090010", regionName: "栃木県"))
        list.append(RegionModel(regionCode: "100010", regionName: "群馬県"))
        list.append(RegionModel(regionCode: "110010", regionName: "埼玉県"))
        list.append(RegionModel(regionCode: "120010", regionName: "千葉県"))
        list.append(RegionModel(regionCode: "130010", regionName: "東京都"))
        list.append(RegionModel(regionCode: "140010", regionName: "神奈川県"))
        list.append(RegionModel(regionCode: "150010", regionName: "新潟県"))
        list.append(RegionModel(regionCode: "160010", regionName: "富山県"))
        list.append(RegionModel(regionCode: "170010", regionName: "石川県"))
        list.append(RegionModel(regionCode: "180010", regionName: "福井県"))
        list.append(RegionModel(regionCode: "190010", regionName: "山梨県"))
        list.append(RegionModel(regionCode: "200010", regionName: "長野県"))
        list.append(RegionModel(regionCode: "210010", regionName: "岐阜県"))
        list.append(RegionModel(regionCode: "220010", regionName: "静岡県"))
        list.append(RegionModel(regionCode: "230010", regionName: "愛知県"))
        list.append(RegionModel(regionCode: "240010", regionName: "三重県"))
        list.append(RegionModel(regionCode: "250010", regionName: "滋賀県"))
        list.append(RegionModel(regionCode: "260010", regionName: "京都府"))
        list.append(RegionModel(regionCode: "270000", regionName: "大阪府"))
        list.append(RegionModel(regionCode: "280010", regionName: "兵庫県"))
        list.append(RegionModel(regionCode: "290010", regionName: "奈良県"))
        list.append(RegionModel(regionCode: "300010", regionName: "和歌山県"))
        list.append(RegionModel(regionCode: "310010", regionName: "鳥取県"))
        list.append(RegionModel(regionCode: "320010", regionName: "島根県"))
        list.append(RegionModel(regionCode: "330010", regionName: "岡山県"))
        list.append(RegionModel(regionCode: "340010", regionName: "広島県"))
        list.append(RegionModel(regionCode: "350020", regionName: "山口県"))
        list.append(RegionModel(regionCode: "360010", regionName: "徳島県"))
        list.append(RegionModel(regionCode: "370000", regionName: "香川県"))
        list.append(RegionModel(regionCode: "380010", regionName: "愛媛県"))
        list.append(RegionModel(regionCode: "390010", regionName: "高知県"))
        list.append(RegionModel(regionCode: "400010", regionName: "福岡県"))
        list.append(RegionModel(regionCode: "410010", regionName: "佐賀県"))
        list.append(RegionModel(regionCode: "420010", regionName: "長崎県"))
        list.append(RegionModel(regionCode: "430010", regionName: "熊本県"))
        list.append(RegionModel(regionCode: "440010", regionName: "大分県"))
        list.append(RegionModel(regionCode: "450010", regionName: "宮崎県"))
        list.append(RegionModel(regionCode: "460010", regionName: "鹿児島県"))
        list.append(RegionModel(regionCode: "471010", regionName: "沖縄県"))
    }
}
