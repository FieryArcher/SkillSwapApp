//
//  CustomDatePicker.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 22.03.2024.
//

import SwiftUI


struct CustomDatePicker: View {
    @Binding var selectedDate: Date
    let title: String
    let systemImage: String // Иконка для отображения рядом с полем даты
    @State private var isPresentingDatePicker = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Button(action: {
                    isPresentingDatePicker.toggle()
                }) {
                    Image(systemName: systemImage)
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(Color("primaryColor"))
                }
                Text(title)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color("primaryColor"))
                Spacer()
            }
            .padding(.horizontal)
            .frame(height: 38)
            .background(){
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color("announceBG"))
            }
            
            if isPresentingDatePicker {
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                    .foregroundColor(.primary)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    CustomDatePicker(selectedDate: .constant(Date()), title: "Today's date", systemImage: "calendar")
}
