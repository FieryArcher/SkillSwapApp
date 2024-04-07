//
//  SkillSwapApp.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 24.02.2024.
//

import SwiftUI

@main
struct SkillSwapApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.font, Font.custom("Segoe UI", size: 16))
        }
    }
}

