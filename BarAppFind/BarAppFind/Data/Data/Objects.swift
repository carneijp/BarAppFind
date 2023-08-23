//
//  User.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 30/04/23.
//
import Foundation
import CloudKit

var trendings: [String] = ["trending1","trending2","trending3"]
var moodsImage: [String] = ["Família","Fofoca","Barzinho","Esquenta","Casal","Temático"]
var moodsName: [String] = ["Família","Fofoca","Barzinho","Esquenta","Casal","Temático"]
var moodsBanner: [String] = ["Família2","Fofoca2","Barzinho2","Esquenta2","Casal2","Temático2"]
var moodsColors: [String] = ["Família3","Fofoca3","Barzinho3","Esquenta3","Casal3","Temático3"]
var conquestMedals: [String] = ["Primeiro Acesso","Bom finer", "Já sabe do que gosta", "Nível 2", "Nível 3", "Nível 4", "Nível 5", "Nível 6"]
var medalDescriptions: [String] = ["O início de sua jornada pelos bares de Porto Alegre começa aqui!","Você conhece todos os bares do bairro Bom Fim! 🤩", "Você já definiu o seu gosto dentro do app 🤩"]
let ambient = ["Ao ar livre":"leaf", "Madrugada":"moon.stars", "Aceita pets":"pawprint.circle", "Estacionamento":"e.circle", "Climatizado":"snowflake", "Wifi":"wifi", "Permitido fumar":"cigarro",]

class Clients: ObservableObject, CloudKitableProtocol {
    
    var record: CKRecord
//    var email: String
    var firstName: String
    var lastName: String
    var userID: String
    var badges: [String] = []
    var level: Int = 1
    var favorites: [String] = []
    
    required init?(record: CKRecord) {
//        guard let email = record["Email"] as? String else { return nil }
//        self.email = email
        
        guard let firstName = record["FirstName"] as? String else { return nil }
        self.firstName = firstName
        
        guard let lastName = record["LastName"] as? String else { return nil }
        self.lastName = lastName
        
        guard let userID = record["UserID"] as? String else { return nil }
        self.userID = userID
        
        if let badges = record["Badges"] as? [String] {
            self.badges = badges
        }else {
            self.badges = []
        }
        
        guard let level = record["Level"] as? Int else { return nil }
        self.level = level
        
        if let favorites = record["Favorites"] as? [String] {
            self.favorites = favorites
        }else {
            self.favorites = []
        }
        self.record = record
    }
    
    init?(firstName: String, lastName: String, userID: String, level: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.userID = userID
        self.level = level
        self.badges = []
        self.favorites = []
        let record = CKRecord(recordType: CloudKitTables.Clients.rawValue)
        record["FirstName"] = self.firstName
        record["LastName"] = self.lastName
        record["UserID"] = self.userID
        record["Level"] = self.level
        self.record = record
    }
    
    func updateClient(newFirstName: String? = nil, newLastName: String? = nil, newBadges: [String]? = nil, newLevel: Int? = nil, newFavorites: [String]? = nil) -> Clients {
        let record = self.record
        if let firstName = newFirstName {
            record["FirstName"] = firstName
            self.firstName = firstName
        }
        
        if let lastName = newLastName {
            record["LastName"] = lastName
            self.lastName = lastName
        }
        
        if let badges = newBadges {
            record["Badges"] = badges
            self.badges = badges
        }
        
        if let favorites = newFavorites {
            record["Favorites"] = favorites
            self.favorites = favorites
        }
        
        if let level = newLevel {
            record["Level"] = level
            self.level = level
        }
        
        return self
    }
}

class Bar: ObservableObject, Hashable, Identifiable, CloudKitableProtocol {
    static func == (lhs: Bar, rhs: Bar) -> Bool {
        lhs.record == rhs.record
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(record)
    }
    
    var record: CKRecord
    var name: String
    var description: String
    var caracteristicas: [String]
    var mood: [String]
    var grade: Double
    var reviews: [Review] = []
    var operatinHours: [String]
    var photosLogo: URL?
    var photosToUse: [URL] = []
    var latitude: Double
    var longitude: Double
    var address: String
    var coordinate: CLLocationCoordinate2D
    var linktInsta: String = ""
    var distanceFromUser: Double?
    var region: String
//    var expensive: String = ""
//    var photosTOSave: [String] = []
//    var photoLogoTOSave: String = ""
    
