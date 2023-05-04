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
    
    func addBarHours(operationHours: OperationHours, bar: Bar) {
        let reference = "\(bar.name)_\(bar.fakeID)"
        let recordID = CKRecord.ID(recordName: reference)
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { [weak self] (fetchedRecord, error) in
            if(error == nil) {
                print("Já existe usuário com este CPF.")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"notificationErrorCadastro"), object: nil)
                
            }
            else if (fetchedRecord == nil) {
                let newHours = CKRecord(recordType: "OperationHours")
                newHours["BarName"] = operationHours.barName
                newHours["Monday"] = operationHours.monday
                newHours["Tuesday"] = operationHours.tuesday
                newHours["Wednesday"] = operationHours.wednesday
                newHours["Thrusday"] = operationHours.thrusday
                newHours["Friday"] = operationHours.friday
                newHours["Saturday"] = operationHours.saturday
                newHours["Sunday"] = operationHours.sunday
                self?.saveItemPublic(record: newHours)
            }
        }
    }
    
    func addBar(bar: Bar) {
        let recordID = CKRecord.ID(recordName: bar.fakeID)
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { [weak self] (fetchedRecord, error) in
            if(error == nil) {
                print("Já existe usuário com este CPF.")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"notificationErrorCadastro"), object: nil)
                
            }
            else if (fetchedRecord == nil) {
                let newBar = CKRecord(recordType: "Bars")
                newBar["Name"] = bar.name
                newBar["Description"] = bar.description
                newBar["Mood"] = bar.mood
                newBar["Expensive"] = bar.expensive
                newBar["Grade"] = bar.grade
                newBar["Latitude"] = bar.latitude
                newBar["Longitude"] = bar.longitude
                self?.saveItemPublic(record: newBar)
                self?.addBarHours(operationHours: bar.operatinHours, bar: bar)
                
            }
        }
    }
    
    func addReview(review: Review) {
        let reference: String = "\(review.barName)_\(review.writerName.cpf)"
        let recordID = CKRecord.ID(recordName: reference)
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { [weak self] (fetchedRecord, error) in
            if(error == nil) {
                print("Já existe usuário com este CPF.")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"notificationErrorCadastro"), object: nil)
                
            }
            else if (fetchedRecord == nil) {
                let newReview = CKRecord(recordType: "Reviews")
                newReview["Grade"] = review.grade
                newReview["Description"] = review.description
                newReview["Writer"] = review.writerName.name
                newReview["Bar"] = review.barName.name
                self?.saveItemPublic(record: newReview)
            }
        }
        
    }
    
    func addUser(clients: Clients) {
        let recordID = CKRecord.ID(recordName: clients.cpf)
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { [weak self] (fetchedRecord, error) in
            if(error == nil) {
                print("Já existe usuário com este CPF.")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"notificationErrorCadastro"), object: nil)
                
            }
            else if (fetchedRecord == nil) {
                let newClient = CKRecord(recordType: "Clients")
                newClient["Email"] = clients.email
                newClient["Phone"] = clients.phone
                newClient["Name"] = clients.name
                newClient["CPF"] = clients.cpf
                newClient["Gender"] = clients.gender
                newClient["Password"] = clients.password
                self?.saveItemPublic(record: newClient)
            }
        }
        
    }
    
    func addCity(cidade: City) {
        let recordID = CKRecord.ID(recordName: cidade.name)
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { [weak self] (fetchedRecord, error) in
            if(error == nil) {
                print("Já existe usuário com este CPF.")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"notificationErrorCadastro"), object: nil)
                
            }
            else if (fetchedRecord == nil) {
                let newCity = CKRecord(recordType: "Citys")
                newCity["Name"] = cidade.name
                self?.saveItemPublic(record: newCity)
            }
        }
    }
    
    
    
    
    
    
    
    
}
