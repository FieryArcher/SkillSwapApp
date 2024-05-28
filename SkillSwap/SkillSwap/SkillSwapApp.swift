//
//  SkillSwapApp.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 24.02.2024.
//

import SwiftUI

@main
struct SkillSwapApp: App {
    
    @StateObject var authService = AuthService.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
                    .environmentObject(authService)
                    .environment(\.font, Font.custom("Segoe UI", size: 16))
            }
        }
    }
}

