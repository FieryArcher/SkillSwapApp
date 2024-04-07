//
//  CrowdfundingModelController.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 04.04.2024.
//

import Foundation

struct CrowdfundingModelController {
    static var crowdfunds: [CrowdfundingModel] = [
        CrowdfundingModel(title: "Pet's adoption", photo: "photo", createdDate: Date(), earnedMoney: 1000, plannedMoney: 10000, content: "Harum cupiditate animi repudiandae quas. Cumque in vitae exercitationem necessitatibus. Eum id excepturi quae alias illum dolor distinctio. Facere quae iste repellat deserunt modi mollitia. Perferendis non neque aut consequatur reiciendis quia libero numquam.", category: .project),
        CrowdfundingModel(title: "Grammar checking app", photo: "photo", createdDate: Date(), earnedMoney: 1000, plannedMoney: 10000, content: "фундаментальная ошибка атрибуции – это склонность человека объяснять поступки и поведение других людей их личностными особенностями, а не внешними факторами и ситуацией.", category: .project),
        CrowdfundingModel(title: "Financial education", photo: "photo", createdDate: Date(), earnedMoney: 1000, plannedMoney: 10000, content: "Двадцать галлеонов весили около 100 граммов. А стоимость золота в Великобритании… 10 000 фунтов стерлингов за килограмм. Значит, в одном галлеоне 50 фунтов стерлингов. Высота кучи составляла 60 монет, длина и ширина основания – по 20 монет. Она была пирамидальной формы, значит, нужно взять треть от объёма соответствующего параллелепипеда. Грубо говоря, восемь тысяч галлеонов в куче. Всего было 5 горок золота такого же размера. Получается 40 000 галлеонов, или 2 миллиона фунтов стерлингов.", category: .project),
        CrowdfundingModel(title: "Badoo clone", photo: "photo", createdDate: Date(), earnedMoney: 1000, plannedMoney: 10000, content: "Another thing that I appreciate about David is his sense of humor. He always knows how to make me laugh, even on my worst days. His wit and clever jokes never fail to put a smile on my face. He also has a great sense of humor about himself, which I find particularly endearing.", category: .project),
        CrowdfundingModel(title: "Badoo clone", photo: "photo", createdDate: Date(), earnedMoney: 1000, plannedMoney: 10000, content: "Another thing that I appreciate about David is his sense of humor. He always knows how to make me laugh, even on my worst days. His wit and clever jokes never fail to put a smile on my face. He also has a great sense of humor about himself, which I find particularly endearing.", category: .project),
        CrowdfundingModel(title: "Badoo clone", photo: "photo", createdDate: Date(), earnedMoney: 1000, plannedMoney: 10000, content: "Another thing that I appreciate about David is his sense of humor. He always knows how to make me laugh, even on my worst days. His wit and clever jokes never fail to put a smile on my face. He also has a great sense of humor about himself, which I find particularly endearing.", category: .project),
        CrowdfundingModel(title: "Badoo clone", photo: "photo", createdDate: Date(), earnedMoney: 1000, plannedMoney: 10000, content: "Another thing that I appreciate about David is his sense of humor. He always knows how to make me laugh, even on my worst days. His wit and clever jokes never fail to put a smile on my face. He also has a great sense of humor about himself, which I find particularly endearing.", category: .project)
        
    ]
    
    
    public static func giveExample() -> [CrowdfundingModel] {
        let array = [
            CrowdfundingModel(title: "Pet's adoption", photo: "photo", createdDate: Date(), earnedMoney: 1000, plannedMoney: 10000, content: "Harum cupiditate animi repudiandae quas. Cumque in vitae exercitationem necessitatibus. Eum id excepturi quae alias illum dolor distinctio. Facere quae iste repellat deserunt modi mollitia. Perferendis non neque aut consequatur reiciendis quia libero numquam.", category: .project),
            CrowdfundingModel(title: "Grammar checking app", photo: "photo", createdDate: Date(), earnedMoney: 1000, plannedMoney: 10000, content: "фундаментальная ошибка атрибуции – это склонность человека объяснять поступки и поведение других людей их личностными особенностями, а не внешними факторами и ситуацией.", category: .project),
            CrowdfundingModel(title: "Financial education", photo: "photo", createdDate: Date(), earnedMoney: 1000, plannedMoney: 10000, content: "Двадцать галлеонов весили около 100 граммов. А стоимость золота в Великобритании… 10 000 фунтов стерлингов за килограмм. Значит, в одном галлеоне 50 фунтов стерлингов. Высота кучи составляла 60 монет, длина и ширина основания – по 20 монет. Она была пирамидальной формы, значит, нужно взять треть от объёма соответствующего параллелепипеда. Грубо говоря, восемь тысяч галлеонов в куче. Всего было 5 горок золота такого же размера. Получается 40 000 галлеонов, или 2 миллиона фунтов стерлингов.", category: .project),
            CrowdfundingModel(title: "Badoo clone", photo: "photo", createdDate: Date(), earnedMoney: 1000, plannedMoney: 10000, content: "Another thing that I appreciate about David is his sense of humor. He always knows how to make me laugh, even on my worst days. His wit and clever jokes never fail to put a smile on my face. He also has a great sense of humor about himself, which I find particularly endearing.", category: .project),
            
        ]
        
        return array
    }
}
