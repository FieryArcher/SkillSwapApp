//
//  TestAlert.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 26.04.2024.
//

import SwiftUI

struct CustomAlert: View {
    var isSuccess: Bool
    var message: String
    
    var body: some View {
        VStack {
            Spacer()
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(width: 300, height: 180)
                .shadow(radius: 2)
                .overlay(
                    VStack {
                        if isSuccess {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(.green)
                                .padding(.bottom, 20)
                        } else {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(.red)
                                .padding(.bottom, 20)
                        }
                        Text(isSuccess ? "Successfully!" : "Failed")
                            .fontWeight(.semibold)
                        
                        Text(message)
                            .foregroundColor(.black)
                            .fontWeight(.regular)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                )
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.black.opacity(0.1).ignoresSafeArea())
    }
}

struct LoadingView: View {
    
    @State var animate: Bool = false
    
    var body: some View {
        VStack{
            Circle()
                .stroke(AngularGradient.init(gradient: .init(colors: [Color.primary, Color.primary.opacity(0)]), center: .center))
                .frame(width: 80, height: 80)
                .rotationEffect(.init(degrees: animate ? 360 : 0))
            
            Text("Loading...")
                .fontWeight(.bold)
        }
        .padding(.vertical, 25)
        .padding(.horizontal, 30)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(radius: 2)
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                animate.toggle()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.black.opacity(0.1).ignoresSafeArea())
    }
}

struct TestAlert: View {
    @State var isLoadShow: Bool = true
    var body: some View {
        if isLoadShow{
            LoadingView()
        }
        CustomAlert(isSuccess: false, message: "Make your day smile")
        
        
    }
}



#Preview {
    TestAlert()
}
