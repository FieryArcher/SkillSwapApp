//
//  QAView.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 03.03.2024.
//

import SwiftUI

struct QAView: View {
    @State var textFieldTxt: String = ""

//    var qaModels = QaModelController.questions
    @State private var questionsModel: [Post] = []
    
    var body: some View {
        VStack {
            SearchBar(searchTxt: $textFieldTxt)
                .padding(.horizontal)
            ScrollView(showsIndicators: false) {
                ForEach(questionsModel, id: \.id) {
                    element in
                    QACell(model: element)
                }
            }
            Spacer()
        }
        .onAppear{
            fetchPosts()
        }
    }
    
    //MARK: - Fetching date into array of elements
    func fetchPosts() {
        NetworkService.shared.fetchQuestions(endpoint: Endpoint.questions) { result in
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
    QAView()
}
