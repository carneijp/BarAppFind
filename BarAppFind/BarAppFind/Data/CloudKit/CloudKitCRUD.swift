import CloudKit
import SwiftUI
import Foundation


class CloudKitCRUD: ObservableObject {
    
    @Published var barsList: [Bar] = []
    @Published var reviewListByBar: [Review] = []
    @Published var client: Clients?
    
    private func saveItemPublic(record: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(record) { returnedRecors, returnedError in
            print("\(returnedRecors)")
            print("\(returnedError)")
        }
    }
    
    private func addDataBaseOperation(operation: CKDatabaseOperation ) {
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    func addBar(bar: Bar,  completion: @escaping () -> Void) {
        var jaExiste: Bool = false
        let predicate = NSPredicate(format: "Name = %@", argumentArray: ["\(bar.name)"])
        let query = CKQuery(recordType: "Bars", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        if #available(iOS 15.0, *){
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult{
                case .success(let record):
                    jaExiste = true
                    print("Result: ", record)
                case .failure(let error):
                    print("Error matched block error\(error)")
                }
            }
            
            queryOperation.queryResultBlock = { returnedResult in
                switch returnedResult {
                case .success(let record):
                    print("result2", record as Any)
                case .failure(let error):
                    print("Error matched block error\(error)")
                }
                if(jaExiste) {
                    print("Já existe um bar com esse nome.")
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue:"notificationErrorCadastro"), object: nil)
                    completion()
                }
                else {
                    let newBar = CKRecord(recordType: "Bars")
                    
                    var assets:[CKAsset] = []
                    for i in 0..<bar.photosTOSave.count{
                        guard
                            let Image = UIImage(named: "\(bar.photosTOSave[i])"),
                            let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathExtension("\(bar.photosTOSave[i]).jpg"),
                            let data = Image.jpegData(compressionQuality: 1.0) else { return }
                        
                        do {
                            try data.write(to: url)
                            let asset = CKAsset(fileURL: url)
                            assets.append(asset)
                        }catch let error {
                            print(error)
                        }
                    }
                    
                    var logo: CKAsset?
                    guard
                        let Image = UIImage(named: "\(bar.photoLogoTOSave)"),
                        let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathExtension("\(bar.photoLogoTOSave).jpg"),
                        let data = Image.jpegData(compressionQuality: 1.0) else { return }
                    
                    do{
                        print("entrei no do")
                        try data.write(to: url)
                        let asset = CKAsset(fileURL: url)
                        logo = asset
                        print("sai do do")
                    }catch let error {
                        print(error)
                    }
                    newBar["Logo"] = logo
                    newBar["Image"] = assets
                    newBar["Name"] = bar.name
                    newBar["Description"] = bar.description
                    newBar["Mood"] = bar.mood
                    newBar["Grade"] = bar.grade
                    newBar["Latitude"] = bar.latitude
                    newBar["Caracteristicas"] = bar.caracteristicas
                    newBar["Longitude"] = bar.longitude
                    newBar["OperationHours"] = bar.operatinHours
                    newBar["Region"] = bar.regiao
                    newBar["Address"] = bar.endereco
                    
                    self.saveItemPublic(record: newBar)
                    completion()
            }
        }
        addDataBaseOperation(operation: queryOperation)
        }
    }
