//
//  HomeView.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 03.03.2024.
//

import SwiftUI

struct HomeView: View {
    @State var textFieldTxt: String = ""

    
    @State private var skillSwapArray: [PostsMain] = []
    @State private var crowdfundArray: [CrowdfundingModel] = []
    @State private var questionsArray: [Post] = []

    var body: some View {
        VStack {
            SearchBar(searchTxt: $textFieldTxt)
                .padding(.horizontal)
            ScrollView {
                if skillSwapArray.isEmpty, crowdfundArray.isEmpty, questionsArray.isEmpty {
                    LoadingView()
                }
                else {
                    main
                }
            }
        }
        .onAppear{
            fetchFunds()
            fetchQuestions()
            fetchPosts()
        }
    }
    
    var main: some View {
        VStack{
            HStack {
                Text("Skill swap")
                    .font(.system(size: 18, weight: .semibold))
                    .padding()
                Spacer()
            }
            posts
            
            HStack {
                Text("Crowdfunding")
                    .font(.system(size: 18, weight: .semibold))
                    .padding()
                Spacer()
            }
            crowdfunding
            
            HStack {
                Text("Q/A")
                    .font(.system(size: 24, weight: .bold))
                    .padding()
                Spacer()
            }
            questions
        }
    }
    
    var posts: some View {
        ScrollView(showsIndicators: false){
            ForEach(skillSwapArray, id: \.id) { model in
                PostsMainCell(model: model)
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
    
    var questions: some View {
        ScrollView(showsIndicators: false) {
            ForEach(questionsArray, id: \.id) {
                element in
                QACell(model: element)
            }
        }
    }
    
    func fetchFunds() {
        NetworkService.shared.fetchFunds(endpoint: Endpoint.funds) { result in
            switch result {
            case .success(let data):
                crowdfundArray = data.data
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func fetchPosts(){
        NetworkService.shared.fetchPostsMain(Endpoint.posts) { result in
            switch result {
            case .success(let posts):
                skillSwapArray = posts.data
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func fetchQuestions() {
        NetworkService.shared.fetchQuestions(endpoint: Endpoint.questionMain) { result in
            switch result {
            case .success(let posts):
                questionsArray = posts.data
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
}

#Preview {
    HomeView()
}
