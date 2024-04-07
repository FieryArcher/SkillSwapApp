//
//  SkillSwapView.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 03.03.2024.
//

import SwiftUI

struct SkillSwapView: View {
    @State var textFieldTxt: String = ""
    
    @State var isFirstChosenSegment: Bool = true
    
    let dateFormatter = DateFormatter()
    var crowdfund = CrowdfundingModelController.crowdfunds
    var skillswap = SkillswapModelController.skillSwapModels
    
    var body: some View {
        VStack {
            SearchBar(searchTxt: $textFieldTxt)
                .padding(.horizontal)
            
//            TitleTextField(title: "Recomendation")
//                .padding(.vertical, 4)
            segmentControl
            if isFirstChosenSegment{
                crowdfunding
            }
            else{
                skillswapView
                    .padding(.horizontal)
                    .padding(.bottom, 4)
            }
            Spacer()
        }
    }
    
    
    var crowdfunding: some View{
        
        ScrollView(showsIndicators: false){
            ForEach(crowdfund, id: \.id) { model in
                CrowdfundCell(crowdfund: model)
            }
        }
        
    }
    
    var skillswapView: some View{
        
        ScrollView(showsIndicators: false){
            ForEach(skillswap, id: \.id) { model in
                SkillSwapCell(model: model)
            }
        }
        
    }
    
    
    
    var skillSwap: some View{
        VStack{
            
        }
    }
    
    var segmentControl: some View{
        HStack{
            VStack{
                HStack{
                    VStack{
                        Text("Skill Swap")
                            .frame(width: UIScreen.main.bounds.width/2, alignment: .center)
                    }
                    .onTapGesture {
                        isFirstChosenSegment.toggle()
                    }
                    
                    VStack{
                        Text("CrowdFunding")
                            .frame(width: UIScreen.main.bounds.width/2, alignment: .center)
                    }
                    .onTapGesture {
                        isFirstChosenSegment.toggle()
                    }
                }
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color("primaryColor"))
                
                HStack{
                    VStack{
                        if !isFirstChosenSegment{
                            Divider()
                                .frame(height: 2)
                                .overlay(Color("primaryColor"))
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width/2-16)
                    
                    Spacer()
                    VStack(alignment: .center){
                        if isFirstChosenSegment{
                            Divider()
                                .frame(height: 2)
                                .overlay(Color("primaryColor"))
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width/2-16)
                }
                .animation(.spring(duration: 0.25))
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

#Preview {
    SkillSwapView()
}
