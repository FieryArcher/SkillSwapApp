//
//  MyProjectsView.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 29.04.2024.
//

import SwiftUI

struct MyProjectsView: View {
    
    @State var crowdfundArray: [CrowdfundingModel] = []
    
    var body: some View {
        crowdfunding
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                fetchFunds()
            }
    }
    
    func fetchFunds() {
        NetworkService.shared.fetchFunds(endpoint: Endpoint.myCrowdfunds) { result in
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
}

#Preview {
    MyProjectsView()
}
