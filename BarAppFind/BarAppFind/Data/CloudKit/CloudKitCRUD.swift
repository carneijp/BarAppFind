//
//  CloudKitCRUD.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 03/05/23.
//
import CloudKit
import SwiftUI


class CloudKitCRUD: ObservableObject {
    
    @Published var barsList: [Bar] = []
    @Published var reviewListByBar: [Review] = []
    @Published var client: Clients?
    @Published var operationHours: OperationHours?
    @Published var chossenBar: Bar?
    
    
    
    private func saveItemPublic(record: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(record) { returnedRecors, returnedError in
            return
        }
    }
    private func addDataBaseOperation(operation: CKDatabaseOperation ) {
        CKContainer.default().publicCloudDatabase.add(operation)
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
                newBar["FakeID"] = bar.fakeID
                newBar["Longitude"] = bar.longitude
                
//                guard
//                    let image = UIImage(named: "maza"),
//                    let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("maza.jpeg"),
//                    let data = image.jpegData(compressionQuality: 1.0)
//                else { return }
//
//                do {
//                    try data.write(to: url)
//                    let asset = CKAsset(fileURL: url)
//                    newBar["image"] = asset
//                } catch error {
//                    print(error)
//                }
                             
                
                
                self?.saveItemPublic(record: newBar)
//                self?.addBarHours(operationHours: bar.operatinHours, bar: bar)
                
            }
        }
    }
    
    func addReview(review: Review) {
        let reference: String = "\(review.barName)_\(review.writerName)"
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
                newReview["Writer"] = review.writerName
                newReview["Bar"] = review.barName
                newReview["WriterNickName"] = review.writerNickName
                self?.saveItemPublic(record: newReview)
            }
        }
        
    }
    
    func addUser(clients: Clients) {
        let recordID = CKRecord.ID(recordName: clients.nickName)
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
                newClient["NickName"] = clients.nickName
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
    
    
    
    func fetchItemsReviewByBar(barName: String) {
//        let predicate = NSPredicate(value: true)
        let predicate = NSPredicate(format: "Bar = %@", argumentArray: ["\(barName)"])
        let query = CKQuery(recordType: "Reviews", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let queryOperation = CKQueryOperation(query: query)
//        queryOperation.resultsLimit = 2
        var returnedItem: [Review] = []
        
        if #available(iOS 15.0, *){
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult{
                case .success(let record):
                    guard let barName = record["Bar"] as? String else { return }
                    guard let writerName = record["Writer"] as? String else { return }
                    guard let description = record["Description"] as? String else { return }
                    guard let grade = record["Grade"] as? Double else { return }
                    guard let writerNickName = record["WriterNickName"] as? String else { return }
                    returnedItem.append(Review(writerNickName: writerNickName, writerName: writerName, grade: grade, description: description, barName: barName) )
                case .failure(let error):
                    print("Error matched block error\(error)")
                }
            }
        }
        else{
            queryOperation.recordFetchedBlock = {(returnedRecord)in
                guard let barName = returnedRecord["Bar"] as? String else { return }
                guard let writerName = returnedRecord["Writer"] as? String else { return }
                guard let description = returnedRecord["Description"] as? String else { return }
                guard let grade = returnedRecord["Grade"] as? Double else { return }
                guard let writerNickName = returnedRecord["WriterNickName"] as? String else { return }
                returnedItem.append(Review(writerNickName: writerNickName, writerName: writerName, grade: grade, description: description, barName: barName) )
            }
        }
        
        //COMPLETIONS BLOCKS
        
        if #available(iOS 15.0, *){
            queryOperation.queryResultBlock = { [weak self] returnedResult in
                DispatchQueue.main.async{
//                    print("returned result: \(returnedResult)")
//                    print(returnedItem)
                    self?.reviewListByBar = returnedItem
                }
            }
        }else{
            queryOperation.queryCompletionBlock = { [weak self] returnedCursor, returnedError in
//                print("returned result: \(returnedCursor)")
                self?.reviewListByBar = returnedItem
            }
        }
        addDataBaseOperation(operation: queryOperation)
        
    }
    
    func fetchItemsReviewByNickName(nickName: String) {
//        let predicate = NSPredicate(value: true)
        let predicate = NSPredicate(format: "WriterNickName = %@", argumentArray: ["\(nickName)"])
        let query = CKQuery(recordType: "Reviews", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let queryOperation = CKQueryOperation(query: query)
//        queryOperation.resultsLimit = 2
        var returnedItem: [Review] = []
        
        if #available(iOS 15.0, *){
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult{
                case .success(let record):
                    guard let barName = record["Bar"] as? String else { return }
                    guard let writerName = record["Writer"] as? String else { return }
                    guard let description = record["Description"] as? String else { return }
                    guard let grade = record["Grade"] as? Double else { return }
                    guard let writerNickName = record["WriterNickName"] as? String else { return }
                    returnedItem.append(Review(writerNickName: writerNickName, writerName: writerName, grade: grade, description: description, barName: barName) )
                case .failure(let error):
                    print("Error matched block error\(error)")
                }
            }
        }
        else{
            queryOperation.recordFetchedBlock = {(returnedRecord)in
                guard let barName = returnedRecord["Bar"] as? String else { return }
                guard let writerName = returnedRecord["Writer"] as? String else { return }
                guard let description = returnedRecord["Description"] as? String else { return }
                guard let grade = returnedRecord["Grade"] as? Double else { return }
                guard let writerNickName = returnedRecord["WriterNickName"] as? String else { return }
                returnedItem.append(Review(writerNickName: writerNickName, writerName: writerName, grade: grade, description: description, barName: barName) )
            }
        }
        
        //COMPLETIONS BLOCKS
        
        if #available(iOS 15.0, *){
            queryOperation.queryResultBlock = { [weak self] returnedResult in
                DispatchQueue.main.async{
//                    print("returned result: \(returnedResult)")
//                    print(returnedItem)
                    self?.reviewListByBar = returnedItem
                }
            }
        }else{
            queryOperation.queryCompletionBlock = { [weak self] returnedCursor, returnedError in
//                print("returned result: \(returnedCursor)")
                self?.reviewListByBar = returnedItem
            }
        }
        addDataBaseOperation(operation: queryOperation)
        
    }
    
    
    func validateClientLogin(nickName: String, password: String) {
        let recordID = CKRecord.ID(recordName: nickName)
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { [weak self] (fetchedRecord, error) in
            if(error == nil) {
                self?.fetchClientByNickName(nickName: nickName)
                if !(self?.client?.nickName == nickName && self?.client?.password == password) {
                    print("Usuario ou senha incorretas.")
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue:"notificationErrorCadastro"), object: nil)
                    self?.client = nil
                }
                
            }
            else if (fetchedRecord == nil) {
                print("Usuario ou senha incorretas.")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"notificationErrorCadastro"), object: nil)
            }
        }
    }
    
    
    private func fetchClientByNickName(nickName: String) {
        let predicate = NSPredicate(format: "Email = %@", argumentArray: ["\(nickName)"])
        let query = CKQuery(recordType: "Clients", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.resultsLimit = 1
        var returnedItem: Clients?
        
        if #available(iOS 15.0, *){
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult{
                case .success(let record):
                    guard let Email = record["Email"] as? String else { return }
                    guard let Phone = record["Phone"] as? String else { return }
                    guard let Name = record["Name"] as? String else { return }
                    guard let CPF = record["CPF"] as? String else { return }
                    guard let Gender = record["Gender"] as? String else { return }
                    guard let Password = record["Password"] as? String else { return }
                    guard let NickName = record["NickName"] as? String else { return }
                    returnedItem = Clients(email: Email, name: Name, phone: Phone, cpf: CPF, gender: Gender, password: Password, nickName: NickName)
                case .failure(let error):
                    print("Error matched block error\(error)")
                }
            }
        }
        else{
            queryOperation.recordFetchedBlock = {(returnedRecord)in
                guard let Email = returnedRecord["Email"] as? String else { return }
                guard let Phone = returnedRecord["Phone"] as? String else { return }
                guard let Name = returnedRecord["Name"] as? String else { return }
                guard let CPF = returnedRecord["CPF"] as? String else { return }
                guard let Gender = returnedRecord["Gender"] as? String else { return }
                guard let Password = returnedRecord["Password"] as? String else { return }
                guard let NickName = returnedRecord["NickName"] as? String else { return }
                returnedItem = Clients(email: Email, name: Name, phone: Phone, cpf: CPF, gender: Gender, password: Password, nickName: NickName)
            }
        }
        
        //COMPLETIONS BLOCKS
        
        if #available(iOS 15.0, *){
            queryOperation.queryResultBlock = { [weak self] returnedResult in
                DispatchQueue.main.async{
                    self?.client = returnedItem
                }
            }
        }else{
            queryOperation.queryCompletionBlock = { [weak self] returnedCursor, returnedError in
                self?.client = returnedItem
            }
        }
        addDataBaseOperation(operation: queryOperation)
        
    }
    
    
    func fetchoperationhours(barName: String) {
        let predicate = NSPredicate(format: "BarName = %@", argumentArray: ["\(barName)"])
        let query = CKQuery(recordType: "OperationHours", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        var returnedItem: OperationHours?
        
        if #available(iOS 15.0, *){
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult{
                case .success(let record):
                    guard let barName = record["BarName"] as? String else { return }
                    guard let Monday = record["Monday"] as? String else { return }
                    guard let Tuesday = record["Tuesday"] as? String else { return }
                    guard let Wednesday = record["Wednesday"] as? String else { return }
                    guard let Thrusday = record["Thrusday"] as? String else { return }
                    guard let Friday = record["Friday"] as? String else { return }
                    guard let Saturday = record["Saturday"] as? String else { return }
                    guard let Sunday = record["Sunday"] as? String else { return }
                    returnedItem = OperationHours(barName: barName, monday: Monday, tuesday: Tuesday, wednesday: Wednesday, thrusday: Thrusday, friday: Friday, saturday: Saturday, sunday: Sunday)
                case .failure(let error):
                    print("Error matched block error\(error)")
                }
            }
        }
        else{
            queryOperation.recordFetchedBlock = {(returnedRecord)in
                guard let barName = returnedRecord["BarName"] as? String else { return }
                guard let Monday = returnedRecord["Monday"] as? String else { return }
                guard let Tuesday = returnedRecord["Tuesday"] as? String else { return }
                guard let Wednesday = returnedRecord["Wednesday"] as? String else { return }
                guard let Thrusday = returnedRecord["Thrusday"] as? String else { return }
                guard let Friday = returnedRecord["Friday"] as? String else { return }
                guard let Saturday = returnedRecord["Saturday"] as? String else { return }
                guard let Sunday = returnedRecord["Sunday"] as? String else { return }
                returnedItem = OperationHours(barName: barName, monday: Monday, tuesday: Tuesday, wednesday: Wednesday, thrusday: Thrusday, friday: Friday, saturday: Saturday, sunday: Sunday)
            }
        }
        
        //COMPLETIONS BLOCKS
        
        if #available(iOS 15.0, *){
            queryOperation.queryResultBlock = { [weak self] returnedResult in
                DispatchQueue.main.async{
                    self?.operationHours = returnedItem
                }
            }
        }else{
            queryOperation.queryCompletionBlock = { [weak self] returnedCursor, returnedError in
                self?.operationHours = returnedItem
            }
        }
        addDataBaseOperation(operation: queryOperation)
        
    }
    
    
    func fetchBars() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Bars", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let queryOperation = CKQueryOperation(query: query)
