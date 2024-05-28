//
//  FormQA.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 25.03.2024.
//

import SwiftUI
import PhotosUI
import Moya


struct FormQA: View {
    
    @State var questionHolder: String = ""
    @State var descriptionHolder: String = ""
    
    @State var selectedItemImage: PhotosPickerItem?
    @State var selectedImage: UIImage?
    
    @State var showLoad = false
    @State var showAlert = false
    
    @State var alertStatus = false
    @State var alertMessage = ""
    
    @StateObject var createTask = CreateTaskManager()
    
    
    var body: some View {
        ZStack{
            qa
            
            if showLoad {
                LoadingView()
            }
            if showAlert {
                CustomAlert(isSuccess: alertStatus, message: alertMessage)
            }
        }
    }
    
    var qa: some View{
        VStack(){
            HStack{
                Text("Question title")
                Spacer()
            }
            .padding(.horizontal)
            CustomTextField(placeholder: "Title", textHolder: $questionHolder)
            
            HStack{
                Text("Description")
                Spacer()
            }
            .padding(.horizontal)
            CustomTextField(placeholder: "Description", textHolder: $descriptionHolder)
            
            photoPicker
            Spacer()
            CustomButton(title: "Upload"){
                guard let uiImage: UIImage = selectedImage else { return }

                self.showLoad = true
                if !questionHolder.isEmpty, !descriptionHolder.isEmpty {
                    print("createTask.showLoad: \(createTask.showLoad)")
                    NetworkService.shared.uploadQuestion(QACreateModel(title: questionHolder, description: descriptionHolder), with: uiImage) { result in
                        switch result {
                        case .success(let success):
                            DispatchQueue.main.async {
                                self.showLoad = false
                                self.showAlert = true
                                self.alertStatus = success.success
                                self.alertMessage = "Question successfully created"
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.showAlert = false
                            }
                        case .failure(let failure):
                            DispatchQueue.main.async {
                                self.showLoad = false
                                self.showAlert = true
                                self.alertStatus = false
                                self.alertMessage = "Unfortunaly question was not created"
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.showAlert = false
                            }
                            print(failure)
                        }
                    }
                } else {
                    print("Something went wrong, please fill mandatory lines")
                }
                
                questionHolder = ""
                descriptionHolder = ""
                selectedImage = nil
            }
            .padding()
        }
        .font(.system(size: 16, weight: .bold))
        
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
                            async {
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
//                        .clipShape(Circle())
//                        .frame(width: 100, height: 100)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }
    
    
}

#Preview {
    FormQA()
}