//    tem que arrumar o addreview para funcionar igual funciona o add bar and add user
    
    func addReview(review: Review) {
        var jaExiste: Bool = false
        let predicate = NSPredicate(format: "Bar == %@ AND WriterEmail == %@", argumentArray: ["\(review.barName)", "\(review.writerEmail)"])
        let query = CKQuery(recordType: "Reviews", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        if #available(iOS 15.0, *){
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult{
                case .success(let record):
                    print("Result: ", record)
                    jaExiste = true
                case .failure(let error):
                    print("Error matched block error\(error)")
                }
            }
            
            queryOperation.queryResultBlock = { returnedResult in
                switch returnedResult {
                case .success(let record):
                    print("result2", record as Any)
                case .failure(let error):
                    print("Error matched block error\(error)")
                }
                
                if(jaExiste){
                    print("este usuario ja fez review a este bar")
                }else{
                    let newReview = CKRecord(recordType: "Reviews")
                    newReview["Grade"] = review.grade
                    newReview["Description"] = review.description
                    newReview["Writer"] = review.writerName
                    newReview["Bar"] = review.barName
                    newReview["WriterEmail"] = review.writerEmail
                    self.saveItemPublic(record: newReview)
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name("addReview"), object: review)
                    }
                }
                
            }
        }
        
        addDataBaseOperation(operation: queryOperation)
    }
    
    func addUser(clients: Clients, completion: @escaping () -> Void) {
        var jaExiste: Bool = false
        let predicate = NSPredicate(format: "Email = %@", argumentArray: ["\(clients.email)"])
        let query = CKQuery(recordType: "Clients", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        if #available(iOS 15.0, *){
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult{
                case .success(let record):
                    jaExiste = true
                    print("Result: ", record)
                case .failure(let error):
                    print("Error matched block error\(error)")
                }
                
            }
            
            queryOperation.queryResultBlock = { returnedResult in
                switch returnedResult {
                case .success(let record):
                    print("result2", record as Any)
                case .failure(let error):
                    print("Error matched block error\(error)")
                }
                
                if(jaExiste) {
                    print("Já existe usuário com este NickName.")
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue:"notificationErrorCadastro"), object: nil)
                    completion()
                }
                else {
                    let newClient = CKRecord(recordType: "Clients")
                    newClient["Email"] = clients.email
                    newClient["FirstName"] = clients.firstName
                    newClient["LastName"] = clients.lastName
                    newClient["Password"] = clients.password
                    newClient["Badges"] = ["Badge1"]
                    newClient["Favorites"] = ["Favorite1"]
                    newClient["Level"] = clients.level
                    self.saveItemPublic(record: newClient)
                    completion()
                }
            }
        }
        
        addDataBaseOperation(operation: queryOperation)
        
        
    }
    
    func addCity(cidade: City) {
        var jaExiste: Bool = false
        let predicate = NSPredicate(format: "Name = %@", argumentArray: ["\(cidade.name)"])
        let query = CKQuery(recordType: "Citys", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        if #available(iOS 15.0, *){
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult{
                case .success(let record):
                    jaExiste = true
                    print("Result: ", record)
                case .failure(let error):
                    print("Error matched block error\(error)")
                }
            }
            
            queryOperation.queryResultBlock = { returnedResult in
                switch returnedResult {
                case .success(let record):
                    print("result2", record as Any)
                case .failure(let error):
                    print("Error matched block error\(error)")
                }
            }
        }
        
        addDataBaseOperation(operation: queryOperation)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if(jaExiste) {
                print("Já existe usuário com este NickName.")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"notificationErrorCadastro"), object: nil)
                
            }
            else  {
                let newCity = CKRecord(recordType: "Citys")
                newCity["Name"] = cidade.name
                self.saveItemPublic(record: newCity)
            }
        }
    }
    
    func fetchItemsReview(barName: String, cursor: CKQueryOperation.Cursor? = nil, completion: @escaping() -> Void) {
//        reviews de todos os reviews do bar
        
        let predicate = NSPredicate(format: "Bar = %@", argumentArray: ["\(barName)"])
        let query = CKQuery(recordType: "Reviews", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.cursor = cursor
        
        if #available(iOS 15.0, *){
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult{
                case .success(let record):
                    guard let barName = record["Bar"] as? String else { return }
                    guard let writerName = record["Writer"] as? String else { return }
                    guard let description = record["Description"] as? String else { return }
                    guard let grade = record["Grade"] as? Double else { return }
                    guard let writerEmail = record["WriterEmail"] as? String else { return }
                    DispatchQueue.main.async {
                        self.reviewListByBar.append(Review(writerEmail: writerEmail, writerName: writerName, grade: grade, description: description, barName: barName))
                    }
                case .failure(let error):
                    print("Error matched block error\(error)")
                }
            }
        }
        
        if #available(iOS 15.0, *){
            queryOperation.queryResultBlock = { [weak self] returnedResult in
                switch returnedResult {
                case .success(let cursor):
                    if cursor != nil {
                        self?.fetchItemsReview(barName: barName, cursor: cursor){
                            completion()
                        }
                    } else {
                        completion()
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
        addDataBaseOperation(operation: queryOperation)
        
    }
    
    func fetchItemsReview(nickName: String, cursor: CKQueryOperation.Cursor? = nil, completion: @escaping () -> Void) {
        //reviews do usuario
        if(cursor == nil) {
            self.reviewListByBar = []
        }
        
        let predicate = NSPredicate(format: "WriterNickName = %@", argumentArray: ["\(nickName)"])
        let query = CKQuery(recordType: "Reviews", predicate: predicate)
//        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.cursor = cursor
        
        if #available(iOS 15.0, *){
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult{
                case .success(let record):
                    guard let barName = record["Bar"] as? String else { return }
                    guard let writerName = record["Writer"] as? String else { return }
                    guard let description = record["Description"] as? String else { return }
                    guard let grade = record["Grade"] as? Double else { return }
                    guard let writerEmail = record["WriterEmail"] as? String else { return }
                    DispatchQueue.main.async {
                        self.reviewListByBar.append(Review(writerEmail: writerEmail, writerName: writerName, grade: grade, description: description, barName: barName))
                    }
                case .failure(let error):
                    print("Error matched block error\(error)")
                }
            }
        }
        
        //COMPLETIONS BLOCKS
        
        if #available(iOS 15.0, *){
            queryOperation.queryResultBlock = { [weak self] returnedResult in
                switch returnedResult {
                case .success(let cursor):
                    if cursor != nil {
                        self?.fetchItemsReview(nickName: nickName, cursor: cursor){
                            completion()
                        }
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                    completion()
                }
            }
        }
        addDataBaseOperation(operation: queryOperation)
        completion()
        
    }
    
    func validateClientLogin(email: String, password: String, completion: @escaping () -> Void) {
        let predicate = NSPredicate(format: "Email = %@", argumentArray: ["\(email)"])
        let query = CKQuery(recordType: "Clients", predicate: predicate)
        
        CKContainer.default().publicCloudDatabase.fetch(withQuery: query) { (result: Result<(matchResults: [(CKRecord.ID, Result<CKRecord, Error>)], queryCursor: CKQueryOperation.Cursor?), Error>) in
            switch result {
            case .success(let success):
                // Se verdadeiro, signfica que existe algum usuário, se não, não existe
                if success.matchResults.count > 0 {
                    for element in success.matchResults {
                        switch element.1 {
                        case .success(let record):
                            guard let Email = record["Email"] as? String else { return }
                            guard let LastName = record["LastName"] as? String else { return }
                            guard let FirtName = record["FirstName"] as? String else { return }
                            guard let Password = record["Password"] as? String else { return }
                            guard let Badges = record["Badges"] as? [String] else { return }
                            guard let Favorites = record["Favorites"] as? [String] else { return }
                            guard let Level = record["Level"] as? Int else { return }
                            let clients = Clients(email: Email, firstName: FirtName, password: Password, lastName: LastName)
                            clients.level = Level
                            clients.badges = Badges
                            clients.favorites = Favorites
                            
                            if clients.email == email && clients.password == password {
                                DispatchQueue.main.async {
                                    self.client = clients
                                }
                                completion()
                            } else {
                                #warning("Informar que senha e usuários estão incorretos")
                                completion()
                            }
                        case .failure(let err):
                            print(err.localizedDescription)
                            completion()
                        }
                    }
                }
            case .failure(let failure):
                print(failure.localizedDescription)
                completion()
            }
        }
    }
    
    func fetchBars(cursor: CKQueryOperation.Cursor? = nil) {
        if(cursor == nil) {
            self.barsList = []
        }
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Bars", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.resultsLimit = 50
        queryOperation.cursor = cursor
        
        if #available(iOS 15.0, *){
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult{
                case .success(let record):
                    guard let barName = record["Name"] as? String else { return }
                    guard let mood = record["Mood"] as? [String] else { return }
                    guard let description = record["Description"] as? String else { return }
                    guard let address = record["Address"] as? String else { return }
                    guard let grade = record["Grade"] as? Double else { return }
                    guard let latitude = record["Latitude"] as? Double else { return }
                    guard let longitude = record["Longitude"] as? Double else { return }
                    guard let operationHours = record["OperationHours"] as? [String] else { return }
                    guard let region = record["Region"] as? String else { return }
                    guard let characteristics = record["Caracteristicas"] as? [String] else { return }
                    guard let logoPhoto = record["Logo"] as? CKAsset else { return }
                    guard let imageLogoPhoto = logoPhoto.fileURL else { return }
                    
                    let bar: Bar = Bar(name: barName, description: description, mood: mood, grade: grade, latitude: latitude, longitude: longitude, operatinhours: operationHours, endereco: address, regiao: region, caracteristicas: characteristics)
                    bar.recieveLogoPhoto(logo: imageLogoPhoto)
                    
                    DispatchQueue.main.async {
                        self.barsList.append(bar)
                    }
                    
                case .failure(let error):
                    print("Error matched block error\(error)")
                }
            }
        }
        
        //COMPLETIONS BLOCKS
        
        if #available(iOS 15.0, *){
            queryOperation.queryResultBlock = { [weak self] returnedResult in
                switch returnedResult {
                case .success(let cursor):
                    if cursor != nil {
                        self?.fetchBars(cursor: cursor)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
        addDataBaseOperation(operation: queryOperation)
    }
    
    func fetchBar(barName: String, completion: @escaping (Bar?) -> Void) {
        let predicate = NSPredicate(format: "Name = %@", argumentArray: ["\(barName)"])
        let query = CKQuery(recordType: "Bars", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedPhotos: [URL] = []
        
        if #available(iOS 15.0, *){
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult{
                case .success(let record):
                    guard let barName = record["Name"] as? String else { return }
                    guard let mood = record["Mood"] as? [String] else { return }
                    guard let description = record["Description"] as? String else { return }
                    guard let address = record["Address"] as? String else { return }
                    guard let grade = record["Grade"] as? Double else { return }
                    guard let latitude = record["Latitude"] as? Double else { return }
                    guard let longitude = record["Longitude"] as? Double else { return }
                    guard let operationHours = record["OperationHours"] as? [String] else { return }
                    guard let imageAsset = record["Image"] as? [CKAsset] else { return }
                    guard let region = record["Region"] as? String else { return }
                    guard let characteristics = record["Caracteristicas"] as? [String] else { return }
                    guard let logoPhoto = record["Logo"] as? CKAsset else { return }
                    guard let imageLogoPhoto = logoPhoto.fileURL else { return }
                    
                    for i in 0..<imageAsset.count{
                        guard let imageURL = imageAsset[i].fileURL else { return }
                        returnedPhotos.append(imageURL)
                    }
                    
                    let bar: Bar = Bar(name: barName, description: description, mood: mood, grade: grade, latitude: latitude, longitude: longitude, operatinhours: operationHours, endereco: address, regiao: region, caracteristicas: characteristics)
                    bar.recieveAllPhotos(photosToUSE: returnedPhotos)
                    bar.recieveLogoPhoto(logo: imageLogoPhoto)
                    completion(bar)
                case .failure(let error):
                    print("Error matched block error\(error)")
                    completion(nil)
                }
            }
        }
        addDataBaseOperation(operation: queryOperation)
    }
    
    func addFavoriteBar(client: Clients, barName: String){
        let predicate = NSPredicate(format: "Email = %@", argumentArray: ["\(client.email)"])
        let query = CKQuery(recordType: "Clients", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.resultsLimit = 50
        var listFavorites = client.favorites
        listFavorites.append(barName)
        
        if #available(iOS 15.0, *){
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult{
                case .success(let client):
                    client["Favorites"] = listFavorites
                    self.saveItemPublic(record: client)
                case .failure(let error):
                    print("Error matched block error\(error)")
                }
            }
        }
        
        addDataBaseOperation(operation: queryOperation)
    }
    
    func removeFavoriteBar(client: Clients, barName: String){
        let predicate = NSPredicate(format: "Email = %@", argumentArray: ["\(client.email)"])
        let query = CKQuery(recordType: "Clients", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.resultsLimit = 50
        var listFavorites = client.favorites
        var count: Int = listFavorites.firstIndex(of: barName) ?? -1
        listFavorites.remove(at: count)
        
        if #available(iOS 15.0, *){
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult{
                case .success(let record):
                    record["Favorites"] = listFavorites
                    self.saveItemPublic(record: record)
                case .failure(let error):
                    print("Error matched block error\(error)")
                }
            }
        }
        
        addDataBaseOperation(operation: queryOperation)
    }
    
    func nextLevel(client: Clients){
        let predicate = NSPredicate(format: "Email = %@", argumentArray: ["\(client.email)"])
        let query = CKQuery(recordType: "Clients", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.resultsLimit = 50
        let level = client.level + 1
        
        if #available(iOS 15.0, *){
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult{
                case .success(let record):
                    record["Level"] = level
                    self.saveItemPublic(record: record)
                case .failure(let error):
                    print("Error matched block error\(error)")
                }
            }
        }
        
        addDataBaseOperation(operation: queryOperation)
    }
    
}
