//
//  Hero.swift
//  DotaPickMaster
//
//  Created by Adilkhan Medeuyev on 20.10.2024.
//

import Foundation

struct Hero: Identifiable, Codable {
    enum Constants {
        static let imageBaseURL = "https://cdn.cloudflare.steamstatic.com"
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
    let img: String
    let pubWin: Int
    let pubPick: Int
    
    var imageUrl: String {
        return "\(Constants.imageBaseURL)\(img)"
    }
    
    var winRate: Double {
        Double(pubWin) / Double(pubPick) * 100
    }
    
    init(data: HeroStatsResponse) {
        id = data.id
        name = data.name
        localizedName = data.localizedName
        primaryAttr = .init(rawValue: data.primaryAttr) ?? .strength
        roles = data.roles.compactMap({ .init(rawValue: $0.lowercased()) })
        img = data.img
        pubWin = data.pubWin
        pubPick = data.pubPick
    }
}
