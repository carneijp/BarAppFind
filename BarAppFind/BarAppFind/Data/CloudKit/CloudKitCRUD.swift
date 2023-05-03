//
//  CloudKitCRUD.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 03/05/23.
//
import CloudKit
import SwiftUI


class CloudKitCRUD: ObservableObject {
//    @Published var bars: []
    
    private func saveItemPublic(record: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(record) { returnedRecors, returnedError in
            return
        }
    }
    
    private func addBarHours(operationHours: OperationHours) {
        let newHours = CKRecord(recordType: "OperationHours")
        newHours["BarName"] = operationHours.barName.name
        newHours["Monday"] = operationHours.monday
        newHours["Tuesday"] = operationHours.tuesday
        newHours["Wednesday"] = operationHours.wednesday
        newHours["Thrusday"] = operationHours.thrusday
        newHours["Friday"] = operationHours.friday
        newHours["Saturday"] = operationHours.saturday
        newHours["Sunday"] = operationHours.sunday
        saveItemPublic(record: newHours)
    }
    
    private func addBar(bar: Bar) {
        let newBar = CKRecord(recordType: "Bars")
        newBar["Name"] = bar.name
        newBar["Description"] = bar.description
        newBar["Mood"] = bar.mood
        newBar["Expensive"] = bar.expensive
        newBar["Grade"] = bar.grade
        newBar["Latitude"] = bar.latitude
        newBar["Longitude"] = bar.longitude
        saveItemPublic(record: newBar)
        addBarHours(operationHours: bar.operatinHours)
    }
    
    private func addReview(review: Review) {
        let newReview = CKRecord(recordType: "Reviews")
        newReview["Grade"] = review.grade
        newReview["Description"] = review.description
        newReview["Writer"] = review.writerName.name
        newReview["Bar"] = review.barName.name
        saveItemPublic(record: newReview)
    }
    
    private func addUser(clients: Clients) {
        let newClient = CKRecord(recordType: "Clients")
        newClient["Email"] = clients.email
        newClient["Phone"] = clients.phone
        newClient["Name"] = clients.name
        newClient["CPF"] = clients.cpf
        newClient["Gender"] = clients.gender
        newClient["Password"] = clients.password
        saveItemPublic(record: newClient)
    }
    
    private func addCity(cidade: City) {
        let newCity = CKRecord(recordType: "Citys")
        newCity["Name"] = cidade.name
        saveItemPublic(record: newCity)
    }
    
    
    
    
    
    
    
    
    
}
