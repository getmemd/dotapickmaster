//
//  HeroResponse.swift
//  DotaPickMaster
//
//  Created by Adilkhan Medeuyev on 21.10.2024.
//

import Foundation

public struct HeroResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case localizedName = "localized_name"
        case primaryAttr = "primary_attr"
        case roles
    }
    
    let id: Int
    let name: String
    let localizedName: String
    let primaryAttr: String
    let roles: [String]
}
