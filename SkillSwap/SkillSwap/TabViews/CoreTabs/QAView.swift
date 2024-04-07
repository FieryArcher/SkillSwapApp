//
//  QAView.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 03.03.2024.
//

import SwiftUI

struct QAView: View {
    @State var textFieldTxt: String = ""

    var qaModels = QaModelController.questions
    
    var body: some View {
        VStack {
            Text("Q/A")
                .font(.system(size: 18, weight: .bold))
            SearchBar(searchTxt: $textFieldTxt)
                .padding(.horizontal)
            ScrollView(showsIndicators: false) {
                ForEach(qaModels) {
                    element in
                    QACell(model: element)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    QAView()
}
