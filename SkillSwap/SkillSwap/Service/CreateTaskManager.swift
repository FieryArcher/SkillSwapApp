//
//  TaskManager.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 07.05.2024.
//

import Foundation

class CreateTaskManager: ObservableObject {
    @Published var showLoad = false
    @Published var response: Response?
    @Published var alertStatus = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func toogleShowLoad() {
        DispatchQueue.main.async {
            self.showLoad = true
        }
    }
    
    func showAlertForResponse(_ response: Response) {
        alertMessage = response.message
        
        // Показываем алерт
        DispatchQueue.main.async {
            self.showLoad = false
            self.showAlert = true
            self.alertStatus = response.success
            self.alertMessage = response.success ? "Question successfully created" :
                                                    "Unfortunaly question was not created"
        }
        
        // Через 2 секунды скрываем алерт
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showAlert = false
        }
    }
        
}
