//
//  SkillSwapCell.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 06.04.2024.
//
// MARK: Content of the Skill Swap
// Title -> Content -> Photo -> Price -> Category (Flexible)

import SwiftUI

struct SkillSwapCell: View {
    
    @StateObject var taskManager = TaskManager()
    
    var model: SkillSwapModel
    var isProfileCell: Bool = false
    
    @State var saved: Bool = false
    
    
    @ObservedObject var dataStore = DataStore()

    
    var body: some View {
        main
    }
    
    var main: some View{
        VStack(alignment: .leading, spacing: 4){
            HStack{
                texts
                Spacer()
                VStack{
                    Image(systemName: saved ? "star.fill" : "star")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(saved ? .yellow : Color("primaryColor"))
                        .onTapGesture {
                            saved.toggle()
                        }
                    Spacer()
                }
            }
            .frame(height: 95)
            
            
            Text(model.categories.first?.name ?? "mandarin")
                .foregroundColor(.white)
                .font(.system(size: 13, weight: .medium))
                .padding(8)
                .background{
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.green)
                }
            
            AsyncImage(url: URL(string: "\(model.photo)")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
            } placeholder: {
                // Placeholder view while loading
                ProgressView()
            }
            
//            Image("nature")
            
            HStack{
                if isProfileCell{
                    // MARK: - Action for delete
                    Button(action: {
                        dataStore.removeItem(at: model.id)
//                        NetworkService.shared.deleteSkill(endpoint: .posts, id: model.id) { result in
//                            switch result {
//                            case .success(let data):
//                                print("Before data changed ---- \(taskManager.showAlert)")
//                                taskManager.taskCompleted(status: data.success, message: data.message)
//                                taskManager.objectWillChange.send() // Принудительное обновление
//                                print("OUR DATA FROM DELETED ACTION: - \(data)")
//                                print("Is data changed? ---- \(taskManager.showAlert)")
//                            case .failure(let error):
//                                taskManager.taskCompleted(status: false, message: "Server is not answering, please try again later")
//                                print("Something went wrong on fetching error on DELETE button: \(error)")
//                            }
//                            
//                        }
                        print("delete tapped")
                    }, label: {
                        Text("Delete")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .frame(height: 33)
                            .font(.system(size: 12, weight: .bold))
                    })
                    .frame(maxWidth: .infinity)
                    .frame(height: 33)
                    .background{
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(Color("buttonBG"))
                    }
                }
                Button(action: {
                    print("edit tapped")
                }, label: {
                    Text(isProfileCell ? "Edit" : "Respond")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 33)
                        .font(.system(size: 12, weight: .bold))
                })
                .frame(maxWidth: .infinity)
                .frame(height: 33)
                .background{
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(Color("primaryColor"))
                }
            }
            
//            .padding(.vertical, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color("announceBG"))
        }
    }
    
    var texts: some View{
        VStack(alignment: .leading, spacing: 4){
            Text("Title: \(model.title)")
                .font(.system(size: 13, weight: .semibold))
            Text("Price: \(model.price) ₸")
                .font(.system(size: 14, weight: .bold))
                .padding(4)
            Text("\(model.content)")
                .font(.system(size: 12, weight: .regular))
        }
    }
}

#Preview {
    SkillSwapCell(model: SkillSwapModel(id: 1,title: "Egological problems",
                                        content: "Right now we are facing with natural disasters all over the world as a earthquakes, deluge and curruption", 
                                        photo: "",
                                        price: "10", 
                                        categories: [SkillSwapModel.Category(name: "name", pivot: SkillSwapModel.Pivot(postId: 1, categoryId: 1))])
    , isProfileCell: true)
}
