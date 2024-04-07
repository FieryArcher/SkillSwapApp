//
//  RegistrationView.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 24.02.2024.
//

import SwiftUI

struct RegistrationView: View {
    @State var selectedGender: Gender = .female
    
    @State var nameTextField: String = ""
    @State var lastNameTextField: String = ""
    
    @State var emailAddress: String = ""
    @State var contactNumber: String = ""
    
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    @State var isAgreeTerms: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "chevron.left")
                    .font(.system(size: 25))
                    .foregroundColor(Color("primaryColor"))
                    .padding()
                Spacer()
                Text("Registration")
                    .foregroundColor(Color("primaryColor"))
                    .padding(.trailing, 40)
                //            Spacer()
                loginButton
                    .padding(.trailing, 10)
            }
            selectGender.padding()
            Divider()
                .padding(.horizontal)
            
            
            HStack{
                FormElement(textFieldBinding: $nameTextField, placeholder: "name".capitalized)
                
                FormElement(textFieldBinding: $lastNameTextField, placeholder: "Lastname".capitalized)
                
            }
            .padding(.vertical, 10)

            HStack{
                FormElement(textFieldBinding: $emailAddress, placeholder: "Email address".capitalized, isOptional: false)
                
                FormElement(textFieldBinding: $contactNumber, placeholder: "Contact number".capitalized, isOptional: false)
            }
            .padding(.vertical, 10)

            HStack{
                FormElement(textFieldBinding: $password, placeholder: "password".capitalized)
                
                FormElement(textFieldBinding: $confirmPassword, placeholder: "confirm password".capitalized)
            }
            .padding(.vertical, 10)
            
            HStack {
                Toggle(isOn: $isAgreeTerms) {
                    Text("I'm acquainted with terms and policy")
                        .textCase(.uppercase)
                        .font(.system(size: 10))
                        .padding(.horizontal, 5)
                }
                .toggleStyle(iOSCheckboxToggleStyle())
                Spacer()
            }
            .padding(.horizontal)
            
            CostomButtonText(title: "Register")
                .padding()
            
            Spacer()
            HStack{
                Spacer()
                Text("Terms and policy")
                    .padding(.horizontal, 20)
                    .bold()
            }
        }
        .foregroundColor(Color("primaryColor"))
    }
    
    
    var loginButton: some View{
        ZStack{
            Capsule()
                .foregroundColor(Color("buttonBG"))
                .frame(width: 100,height: 40)
            HStack{
                Image(systemName: "person")
                Text("Log in")
                    .padding(.trailing, 5)
            }
            
        }
    }
    
    
    var selectGender: some View{
        VStack{
            
            Text("select your gender")
                .textCase(.uppercase)
                .font(.system(size: 10))
            
            HStack{
                ForEach(Gender.allCases, id: \.self) { gender in
                    VStack(alignment: .center){
                        Text(gender.rawValue)
                            .textCase(.uppercase)
                            .font(.system(size: 10))
                            .padding(10)
                        VStack(alignment: .center){
                            Toggle("", isOn: Binding<Bool>(
                                get: {return selectedGender == gender},
                                set: { newValue in
                                    if newValue {
                                        selectedGender = gender
                                    }
                                }
                            ))
                            .labelsHidden()
                            .padding(.horizontal, 20)
                        }
                    }
                }
                
            }
        }
    }
    
}

struct FormElement: View{
    @Binding var textFieldBinding: String
    var placeholder: String
    var isOptional: Bool = true
    
    var body: some View{
        VStack{
            HStack {
                Text("Enter \(placeholder)")
                    .textCase(.uppercase)
                    .font(.system(size: 10))
                .padding()
                Spacer()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("buttonBG"))
                    .padding(5)
                HStack {
                    TextField(text: $textFieldBinding) {
                        Text(placeholder)
                    }
                    if isOptional{
                        Image(systemName: "wand.and.stars")
                    }
                }
                .padding()
            }
            Divider()
                .foregroundColor(.red)
                .padding(.horizontal)
        }
    }
}

struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                configuration.label
            }
        })
    }
}


struct CostomButtonText: View {
    var title: String
    var body: some View {
        Text(title)
            .textCase(.uppercase)
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(Color("primaryColor"))
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("buttonBG"))
            .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

#Preview {
    RegistrationView()
}
