//
//  LoginView.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 24.02.2024.
//

import SwiftUI

struct LoginView: View {
    
    @State var email: String = "corg@test.com"
    
    @State var password: String = "password"
    
    @State private var navigationLinkActive = false
    @State private var showLoad = false
    
    let authService = AuthService.shared
    
    var body: some View {
        ZStack {
            VStack {
                Text("Hello, again!")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.top, 50)
                
                Text("Good day student! Please enter your info to login")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
                
                
                CustomTextField(placeholder: "E-mail", textHolder: $email)
                    .padding(.vertical)
                
                SecureTextField(text: $password)
                    .padding()
                
                Spacer()
                NavigationLink(destination: MainTabView(), isActive: $navigationLinkActive) { EmptyView() }

                signInBtn
                    .padding()
                
                NavigationLink {
                    RegistrationView()
                } label: {
                    Text("Do not you have an account?")
                        .fontWeight(.medium)
                        .padding(.bottom, 20)
                        .foregroundColor(.blue)
                }
            }
            
            if showLoad {
                LoadingView()
            }
            
        }
        .navigationTitle("Sign in")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var signInBtn: some View {
        
        Button (action: {
            self.showLoad = true
            print("Start of loading...")
            Task {
                print("processsing...")
                authService.login(email: email, password: password)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.showLoad = false
                    self.navigationLinkActive = true
                }
            }
        }) {
            Text("Sign in")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
        }
        .background{
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("primaryColor"))
        }
    }
}

struct SecureTextField: View {
    
    @State private var isSecureField: Bool = true
    @Binding var text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("announceBG"))
                .frame(height: 40)
            HStack{
                if isSecureField {
                    SecureField("Password", text: $text)
                } else {
                    TextField(text.isEmpty ? "Password" : text, text: $text)
                        .autocapitalization(.none)
                }
                    
            }
            .padding(.leading, 8)
            
            .overlay(alignment: .trailing) {
                Image(systemName: isSecureField ? "eye.slash": "eye")
                    .padding(.horizontal, 8)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        isSecureField.toggle()
                    }
            }
        }
    }
}

#Preview {
    LoginView()
}