//        queryOperation.resultsLimit = 2
        var returnedItem: [Bar] = []
        
        if #available(iOS 15.0, *){
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult{
                case .success(let record):
                    guard let barName = record["Name"] as? String else { return }
                    guard let mood = record["Mood"] as? String else { return }
                    guard let description = record["Description"] as? String else { return }
                    guard let expensive = record["Expensive"] as? String else { return }
                    guard let grade = record["Grade"] as? Double else { return }
                    guard let latitude = record["Latitude"] as? Double else { return }
                    guard let longitude = record["Longitude"] as? Double else { return }
                    guard let fakeID = record["FakeID"] as? String else { return }
                    returnedItem.append(Bar(name: barName, description: description, fakeID: fakeID, mood: [mood], expensive: expensive, grade: grade, latitude: latitude, longitude: longitude))
                case .failure(let error):
                    print("Error matched block error\(error)")
                }
            }
        }
        else{
            queryOperation.recordFetchedBlock = {(returnedRecord)in
                guard let barName = returnedRecord["Name"] as? String else { return }
                guard let mood = returnedRecord["Mood"] as? String else { return }
                guard let description = returnedRecord["Description"] as? String else { return }
                guard let expensive = returnedRecord["Expensive"] as? String else { return }
                guard let grade = returnedRecord["Grade"] as? Double else { return }
                guard let latitude = returnedRecord["Latitude"] as? Double else { return }
                guard let longitude = returnedRecord["Longitude"] as? Double else { return }
                guard let fakeID = returnedRecord["FakeID"] as? String else { return }
                returnedItem.append(Bar(name: barName, description: description, fakeID: fakeID, mood: [mood], expensive: expensive, grade: grade, latitude: latitude, longitude: longitude))
            }
        }
        
        //COMPLETIONS BLOCKS
        
        if #available(iOS 15.0, *){
            queryOperation.queryResultBlock = { [weak self] returnedResult in
                DispatchQueue.main.async{
//                    print("returned result: \(returnedResult)")
//                    print(returnedItem)
                    self?.barsList = returnedItem
                }
            }
        }else{
            queryOperation.queryCompletionBlock = { [weak self] returnedCursor, returnedError in
//                print("returned result: \(returnedCursor)")
                self?.barsList = returnedItem
            }
        }
        addDataBaseOperation(operation: queryOperation)
    }
    
    
    func fetchBars(barName: String) {
        let predicate = NSPredicate(format: "Name = %@", argumentArray: ["\(barName)"])
        let query = CKQuery(recordType: "Bars", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        var returnedItem: Bar?
        
        if #available(iOS 15.0, *){
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult{
                case .success(let record):
                    guard let barName = record["Name"] as? String else { return }
                    guard let mood = record["Mood"] as? String else { return }
                    guard let description = record["Description"] as? String else { return }
                    guard let expensive = record["Expensive"] as? String else { return }
                    guard let grade = record["Grade"] as? Double else { return }
                    guard let latitude = record["Latitude"] as? Double else { return }
                    guard let longitude = record["Longitude"] as? Double else { return }
                    guard let fakeID = record["FakeID"] as? String else { return }
                    returnedItem = Bar(name: barName, description: description, fakeID: fakeID, mood: [mood], expensive: expensive, grade: grade, latitude: latitude, longitude: longitude)
                case .failure(let error):
                    print("Error matched block error\(error)")
                }
            }
        }
        else{
            queryOperation.recordFetchedBlock = {(returnedRecord)in
                guard let barName = returnedRecord["Name"] as? String else { return }
                guard let mood = returnedRecord["Mood"] as? String else { return }
                guard let description = returnedRecord["Description"] as? String else { return }
                guard let expensive = returnedRecord["Expensive"] as? String else { return }
                guard let grade = returnedRecord["Grade"] as? Double else { return }
                guard let latitude = returnedRecord["Latitude"] as? Double else { return }
                guard let longitude = returnedRecord["Longitude"] as? Double else { return }
                guard let fakeID = returnedRecord["FakeID"] as? String else { return }
                returnedItem = Bar(name: barName, description: description, fakeID: fakeID, mood: [mood], expensive: expensive, grade: grade, latitude: latitude, longitude: longitude)
            }
        }
        
        //COMPLETIONS BLOCKS
        
        if #available(iOS 15.0, *){
            queryOperation.queryResultBlock = { [weak self] returnedResult in
                DispatchQueue.main.async{
                    self?.chossenBar = returnedItem
                }
            }
        }else{
            queryOperation.queryCompletionBlock = { [weak self] returnedCursor, returnedError in
                self?.chossenBar = returnedItem
            }
        }
        addDataBaseOperation(operation: queryOperation)
    }
    
    
}
