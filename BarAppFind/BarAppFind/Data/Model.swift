//
//  Model.swift
//  Onde
//
//  Created by Joao Paulo Carneiro on 21/08/23.
//

import Foundation


class Model: ObservableObject {
    @Published var requestFinished: Bool = false
    @Published var client: Clients?
    @Published var barsList: [Bar] = []
    @Published var reviewListByBar: [Review] = []
    @Published var userRecordID: String = ""
    
    
    init() {
        CloudKitService.fetchUserRecordID { result in
            switch result {
            case .success(let id):
                DispatchQueue.main.async {
                    self.userRecordID = id.recordName
                    self.fetchUserInit {
                        print("Terminei de entrar com o usuario")
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


// MARK: Funcoes para Cliente
extension Model {
    private func fetchUserInit(completion: @escaping () -> Void) {
        self.requestFinished = false
        let predicado: NSPredicate = NSPredicate(format: "UserID = %@", argumentArray: [self.userRecordID])
        CloudKitService.fetch(isPrivate: false, predicate: predicado, recordType: CloudKitTables.Clients.rawValue, resultLimiter:  1) { [weak self] (items: [Clients]) in
            print(items.count)
            if items.count > 0 {
                DispatchQueue.main.async {
                    self?.client = items[0]
                    self?.requestFinished = true
                    completion()
                }
            }else {
                let predicate = NSPredicate(format: "UserID = %@", argumentArray: [self?.userRecordID ?? ""])
                CloudKitService.fetch(isPrivate: false, predicate: predicate, recordType: CloudKitTables.Clients.rawValue) { (items: [Clients]) in
                    if items.count == 0 {
                        DispatchQueue.main.async {
                            if self?.client == nil {
                                self?.addUser()
                                print("crei novo usuario")
                                completion()
                            }
                        }
                    }else {
                        self?.client = items[0]
                    }
                }
            }
        }
    }
    
    private func addUser() {
        var nickName = ""
        var surName = ""
        CloudKitService.discoverUserIdentity { result in
            switch result {
            case .success(let retorno):
                nickName = retorno[0]
                if retorno.count > 1 {
                    surName = retorno[1]
                }
            case .failure(let error):
                print(error)
                nickName = "Cliente"
            }
            let user = Clients(firstName: nickName, lastName: surName, userID: self.userRecordID, level: 1)
            if let newUser = user {
                CloudKitService.addItem(isPrivate: false, item: newUser) { result in
                    switch result{
                    case .success(let bool):
                        if bool {
                            DispatchQueue.main.async {
                                self.client = newUser
                                self.requestFinished = true
                            }
                        }
                    case .failure(let error):
                        print(error)
                        self.requestFinished = true
                    }
                }
            }
        }
    }
    
    func updateUser(updatedUser: Clients, completion: @escaping (Result<Bool, Error>) -> Void) {
        CloudKitService.updateItem(isPrivate: false, item: updatedUser){ [weak self] result in
            switch result {
            case .success(let bool):
                if bool {
                    DispatchQueue.main.async {
                        self?.client = updatedUser
                        completion(.success(bool))
                    }
                }else{
                    completion(.success(false))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

// MARK: Funcoes para bar
extension Model {
    func fetchBars(limit: Int? = nil,completion: @escaping () -> Void) {
        let predicate = NSPredicate(value: true)
        CloudKitService.fetch(isPrivate: false, predicate: predicate, recordType: CloudKitTables.Bars.rawValue, resultLimiter: limit) {[weak self] (items: [Bar]) in
            if items.count > 0 {
                DispatchQueue.main.async {
                    self?.barsList = items
                    completion()
                }
            }
        }
    }
    
    func updateBar(updatedBar: Bar, completion: @escaping () -> Void) {
        CloudKitService.updateItem(isPrivate: false, item: updatedBar) { [weak self] result in
            switch result {
            case .success(let bool):
                if bool {
                    DispatchQueue.main.async {
                        if let index = self?.barsList.firstIndex(where: {$0.name == updatedBar.name}){
                            self?.barsList.remove(at: index)
                            self?.barsList.insert(updatedBar, at: index)
                        }
                        completion()
                    }
                }
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }
    
    func refreshBars(completion: @escaping () -> Void) {
        fetchBars(completion: completion)
    }
}

// MARK: Funcoes para review
extension Model {
    func fetchReviews(barName: String, completion: @escaping () -> Void) {
        let predicate = NSPredicate(format: "Bar = %@", argumentArray: [barName])
        CloudKitService.fetch(isPrivate: false, predicate: predicate, recordType: CloudKitTables.Reviews.rawValue) {[weak self] (items: [Review]) in
            if items.count > 0 {
                self?.reviewListByBar = items
            }
        }
    }
    
    func addReview(review: Review, completion: @escaping () -> Void) {
        let predicate = NSPredicate(format: "WriterID = %@", argumentArray: [client?.userID ?? ""])
        CloudKitService.fetch(isPrivate: false, predicate: predicate, recordType: CloudKitTables.Reviews.rawValue) { (items: [Review]) in
            if items.count == 0{
                CloudKitService.addItem(isPrivate: false, item: review) {[weak self] result in
                    switch result {
                    case .success(let bool):
                        DispatchQueue.main.async {
                            self?.reviewListByBar.append(review)
                            completion()
                        }
                        print(bool)
                    case .failure(let error):
                        completion()
                        print(error)
                    }
                }
            }else {
                completion()
            }
        }
        
    }
    
    func updateReview(updatedReview: Review, completion: @escaping () -> Void) {
        CloudKitService.updateItem(isPrivate: false, item: updatedReview) {[weak self] result in
            switch result {
            case .success(let bool):
                if bool {
                    DispatchQueue.main.async {
                        if let index = self?.reviewListByBar.firstIndex(where: {$0.writerId == updatedReview.writerId}){
                            self?.reviewListByBar.remove(at: index)
                            self?.reviewListByBar.insert(updatedReview, at: index)
                        }
                        completion()
                    }
                }
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }
    
    func deleteReview(review: Review, completion: @escaping () -> Void) {
        CloudKitService.deleteItem(isPrivate: false, item: review) { [weak self] result in
            switch result {
            case .success(let bool):
                if let index = self?.reviewListByBar.firstIndex(where: {$0.writerName == review.writerName}) {
                    self?.reviewListByBar.remove(at: index)
                }
                completion()
                print(bool)
            case .failure(let error):
                completion()
                print(error)
            }
        }
    }
}

// MARK: Funcoes para reviewReport
extension Model {
    func addReviewReport(reviewReport: ReportReview, completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(format: "WriterID = %@ AND ReporterID = %@", argumentArray: [reviewReport.clientInformerID, reviewReport.reportWriterID])
        CloudKitService.fetch(isPrivate: false, predicate: predicate, recordType: CloudKitTables.ReportReview.rawValue) { (items:[ReportReview]) in
            if items.count == 0 {
                CloudKitService.addItem(isPrivate: false, item: reviewReport) { _ in
                    completion(true)
                }
            }else {
                completion(false)
            }
        }
    }
}

// MARK: Funcoes para report
extension Model {
    func addReport(report: Report, completion: @escaping (Bool) -> Void) {
        CloudKitService.addItem(isPrivate: false, item: report) { result in
            switch result {
            case .success(_):
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
}
