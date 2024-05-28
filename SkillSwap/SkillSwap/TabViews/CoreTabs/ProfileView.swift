//
//  ProfileView.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 03.03.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @State var showAlert: Bool = false
    private var name = AuthService.shared.authData?.name
    private var email = AuthService.shared.authData?.email
    
    var body: some View {
        VStack{
            profileImageGroup
            profileAnounsments
            list
            Spacer()
        }
        .accentColor(Color("primaryColor"))
    }
    
    var profileAnounsments: some View{
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                MyProfileAnounsment(firstTitle: "You have 5 skills", secondTitle: "Let's get more", thirdTitle: "23 request")
                MyProfileAnounsment(firstTitle: "You have 1 project", secondTitle: "2 000 000T planned", thirdTitle: "124 050T collected")
                MyProfileAnounsment(firstTitle: "You have 6 Q/A", secondTitle: "4 not answered", thirdTitle: "2 have succed closed")
            }
            .padding()
        }
        .frame(height: 100)
        .padding(.vertical)
    }
    
    var profileImageGroup: some View{
        HStack(spacing: 10){
            Image("profile")
                .resizable()
                .frame(width: 62, height: 62)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 10){
                Text("\(name!)")
                    .font(.system(size: 20, weight: .semibold))
                Text("\(email!)")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
    }
    
    
    
    var list: some View{
            List{
                NavigationLink {
                    AboutMeView()
                        .navigationTitle("About me")
                        .toolbar(Visibility.hidden, for: .tabBar)
                } label: {
                    ProfileListElement(iconTitle: "person", title: "About me")
                }
                
                NavigationLink {
                    MySkillsView()
                        .navigationTitle("My skills")
                        .toolbar(Visibility.hidden, for: .tabBar)
                } label: {
                    ProfileListElement(iconTitle: "person.badge.shield.checkmark", title: "My skills")
                }
            
                NavigationLink {
                    MyQuestionsView()
                        .navigationTitle("My Projects")
                        .toolbar(Visibility.hidden, for: .tabBar)
                } label: {
                    ProfileListElement(iconTitle: "questionmark.bubble", title: "My questions")
                }
                
                NavigationLink {
                    MyProjectsView()
                        .navigationTitle("My Projects")
                        .toolbar(Visibility.hidden, for: .tabBar)
                } label: {
                    ProfileListElement(iconTitle: "newspaper", title: "My projects")
                }
                
                ProfileListElement(iconTitle: "beats.headphones", title: "Contact us")
                
                NavigationLink(
                    destination: SettingsView()
                        .navigationTitle("Settings")
                        .toolbar(Visibility.hidden, for: .tabBar)
                ) {
                    ProfileListElement(iconTitle: "gear", title: "Settings")
                }
                
                ProfileListElement(iconTitle: "rectangle.portrait.and.arrow.right", title: "Log out")
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Are you sure you want to come out?"),
                              primaryButton: .destructive(Text("Quit")) {
                            AuthService.shared.logout()
                            print("User logged out")
                        },
                              secondaryButton: .cancel(Text("Cancel")))
                    }
                    .onTapGesture {
                        showAlert.toggle()
                    }
            }
            .listStyle(.plain)
            .padding(.vertical)
        
    }
    
}

struct MyProfileAnounsment: View {
    var firstTitle: String
    var secondTitle: String
    var thirdTitle: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color("announceBG"))
                .frame(minWidth: 140)
            VStack(alignment: .leading, spacing: 5){
                Text(firstTitle)
                    .font(.system(size: 12))
                Text(secondTitle)
                    .font(.system(size: 10))
                Text(thirdTitle)
                    .font(.system(size: 14))
                    .padding(.vertical)
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
        }
    }
}

struct ProfileListElement: View {
    var iconTitle: String
    var title: String
    
    var body: some View {
        HStack{
            Image(systemName: iconTitle)
                .resizable()
                .foregroundColor(Color("primaryColor"))
                .frame(width: 28, height: 28)
                .foregroundColor(.gray)
            Text(title)
                .foregroundColor(Color("primaryColor"))
                .font(.system(size: 14, weight: .semibold))
            
        }

    }
}

#Preview {
    ProfileView()
}