    required init?(record: CKRecord) {
        guard let name = record["Name"] as? String else { return nil }
        self.name = name
        
        guard let description = record["Description"] as? String else { return nil }
        self.description = description
        
        guard let caracteristicas = record["Caracteristicas"] as? [String] else { return nil }
        self.caracteristicas = caracteristicas
        
        guard let moods = record["Mood"] as? [String] else { return nil }
        self.mood = moods
        
        guard let region = record["Region"] as? String else { return nil }
        self.region = region
        
        guard let grade = record["Grade"] as? Double else { return nil }
        self.grade = grade
        
        guard let operationHours = record["OperationHours"] as? [String] else { return nil }
        self.operatinHours = operationHours
        
        guard let address = record["Address"] as? String else { return nil }
        self.address = address
        
        guard let latitude = record["Latitude"] as? Double else { return nil }
        self.latitude = latitude
        
        guard let longitude = record["Longitude"] as? Double else { return nil }
        self.longitude = longitude
        
        if let instaLink = record["InstaLink"] as? String {
            self.linktInsta = instaLink
        }
                
        if let photoUrl = record["Logo"] as? CKAsset {
            if let image = photoUrl.fileURL {
                self.photosLogo = image
            }
        }
        
        if let photoUrl = record["Image"] as? [CKAsset] {
            for image in photoUrl {
                if let image = image.fileURL {
                    self.photosToUse.append(image)
                }
            }
        }
        
        self.coordinate = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        
        self.record = record
    }
    
    
    init(name: String, description: String, caracteristicas: [String], mood: [String], grade: Double, operationHours: [String], latitude: Double, longitude: Double, address: String, region: String) {
        self.name = name
        self.description = description
        self.caracteristicas = caracteristicas
        self.mood = mood
        self.grade = grade
        self.operatinHours = operationHours
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.region = region
        self.photosLogo = nil
        self.photosToUse = []
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let record = CKRecord(recordType: CloudKitTables.Bars.rawValue)
        record["Name"] = self.name
        record["Description"] = self.description
        record["Caracteristicas"] = self.caracteristicas
        record["Mood"] = self.mood
        record["Grade"] = self.grade
        record["OperationHours"] = self.operatinHours
        record["Latitude"] = self.latitude
        record["Longitude"] = self.longitude
        record["Address"] = self.address
        record["Region"] = self.region
        
        self.record = record
    }
    
    func updateBar(newName: String? = nil, newDescription: String? = nil, newCaracteristicas: [String] = [], newMood: [String] = [], newGrade: Double? = nil, newOperationHours: [String] = [], newLatitude: Double? = nil, newLongitude: Double? = nil, newAddress: String? = nil, newRegion: String? = nil) -> Bar {
        let record = self.record
        if let name = newName{
            record["Name"] = name
            self.name = name
        }
        
        if let region = newRegion {
            record["Region"] = region
            self.region = region
        }
        
        if let address = newAddress {
            record["Address"] = address
            self.address = address
        }
        
        if let description = newDescription {
            record["Description"] = description
            self.description = description
        }
        
        if let grade = newGrade {
            record["Grade"] = grade
            self.grade = grade
        }
        
        if let latitude = newLatitude {
            record["Latitude"] = latitude
            self.latitude = latitude
        }
        
        if let longitude = newLongitude {
            record["Longitude"] = longitude
            self.longitude = longitude
        }
        
        
        if !newCaracteristicas.isEmpty {
            record["Caracteristicas"] = newCaracteristicas
            self.caracteristicas = newCaracteristicas
        }
        
        if !newMood.isEmpty {
            record["Mood"] = newMood
            self.mood = newMood
        }
        
        if !newOperationHours.isEmpty {
            record["OperationHours"] = newOperationHours
            self.operatinHours = newOperationHours
        }
        return self
    }
    
    func calculateDistance(userLocation: CLLocationCoordinate2D?) {
        if let userLocation = userLocation {
            let userlatitude: Double = userLocation.latitude
            let userLongitude: Double = userLocation.longitude
            let distance: Double = sqrt(pow((self.latitude - userlatitude), 2) + pow((self.longitude - userLongitude), 2)) * 112.35
            self.distanceFromUser = distance
        }else {
            self.distanceFromUser = nil
        }
        
    }
    
}

class Review: ObservableObject, Hashable, Identifiable, CloudKitableProtocol {
    static func == (lhs: Review, rhs: Review) -> Bool {
        lhs.record == rhs.record
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(record)
    }
    
    var record: CKRecord
    var writerId: String
    var writerName: String
    var grade: Double
    var description: String
    var barName: String
    
    required init?(record: CKRecord) {
        guard let writerID = record["WriterID"] as? String else { return nil }
        self.writerId = writerID
        
        guard let writerName = record["Writer"] as? String else { return nil }
        self.writerName = writerName
        
        guard let grade = record["Grade"] as? Double else { return nil }
        self.grade = grade
        
        guard let description = record["Description"] as? String else { return nil }
        self.description = description
        
        guard let barName = record["Bar"] as? String else { return nil }
        self.barName = barName
        
        self.record = record
    }
    
