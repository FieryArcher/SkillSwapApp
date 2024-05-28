//
//  ContentView.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 24.02.2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var accountManager: AuthService
    
    var body: some View {
        NavigationStack {
            if accountManager.isLoggedIn {
                MainTabView()
                    .navigationTitle("Skill swap app")
//                    .toolbar(Visibility.hidden, for: .tabBar)
            } else {
                LoginView()
            }
        }
        
    }
}

#Preview {
    ContentView()
}
