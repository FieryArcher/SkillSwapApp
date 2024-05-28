//
//  CreateFormView.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 03.03.2024.
//

import SwiftUI
import PhotosUI

struct CreateFormView: View {
    
    @State var selectedCategory: FormCategories = .skillSwap
    @StateObject var createTask = CreateTaskManager()
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "primaryColor")
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    // MARK: - Main body
    var body: some View {
        ZStack{
            VStack {
                
                Picker("Chose category", selection: $selectedCategory) {
                    ForEach(FormCategories.allCases, id: \.self){
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.palette)
                .padding()
                
                ScrollView {
                    ChosenFormView(selectedFormSide: selectedCategory)
                }
            }
            if createTask.showLoad {
                LoadingView()
            }
            
            if createTask.showAlert {
                CustomAlert(isSuccess: createTask.alertStatus, message: createTask.alertMessage)
            }
        
        }
    }
    
}

#Preview {
    CreateFormView()
}
