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
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "primaryColor")
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    // MARK: - Main body
    var body: some View {
        VStack {
            Text("New")
                .fontWeight(.bold)
                .foregroundColor(.primary)
            .padding()
            
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
    }
    
}

#Preview {
    CreateFormView()
}


