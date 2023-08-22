//
//  CloudKitService.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 21/07/23.
//

import Foundation
import SwiftUI
import CloudKit
import UIKit
import Combine

protocol CloudKitableProtocol {
    init?(record: CKRecord)
    var record: CKRecord { get }
}

enum CloudKitTables: String {
    case Clients
    case Bars
    case ReportReview
    case Reports
    case Reviews
}

class CloudKitService {
    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
        case iCloudApplicationPermissionNotGranted
        case iCloudCouldNotFetchUserRecordID
        case iCloudCouldNotDiscoverUser
    }
    
    
    
}


// MARK: User functions:
extension CloudKitService {
    static func getiCloudStatus(completion: @escaping (Result<Bool, Error>) -> Void) {
        CKContainer.default().accountStatus { returnedStatus, error in
            switch returnedStatus {
            case .available:
                completion(.success(true))
            case .noAccount:
                completion(.failure(CloudKitError.iCloudAccountNotFound))
            case .restricted:
                completion(.failure(CloudKitError.iCloudAccountRestricted))
            case .couldNotDetermine:
                completion(.failure(CloudKitError.iCloudAccountNotDetermined))
            default:
                completion(.failure(CloudKitError.iCloudAccountUnknown))
            }
        }
    }
    
    //    static func getiCloudStatus() -> Future<Bool, Error> {
    //        Future { promisse in
    //            CloudKitService.getiCloudStatus { result in
    //                promisse(result)
    //            }
    //        }
    //    }
    
    static func requestApplicationPermission(completion: @escaping (Result<Bool, Error>) -> Void) {
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { returnedStatus, error in
            if returnedStatus == .granted {
                completion(.success(true))
            }else {
                completion(.failure(CloudKitError.iCloudApplicationPermissionNotGranted))
            }
        }
    }
    
    //    static func requestApplicationPermission() -> Future <Bool, Error> {
    //        Future { promisse in
    //            CloudKitService.requestApplicationPermission { result in
    //                promisse(result)
    //            }
    //        }
    //    }
    
    static func fetchUserRecordID(completion: @escaping (Result<CKRecord.ID, Error>) -> Void) {
        CKContainer.default().fetchUserRecordID { userRecordID, returnedError in
            if let id = userRecordID {
                completion(.success(id))
            }else if let error = returnedError {
                completion(.failure(error))
            }else {
                completion(.failure(CloudKitError.iCloudCouldNotFetchUserRecordID))
            }
        }
    }
    
