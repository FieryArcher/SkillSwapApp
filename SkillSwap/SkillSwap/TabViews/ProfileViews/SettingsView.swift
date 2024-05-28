//
//  SettingsView.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 25.03.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @State var isNotificationChanged: Bool = false
    
    var body: some View {
        VStack {
            settings
                .navigationBarTitleDisplayMode(.inline)
        }
    }
        
    var settings: some View{
        VStack{
            SettingsRecicle(mainTitle: "Notification", secondaryText: "Turn on or off notification", isEnabled: true, isShownToggle: $isNotificationChanged)
            
            SettingsRecicle(mainTitle: "Language", secondaryText: "English", isShownToggle: $isNotificationChanged)
            
            SettingsRecicle(mainTitle: "City", secondaryText: "Almaty", isShownToggle: $isNotificationChanged)
            
            
            SettingsRecicle(mainTitle: "Number", secondaryText: "+7 777 *** ** 00", isShownToggle: $isNotificationChanged)
            
            
            SettingsRecicle(mainTitle: "Email", secondaryText: "j*****@gmail.com", isShownToggle: $isNotificationChanged)
            
            
            SettingsRecicle(mainTitle: "Password", secondaryText: "********", isShownToggle: $isNotificationChanged)
            
            Spacer()
            
            VStack{
                HStack(spacing: 15){
                    Image("whatsapp_icon")
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                    Image("instagram_icon")
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                    Image("telegram_icon")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                Text("skillswap.kz")
                    .font(.system(size: 16, weight: .semibold))
            }
        }
        .padding(.vertical)
    }
}

struct SettingsRecicle: View {
    
    var mainTitle: String
    var secondaryText: String
    var isEnabled: Bool = false
    
    @Binding var isShownToggle: Bool
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 5){
                Text(mainTitle)
                    .font(.system(size: 16, weight: .medium))
                Text(secondaryText)
                    .foregroundColor(.gray)
                    .font(.system(size: 12, weight: .regular))
            }
            Spacer()
            
            if isEnabled{
                Toggle(isOn: $isShownToggle, label: {
                    EmptyView()
                })
//                .tint(Color("primaryColor").opacity(0.8))
            }
            else{
                Image(systemName: "chevron.right")
                    .foregroundColor(Color("primaryColor"))
                    .font(.system(size: 15))
                    .padding(5)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

#Preview {
    SettingsView()
}
