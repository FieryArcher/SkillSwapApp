//
//  MySkillsView.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 27.03.2024.
//

import SwiftUI

class TaskManager: ObservableObject {
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var showAlert = false
        
    func taskCompleted(status: Bool, message: String) {
        DispatchQueue.main.async {
            self.alertTitle = status ? "Success" : "Error"
            self.alertMessage = message
            self.showAlert = true
        }
    }
}

class DataStore: ObservableObject {
    @Published var skillSwapArray: [SkillSwapModel] = []
    @StateObject var taskManager = TaskManager()

    func removeItem(at index: Int) {
        deleteData(at: index)
        objectWillChange.send() // Уведомляем SwiftUI о предстоящем изменении данных
        fetchData() // Инициируем новый запрос после удаления элемента
    }
    
    func deleteData(at id: Int) {
        NetworkService.shared.deleteSkill(endpoint: .posts, id: id) { [self] result in
            switch result {
            case .success(let data):
                print("Before data changed ---- \(taskManager.showAlert)")
                taskManager.taskCompleted(status: data.success, message: data.message)
                taskManager.objectWillChange.send() // Принудительное обновление
                print("OUR DATA FROM DELETED ACTION: - \(data)")
                print("Is data changed? ---- \(taskManager.showAlert)")
            case .failure(let error):
                taskManager.taskCompleted(status: false, message: "Server is not answering, please try again later")
                print("Something went wrong on fetching error on DELETE button: \(error)")
            }
            
        }
    }

    func fetchData() {
        // Реализуйте запрос к серверу для получения обновленных данных
        NetworkService.shared.fetchPosts(Endpoint.myPosts) { [self] result in
            switch result {
            case .success(let posts):
                skillSwapArray = posts.data
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}


struct MySkillsView: View {
    
    @ObservedObject var dataStore = DataStore()
    
//    @State var skillSwapArray: [SkillSwapModel] = []
    
    @StateObject var taskManager = TaskManager()
    
    var body: some View {
        VStack {
            skillswapView
                .navigationBarTitleDisplayMode(.inline)
                .alert(isPresented: $taskManager.showAlert) {
                    Alert(title: Text(taskManager.alertTitle), message: Text(taskManager.alertMessage), dismissButton: .default(Text("OK")))
                }
        }
        .onAppear{
            dataStore.fetchData()
        }
        
    }
    
    var skillswapView: some View{
        ScrollView(showsIndicators: false){
            ForEach(dataStore.skillSwapArray, id: \.id) { model in
                SkillSwapCell(model: model, isProfileCell: true)
            }
        }
    }
    
//    func fetchPosts(){
//        NetworkService.shared.fetchPosts(Endpoint.myPosts) { result in
//            switch result {
//            case .success(let posts):
//                skillSwapArray = posts.data
//            case .failure(let error):
//                print(String(describing: error))
//            }
//        }
//    }
    
}



#Preview {
    MySkillsView()
}