    init(writerName: String, grade: Double, description: String, barName: String, writerId: String) {
        self.writerName = writerName
        self.grade = grade
        self.description = description
        self.barName = barName
        self.writerId = writerId
        let record  = CKRecord(recordType: CloudKitTables.Reviews.rawValue)
        record["WriterID"] = self.writerId
        record["Writer"] = self.writerName
        record["Grade"] = self.grade
        record["Description"] = self.description
        record["Bar"] = self.barName
        
        self.record = record
    }
    
    func updateReview(newDescription: String? = nil, newGrade: Double? = nil) -> Review {
        let record = self.record
        if let grade = newGrade {
            record["Grade"] = grade
            self.grade = grade
        }
        if let description = newDescription {
            record["Description"] = description
            self.description = description
        }
        return self
    }
}

class ReportReview: ObservableObject, Hashable, Identifiable, CloudKitableProtocol {
    static func == (lhs: ReportReview, rhs: ReportReview) -> Bool{
        lhs.record == rhs.record
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(record)
    }
    
    var record: CKRecord
    var clientInformerID: String
    var reportBarName: String
    var reportWriterID: String
    var reportDescription: String
    var reportReason: String
    
    required init?(record: CKRecord) {
        guard let clienteInformerID = record["ClienteInformerID"] as? String else { return nil }
        self.clientInformerID = clienteInformerID
        
        guard let reportDescription = record["ReportDescription"] as? String else { return nil }
        self.reportDescription = reportDescription
        
        guard let reportReason = record["ReportReason"] as? String else { return nil }
        self.reportReason = reportReason
        
        guard let reportBarName = record["ReportBarName"] as? String else { return nil }
        self.reportBarName = reportBarName
        
        guard let reportWriterID = record["ReportWriterID"] as? String else { return nil }
        self.reportWriterID = reportWriterID
        
        self.record = record
    }
    
    init(clientInformerID: String, reportBarName: String, reportDescription: String, reportWriterID: String, reportReason: String) {
        self.clientInformerID = clientInformerID
        self.reportBarName = reportBarName
        self.reportDescription = reportDescription
        self.reportWriterID = reportWriterID
        self.reportReason = reportReason
        let record = CKRecord(recordType: CloudKitTables.ReportReview.rawValue)
        record["ClienteInformerID"] = self.clientInformerID
        record["ReportDescription"] = self.reportDescription
        record["ReportReason"] = self.reportReason
        record["ReportBarName"] = self.reportBarName
        record["ReportWriterID"] = self.reportWriterID
        self.record = record
    }
    
    
    func updateReportReview(newReason: String? = nil, newDescription: String? = nil) -> ReportReview {
        let record = self.record
        if let reason = newReason {
            record["ReportReason"] = reason
            self.reportReason = reason
        }
        
        if let description = newDescription {
            record["ReportDescription"] = description
            self.reportDescription = description
        }
        
        return self
    }
}

// For app problem
class Report: ObservableObject, Hashable, Identifiable, CloudKitableProtocol {
    static func == (lhs: Report, rhs: Report) -> Bool {
        lhs.record == rhs.record
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(record)
    }
    
    var record: CKRecord
    var assunto: String
    var descricao: String
    var userID: String
    
    required init?(record: CKRecord) {
        guard let assunto = record["Assunto"] as? String else { return nil }
        self.assunto = assunto
        
        guard let texto = record["Descricao"] as? String else { return nil }
        self.descricao = texto
        
        guard let userID = record["UserID"] as? String else { return nil }
        self.userID = userID
        
        self.record = record
    }
    
    init?(assunto: String, descricao: String, userID: String) {
        self.userID = userID
        self.assunto = assunto
        self.descricao = descricao
        let record = CKRecord(recordType: CloudKitTables.Reports.rawValue)
        record["Assunto"] = self.assunto
        record["Descricao"] = self.descricao
        record["UserID"] = self.userID
        self.record = record
    }
    
    func updateReport(newAssunto: String? = nil, newDescricao: String? = nil, newUserID: String? = nil) -> Report {
        let record = self.record
        if let userID = newUserID {
            record["UserID"] = userID
            self.userID = userID
        }
        
        if let descricao = newDescricao {
            record["Descricao"] = descricao
            self.descricao = descricao
        }
        
        if let assunto = newAssunto {
            record["Assunto"] = assunto
            self.assunto = assunto
        }
        return self
    }
}
