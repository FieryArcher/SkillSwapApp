//
//  MainTabView.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 03.03.2024.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var showTabBar = true
    @State var searchTxt: String = ""
    
    var body: some View {
        NavigationView{
            VStack(spacing: 0){
                TabView {
                    HomeView()
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                    SkillSwapView()
                        .tabItem {
                            Image(systemName: "arrow.up.left.arrow.down.right.circle")
                            Text("Exchange")
                        }
                    CreateFormView()
                        .tabItem {
                            Image(systemName: "plus.circle")
                            Text("Add")
                        }
                    QAView()
                        .tabItem {
                            Image(systemName: "list.bullet.circle")
                            Text("Q/A")
                        }
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person")
                            Text("Profile")
                        }
                }
                .edgesIgnoringSafeArea(showTabBar ? .bottom : [])
            }
        }
    }
}

#Preview {
    MainTabView()
}
