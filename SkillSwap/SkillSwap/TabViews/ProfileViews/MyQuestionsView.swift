//
//  MyQuestionsView.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 03.05.2024.
//

import SwiftUI

struct MyQuestionsView: View {
    @State private var questionsModel: [Post] = []

    var body: some View {
        questions
    }

    var questions: some View{
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(questionsModel, id: \.id) {
                    element in
                    QACell(model: element)
                }
            }
        }
        .onAppear{
            fetchPosts()
        }
    }
    
    func fetchPosts() {
        NetworkService.shared.fetchQuestions(endpoint: Endpoint.myQuestions) { result in
            switch result {
            case .success(let posts):
                questionsModel = posts.data
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
}

#Preview {
    MyQuestionsView()
}
