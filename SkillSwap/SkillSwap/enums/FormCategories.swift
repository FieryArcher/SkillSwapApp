//
//  FormCategories.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 03.03.2024.
//

import Foundation
import SwiftUI

enum FormCategories: String, CaseIterable{
    case skillSwap = "Skill swap"
    case crowdFunding = "Crowdfunding"
    case qa = "Q/A"
}

struct ChosenFormView: View{
    var selectedFormSide: FormCategories
    
    var body: some View{
        switch selectedFormSide {
        case .skillSwap:
            FormSkillSwap()
        case .crowdFunding:
            FormCrowdfunding()
        case .qa:
            FormQA()
        }
    }
}
