//
//  Hero.swift
//  DotaPickMaster
//
//  Created by Adilkhan Medeuyev on 20.10.2024.
//

import Foundation

struct Hero: Identifiable, Codable {
    enum Constants {
        static let imageBaseURL = "https://cdn.dota2.com/apps/dota2/images/heroes/"
    }
    
    enum PrimaryAttr: String, Codable, CaseIterable, Identifiable {
        case strength = "str"
        case agility = "agi"
        case intelligence = "int"
        
        var id: String { self.rawValue }
        var displayName: String {
            switch self {
            case .strength: return "Strength"
            case .agility: return "Agility"
            case .intelligence: return "Intelligence"
            }
        }
    }
    
    enum Role: String, Codable, CaseIterable, Identifiable {
        case carry
        case support
        case nuker
        case disabler
        case durable
        case escape
        case pusher
        case initiator
        
        var id: String { self.rawValue }
        var displayName: String { self.rawValue.capitalized }
    }
    
    let id: Int
    let name: String
    let localizedName: String
    let primaryAttr: PrimaryAttr
    let roles: [Role]
    
    var imageUrl: String {
        let heroName = name.replacingOccurrences(of: "npc_dota_hero_", with: "")
        return "\(Constants.imageBaseURL)\(heroName)_lg.png"
    }
    
    init(data: HeroResponse) {
        id = data.id
        name = data.name
        localizedName = data.localizedName
        primaryAttr = .init(rawValue: data.primaryAttr) ?? .strength
        roles = data.roles.compactMap({ .init(rawValue: $0.lowercased()) })
    }
}