    static private func discoverUserIdentity(userID: CKRecord.ID, completion: @escaping (Result<[String], Error>) -> Void) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: userID) { returnedIdentity, returnedError in
            if let name = returnedIdentity?.nameComponents?.givenName {
                if let surName = returnedIdentity?.nameComponents?.familyName{
                    completion(.success([name, surName]))
                }
                completion(.success([name]))
            } else if let error = returnedError {
                completion(.failure(error))
            }else {
                completion(.failure(CloudKitError.iCloudCouldNotDiscoverUser))
            }
        }
    }
    
    static func discoverUserIdentity(completion: @escaping (Result<[String], Error>) -> Void) {
        fetchUserRecordID { fetchCompletion in
            switch fetchCompletion {
            case .success(let id):
                CloudKitService.discoverUserIdentity(userID: id, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //    static func discoverUserIdentity() -> Future<String, Error> {
    //        Future { promise in
    //            CloudKitService.discoverUserIdentity { result in
    //                promise(result)
    //            }
    //        }
    //    }
}

// MARK: CRUD functions:
extension CloudKitService {
    // MARK: Inicio de fetch
    static private func addOperation(isPrivate: Bool, operation: CKDatabaseOperation) {
        if isPrivate {
            CKContainer.default().privateCloudDatabase.add(operation)
        }else {
            CKContainer.default().publicCloudDatabase.add(operation)
        }
    }
    
    static private func createOperation(
        predicate: NSPredicate,
        recordType: CKRecord.RecordType,
        sortDescriptor:  [NSSortDescriptor]? = nil,
        resultLimiter: Int? = nil) -> CKQueryOperation {
            
            let query = CKQuery(recordType: recordType, predicate: predicate)
            if let sorter = sortDescriptor {
                query.sortDescriptors = sorter
            }
            let queryOperation = CKQueryOperation(query: query)
            if let limit = resultLimiter {
                queryOperation.resultsLimit = limit
            }
            return queryOperation
        }
    
    static private func addRecordMatchedBlock<T:CloudKitableProtocol>(queryOperation: CKQueryOperation, completion: @escaping (_ item: T) -> Void) {
        queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
            switch returnedResult {
            case .success(let record):
                guard let item = T(record: record) else { return }
                completion(item)
            case .failure(_): // error
                print("Error ao realizar Matched Block")
                break
            }
        }
    }
    
    static private func addQueryResultBlock(queryOperation: CKQueryOperation, completion: @escaping (_ finished: Bool) -> Void) {
        queryOperation.queryResultBlock = { returnedResult in
            completion(true)
        }
    }
    
    static func fetch<T:CloudKitableProtocol>(isPrivate: Bool, predicate: NSPredicate, recordType: CKRecord.RecordType, sortDescriptor:  [NSSortDescriptor]? = nil, resultLimiter: Int? = nil,
                                              completion: @escaping (_ items:[T]) -> Void) {
        
        let operation = createOperation(predicate: predicate, recordType: recordType, sortDescriptor: sortDescriptor, resultLimiter: resultLimiter)
        
        var returnedItems: [T] = []
        addRecordMatchedBlock(queryOperation: operation) { item in
            returnedItems.append(item)
        }
        addQueryResultBlock(queryOperation: operation) { finished in
            completion(returnedItems)
        }
        
        addOperation(isPrivate: isPrivate, operation: operation)
    }
    //
    //    static private func fetch<T:CloudKitableProtocol>(
    //        predicate: NSPredicate,
    //        recordType: CKRecord.RecordType,
    //        sortDescriptor:  [NSSortDescriptor]? = nil,
    //        resultLimiter: Int? = nil) -> Future<[T], Error>{
    //            Future { promise in
    //                fetch(predicate: predicate, recordType: recordType, sortDescriptor: sortDescriptor, resultLimiter: resultLimiter) { (items: [T]) in
    //                    promise(.success(items))
    //                }
    //            }
    //        }
    // MARK: Fim de fetch
    
    // MARK: Inicio de addItem
    static private func saveItem(isPrivate: Bool,record: CKRecord, completion: @escaping (Result<Bool, Error>) -> Void) {
        if isPrivate {
            CKContainer.default().privateCloudDatabase.save(record) { returnedRecord, returnedError in
                if let error = returnedError {
                    completion(.failure(error))
                }else {
                    completion(.success(true))
                }
            }
        }else{
            CKContainer.default().publicCloudDatabase.save(record) { returnedRecord, returnedError in
                if let error = returnedError {
                    completion(.failure(error))
                }else {
                    completion(.success(true))
                }
            }
        }
    }
    
    static func addItem<T:CloudKitableProtocol>(isPrivate: Bool,item: T, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        let record = item.record
        saveItem(isPrivate: isPrivate, record: record) { result in
            //            print(result)
            completion(result)
        }
    }
    
    // MARK: Fim de addItem
    
    // MARK: Inicio de Update:
    static func updateItem<T:CloudKitableProtocol>(isPrivate: Bool, item: T, completion: @escaping (Result<Bool, Error>) -> Void) {
        addItem(isPrivate: isPrivate, item: item, completion: completion)
    }
    // MARK: Fim de updateItem
    
    // MARK: Inicio de deletItem
    
    static private func deleteItem(isPrivate: Bool, record: CKRecord, completion: @escaping (Result<Bool, Error>) -> Void) {
        if isPrivate {
            CKContainer.default().privateCloudDatabase.delete(withRecordID: record.recordID) { returnedRecordID, returnedError in
                if let error = returnedError {
                    completion(.failure(error))
                }else {
                    completion(.success(true))
                }
            }
        }else {
            CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID) { returnedRecordID, returnedError in
                if let error = returnedError {
                    completion(.failure(error))
                }else {
                    completion(.success(true))
                }
            }
        }
    }
    
    static func deleteItem<T: CloudKitableProtocol>(isPrivate: Bool, item: T, completion: @escaping (Result<Bool, Error>) -> Void) {
        CloudKitService.deleteItem(isPrivate: isPrivate, record: item.record, completion: completion)
    }
    
    //    static func deleteItem<T: CloudKitableProtocol>(item: T) -> Future<Bool, Error> {
    //        Future { promise in
    //            CloudKitService.deleteItem(item: item) { result in
    //                promise(result)
    //            }
    //        }
    //    }
    
    // MARK: Fim de deleteItem
}


enum SubscriptionsIDs: String {
    case InviteRecived
    case InviteAnswered
    case autoUpdateTasks
    case userUpdate
    case houseUpdate
    case emailUpdate
    case rewardUpdate
}


// MARK: PushNotifications:
extension CloudKitService {
    static func requestNotificationPermission(completion: @escaping (Result<Bool, Error>) -> Void) {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let erro = error {
                print(erro)
                completion(.failure(erro))
            }else if success {
                //                print("autorizado")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                    completion(.success(success))
                }
            }else {
                //                print("não autorizado")
                completion(.success(success))
            }
        }
        
    }
    
    static func subscribeForNotification(recordType: CKRecord.RecordType, predicate: NSPredicate, subscriptionID: CKSubscription.ID, options: CKQuerySubscription.Options, notificationTitle: String, notificationText: String) {
        let subscription = CKQuerySubscription(recordType: recordType, predicate: predicate, subscriptionID: subscriptionID, options: options)
        
        let notification = CKSubscription.NotificationInfo()
        notification.title = notificationTitle
        notification.alertBody = notificationText
        notification.soundName = "default"
        subscription.notificationInfo = notification
        
        CKContainer.default().publicCloudDatabase.save(subscription) { returnedSubscription, returnedError in
            if let error = returnedError {
                print(error)
            }else {
                print("Subscribed for notification\(notificationTitle)")
            }
        }
    }
    
    
    static func unsubscribeForNotification(subscriptionID: CKSubscription.ID) {
        CKContainer.default().publicCloudDatabase.delete(withSubscriptionID: subscriptionID) { returnedString, returnedError in
            if let error = returnedError {
                print(error)
            }else {
                print("unsubscribed\(subscriptionID)")
            }
        }
    }
    
    
    static func subscribeForRemoteUpdate(predicate: NSPredicate, table: CloudKitTables, subscriptionID: String) {
        let subscription = CKQuerySubscription(recordType: table.rawValue, predicate: predicate, subscriptionID: subscriptionID, options: [.firesOnRecordCreation, .firesOnRecordUpdate, .firesOnRecordDeletion] )
        let notificationInfo = CKSubscription.NotificationInfo()
        notificationInfo.shouldSendContentAvailable = true
        subscription.notificationInfo = notificationInfo
        CKContainer.default().publicCloudDatabase.save(subscription) { subscription, error in
            if let error = error {
                print("Error creating subscription: \(error)")
            } else {
                print("Subscription created successfully")
            }
        }
    }
    
}
