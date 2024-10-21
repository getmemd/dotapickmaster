//
//  HeroSelectionViewModel.swift
//  DotaPickMaster
//
//  Created by Adilkhan Medeuyev on 20.10.2024.
//

import Combine

@MainActor
final class HeroPickerViewModel: ObservableObject {
    @Published var heroes: [Hero] = []
    
    func getHeroes() {
        Task {
            do {
                heroes = try await Repository.fetchHeroes()
            } catch {
                print(error)
            }
        }
    }
}
