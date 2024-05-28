//
//  SkillSwapView.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 24.03.2024.
//

import SwiftUI
import PhotosUI

struct FormSkillSwap: View {
    
    // MARK: Variables
    @State var skillHolder: String = ""
    @State var descriptionHolder: String = ""
    @State var priceHolder: Int = 0
    @State var selectedDate = Date()
    @State private var selectedCategory = SkillSwapCategory.learing

    @State var selectedItemImage: PhotosPickerItem?
    @State var selectedImage: UIImage?
    
    @State var isExchnage: Bool = false
    @State var model: SkillSwapModel?
    
    
    @State var showLoad = false
    @State var showAlert = false
    
    @State var alertStatus = false
    @State var alertMessage = ""
    
    @State var serverResponse: Response?
    
    var body: some View {
        ZStack{
            skillSwap
            if showLoad {
                LoadingView()
            }
            if showAlert {
                CustomAlert(isSuccess: alertStatus, message: alertMessage)
            }
        }
    }
    // MARK: -Skill Swap
    var skillSwap: some View{
        VStack{
            HStack{
                Text("Skill")
                Spacer()
            }
            .padding(.horizontal)
            CustomTextField(placeholder: "Key words", textHolder: $skillHolder)
            
            HStack{
                Text("Description")
                Spacer()
            }
            .padding(.horizontal)
            CustomTextField(placeholder: "Type description", textHolder: $descriptionHolder)
            
            HStack{
                Text("Price")
                Spacer()
            }
            .padding(.horizontal)
            CustomTextFieldNumeric(placeholder: "Type number", textHolder: $priceHolder)
            
            photoPicker
            
            CustomButton(title: "Upload") {
                guard let uiImage: UIImage = selectedImage else { return }
                self.showLoad = true
                if !skillHolder.isEmpty, !descriptionHolder.isEmpty, !priceHolder.words.isEmpty {
                    let model = SkillSwapCreate(title: skillHolder, content: descriptionHolder, price: priceHolder)
                    NetworkService.shared.uploadPost(model, with: uiImage) { result in
                        switch result {
                        case .success(let success):
                            DispatchQueue.main.async {
                                self.showLoad = false
                                self.showAlert = true
                                self.alertStatus = success.success
                                self.alertMessage = "Post successfully created"
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.showAlert = false
                            }
                        case .failure(let failure):
                            DispatchQueue.main.async {
                                self.showLoad = false
                                self.showAlert = true
                                self.alertStatus = false
                                self.alertMessage = "Pleasse fill all required lines correctly"
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.showAlert = false
                            }
                        }
                    }
                } else {
                    print("Something went wrong, please fill mandatory lines")
                }
                skillHolder = ""
                descriptionHolder = ""
                priceHolder = 0
                selectedImage = nil
            }
            .padding(30)
            Spacer()
        }
        .font(.system(size: 16, weight: .bold))
    }
    
    // MARK: -UI Elements
    var datePicker: some View{
        VStack{
            HStack{
                Text("Date")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                Spacer()
            }
            CustomDatePicker(selectedDate: $selectedDate, title: "From", systemImage: "calendar")
        }
    }
    
    var photoPicker: some View{
        VStack{
            HStack {
                Text("Photo")
                    .font(.headline)
                    .foregroundColor(.primary)
                .padding(.horizontal)
                Spacer()
            }
            HStack{
                Text("Add your file")
                    .fontWeight(.regular)
                    .foregroundColor(Color("primaryColor"))
                Spacer()
                PhotosPicker(selection: $selectedItemImage) {
                    Image(systemName: "paperclip")
                        .foregroundColor(Color("primaryColor"))
                        .font(.system(size: 18, weight: .medium))
                        .onChange(of: selectedItemImage) { _, _ in
                            Task{
                                if let selectedItemImage,
                                   let data = try? await selectedItemImage.loadTransferable(type: Data.self){
                                    if let image = UIImage(data: data){
                                        selectedImage = image
                                    }
                                }
                                selectedItemImage = nil
                            }
                        }
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            
            if let image = selectedImage {
                HStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }
    
    var checkBox: some View{
        HStack{
            Text("Exchange")
                .font(.system(size: 18, weight: .medium))
                .fontDesign(.monospaced)
                .foregroundColor(isExchnage ? Color("primaryColor") : .gray)
            
            Spacer()
            
            Toggle(isOn: $isExchnage) {
                Text("I'm not a robot")
            }
            .toggleStyle(CheckboxToggleStyle())

        }
        .padding()
    }
}

#Preview {
    FormSkillSwap()
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .font(.system(size: 20))
                    .foregroundColor(configuration.isOn ? Color("primaryColor") : .gray)
            }
        })
    }
}
