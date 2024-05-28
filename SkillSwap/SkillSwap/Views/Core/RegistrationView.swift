//
//  RegistrationView.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 24.02.2024.
//

import SwiftUI


struct RegistrationView: View {
    
    @State var accountType: AccountType = .user
    @State var selectedGender: Gender = .female
    
    @State var nameTextField: String = ""
    @State var lastNameTextField: String = ""
    
    @State var emailAddress: String = ""
    @State var contactNumber: Int?
    
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    @State var isAgreeTerms: Bool = false
    
    //MARK: alerts
    
    @State private var showAlert = false
    @State private var showLoading = false
    @State var alertSuccess: Bool = false
    @State var alertMessage: String = ""
    
    @State private var redirectToAnotherPage = false
    
    @State private var alertShown = false

    
    var body: some View {
        
        ZStack {
            ScrollView{
                upperSide
                downSide
                Spacer()
            }
            if showLoading {
                LoadingView()
            }
            if showAlert{
                CustomAlert(isSuccess: alertSuccess, message: alertMessage)
            }
            
            NavigationLink(destination: LoginView(), isActive: $redirectToAnotherPage) {
                EmptyView()
            }
            
        }
        .navigationTitle("Registration")
        .foregroundColor(Color("primaryColor"))
    }
    
    var upperSide: some View {
        VStack{
            DropDownMenuAccountType(selectedCategory: $accountType).padding(.top, 20)
            selectGender.padding()
            Divider().padding(.horizontal)

            HStack{
                FormElement(textFieldBinding: $nameTextField, placeholder: "name".capitalized)
                FormElement(textFieldBinding: $lastNameTextField, placeholder: "Lastname".capitalized)
            }
            .padding(.vertical, 10)

            HStack{
                FormElement(textFieldBinding: $emailAddress, placeholder: "Email address".capitalized)
                    .autocapitalization(.none)
                FormElementNumeric(numericField: $contactNumber, placeholder: "Contact Number")
            }
            .padding(.vertical, 10)

            VStack{
                HStack {
                    Text("Enter password")
                        .textCase(.uppercase)
                        .font(.system(size: 10))
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                    Spacer()
                }
                SecureTextField(text: $password)
            }
            .padding(8)
        }
    }
    
    var downSide: some View{
        VStack{
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
            
            //MARK: -Network Service calling...
            CostomButtonText(title: "Register"){
                self.showLoading = true
                print("Name is - \(nameTextField)")
                
                if !nameTextField.isEmpty, !lastNameTextField.isEmpty,
                   !emailAddress.isEmpty,
                   !(password.count < 8) {
                    let user = User(emailAddress: emailAddress,
                                    gender: selectedGender.rawValue,
                                    contactNumber: contactNumber ?? 89,
                                    name: nameTextField,
                                    lastName: lastNameTextField,
                                    course: "",
                                    password: password,
                                    accountType: accountType.rawValue)
                    if user.validate() {
                        print("Данные пользователя валидны. Можно отправлять на сервер.")
                    } else {
                        print("Данные пользователя не соответствуют требованиям бекенда.")
                    }
                    
                    Task{
                        AuthService.shared.registerUser(user: user) { result in
                            let response: Response = result
                            print("This is our MESSAGE from server \(response.message)")
                            alertSuccess = response.success
                            alertMessage = response.message
                            print(response.success)
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        if !self.alertShown {
                            self.showAlert = true
                            self.showLoading = false
                            self.alertShown = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                self.showAlert = false
                                self.redirectToAnotherPage = true
                            }
                        }
                    }
                    print(user)
                }
            }
            .padding()
            
            HStack{
                Spacer()
                Text("Terms and policy")
                    .font(.system(size: 12, weight: .regular))
                    .padding(.horizontal, 20)
                    .bold()
            }
        }
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
                            .tint(Color("primaryColor"))
                            .padding(.horizontal, 20)
                        }
                    }
                }
                
            }
        }
    }
    
}


struct FormElementNumeric: View{
    @Binding var numericField: Int?
    var placeholder: String
    
    var body: some View{
        VStack{
            HStack {
                Text("Enter \(placeholder)")
                    .textCase(.uppercase)
                    .font(.system(size: 10))
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                Spacer()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("announceBG"))
                    .padding(5)
                HStack {
                    TextField(value: $numericField, format: .number) {
                        Text(placeholder)
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

struct FormElement: View{
    @Binding var textFieldBinding: String
    var placeholder: String
    
    var body: some View{
        VStack{
            HStack {
                Text("Enter \(placeholder)")
                    .textCase(.uppercase)
                    .font(.system(size: 10))
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                Spacer()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("announceBG"))
                    .padding(5)
                HStack {
                    TextField(text: $textFieldBinding) {
                        Text(placeholder)
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
    var action: () -> ()
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(title)
                .textCase(.uppercase)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("primaryColor"))
                .clipShape(RoundedRectangle(cornerRadius: 30))
        })
    }
}

#Preview {
    RegistrationView()
}
