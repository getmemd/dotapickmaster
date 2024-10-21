//
//  OpenDotaRepository.swift
//  DotaPickMaster
//
//  Created by Adilkhan Medeuyev on 20.10.2024.
//

import Foundation

struct Repository {
    private static let baseUrl = "https://api.opendota.com/api/"
    
    enum NetworkError: Error {
        case invalidURL
        case requestFailed
        case decodingError
    }
    
    static func fetchHeroes() async throws -> [Hero] {
        guard let url = URL(string: "\(baseUrl)heroStats") else {
            throw NetworkError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.requestFailed
        }
        do {
            let decodedResponse = try JSONDecoder().decode([HeroStatsResponse].self, from: data)
            let heroes: [Hero] = decodedResponse.map { .init(data: $0) }
            return heroes
        } catch {
            throw NetworkError.decodingError
        }
    }
}
