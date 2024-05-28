//
//  FormCrowdfunding.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 24.03.2024.
//

import SwiftUI
import PhotosUI

struct FormCrowdfunding: View {
    
    //MARK: -Variables
    @State var title: String = ""
    @State var content: String = ""
    @State var amountMoney: String = ""
    @State var planningMoney: String = ""
    
    @State var selectedCrownfundingCategory: CrowdfundingCategory = .materialThing
    
    
    @State private var resultModel: CrowdfundResponseData?
    
    @State var selectedItemImage: PhotosPickerItem?
    @State var selectedImage: UIImage?
    
    //MARK: - ALERTS
    @State var showLoad = false
    @State var showAlert = false
    
    @State var alertStatus = false
    @State var alertMessage = ""
    
    //MARK: -Main block
    var body: some View {
        ZStack{
            crowdFunding
            if showLoad {
                LoadingView()
            }
            if showAlert {
                CustomAlert(isSuccess: alertStatus, message: alertMessage)
            }
            
        }
    }
    
    var crowdFunding: some View{
        
        VStack{
            HStack{
                Text("Project title")
                Spacer()
            }
            .padding(.horizontal)
            CustomTextField(placeholder: "Title", textHolder: $title)
            
            HStack{
                Text("Description")
                Spacer()
            }
            .padding(.horizontal)
            CustomTextField(placeholder: "Description of the project", textHolder: $content)
            
            HStack{
                Text("Earned Money")
                Spacer()
            }
            .padding(.horizontal)
            CustomTextField(imageName: "moneyIcon", placeholder: "Now you have", textHolder: $amountMoney)
            
            HStack{
                Text("Planned Money")
                Spacer()
            }
            .padding(.horizontal)
            CustomTextField(imageName: "moneyIcon",placeholder: "Planned one", textHolder: $planningMoney)
            
            photoPicker
            
            CustomButton(title: "Upload"){
                
                guard let uiImage = selectedImage else { return }
                
                self.showLoad = true
                
                guard !title.isEmpty, !content.isEmpty, !amountMoney.isEmpty, !planningMoney.isEmpty else {
                    return
                }
                
                let model = CrowdfundPostData(title: title, content: content, amountMoney: amountMoney, plannedMoney: planningMoney)
                
                NetworkService.shared.uploadFund(model, with: uiImage) { result in
                    switch result {
                    case .success(let success):
                        DispatchQueue.main.async {
                            self.showLoad = false
                            self.showAlert = true
                            self.alertStatus = success.success
                            self.alertMessage = "Crowdfund successfully created"
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.showAlert = false
                        }
                    case .failure(let failure):
                        DispatchQueue.main.async {
                            self.showLoad = false
                            self.showAlert = true
                            self.alertStatus = false
                            self.alertMessage = "Unfortunaly crowdfund was not created"
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.showAlert = false
                        }
                    }
                }
                
                title = ""
                content = ""
                amountMoney = ""
                planningMoney = ""
                selectedImage = nil
                
            }
            .padding(30)
            
            Spacer()
            
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
}

#Preview {
    FormCrowdfunding()
}
