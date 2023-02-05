//
//  ConverterModel.swift
//  Converter
//
//  Created by Vlad Kulakovsky  on 15.12.22.
//

import Foundation

struct Currency: Decodable {
    var name: String
    var id: Int
    var rate: Double
    var abb: String
    var scale: Int
    
    enum CodingKeys: String, CodingKey {
            case name = "Cur_Name"
            case id = "Cur_ID"
            case rate = "Cur_OfficialRate"
            case abb = "Cur_Abbreviation"
            case scale = "Cur_Scale"
        }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(Int.self, forKey: .id)
        rate = try container.decode(Double.self, forKey: .rate)
        abb = try container.decode(String.self, forKey: .abb)
        scale = try container.decode(Int.self, forKey: .scale)
    }
    
    init(name: String, id: Int, rate: Double, abb: String, scale: Int) {
        self.name = name
        self.id = id
        self.rate = rate
        self.abb = abb
        self.scale = scale
    }
}
