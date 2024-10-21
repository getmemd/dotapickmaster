//
//  DotaPickMasterApp.swift
//  DotaPickMaster
//
//  Created by Adilkhan Medeuyev on 20.10.2024.
//

import SwiftUI

@main
struct DotaPickMasterApp: App {
    var body: some Scene {
        WindowGroup {
            HeroSelectionView(viewModel: .init())
        }
    }
}
