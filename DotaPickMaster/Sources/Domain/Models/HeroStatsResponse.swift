//
//  HeroStatsResponse.swift
//  DotaPickMaster
//
//  Created by Adilkhan Medeuyev on 22.10.2024.
//

import Foundation

struct HeroStatsResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case primaryAttr = "primary_attr"
        case img
        case roles
        case localizedName = "localized_name"
        case pubPick = "pub_pick"
        case pubWin = "pub_win"
    }
    
    let id: Int
    let name: String
    let primaryAttr: String
    let img: String
    let roles: [String]
    let localizedName: String
    let pubPick: Int
    let pubWin: Int
}
