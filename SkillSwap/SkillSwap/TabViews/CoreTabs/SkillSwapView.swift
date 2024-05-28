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
//    var crowdfund = CrowdfundingModelController.crowdfunds
    @State var skillSwapArray: [SkillSwapModel] = []
    @State var crowdfundArray: [CrowdfundingModel] = []
//    var skillswap = SkillswapModelController.skillSwapModels
    
    var body: some View {
        VStack {
            SearchBar(searchTxt: $textFieldTxt)
                .padding(.horizontal)
            
            segmentControl
            if isFirstChosenSegment{
                crowdfunding
                    .onAppear{
                        fetchFunds()
                    }
            }
            else{
                skillswapView
                    .padding(.horizontal)
                    .padding(.bottom, 4)
                    .onAppear{
                        fetchPosts()
                    }
            }
            Spacer()
        }
    }
    
    func fetchPosts(){
        NetworkService.shared.fetchPosts(Endpoint.skillSwap) { result in
            switch result {
            case .success(let posts):
                skillSwapArray = posts.data
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func fetchFunds() {
        NetworkService.shared.fetchFunds(endpoint: Endpoint.crowdfund) { result in
            switch result {
            case .success(let data):
                crowdfundArray = data.data
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    var crowdfunding: some View{
        ScrollView(showsIndicators: false){
            ForEach(crowdfundArray, id: \.id) { model in
                CrowdfundCell(crowdfund: model)
            }
        }
    }
    
    var skillswapView: some View{
        
        ScrollView(showsIndicators: false){
            ForEach(skillSwapArray, id: \.id) { model in
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
