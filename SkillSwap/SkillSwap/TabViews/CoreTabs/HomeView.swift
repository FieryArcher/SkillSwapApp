//
//  HomeView.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 03.03.2024.
//

import SwiftUI

struct HomeView: View {
    @State var textFieldTxt: String = ""

    var body: some View {
        VStack{
            SearchBar(searchTxt: $textFieldTxt)
                .padding(.horizontal)
            Color.yellow
        }
    }
}

#Preview {
    HomeView()
}
