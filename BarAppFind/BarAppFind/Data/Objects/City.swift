//
//  City.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 30/04/23.
//

import Foundation
import SwiftUI

class City: ObservableObject {
    var name: String
    @Published var bars: [Bar] = []
    init(name:String) {
        self.name = name
    }
    func addBar(bar: Bar){
        bars.append(bar)
    }
}





class OperationHours: ObservableObject {
    var barName: String
    var monday: String
    var tuesday: String
    var wednesday: String
    var thrusday: String
    var friday: String
    var saturday: String
    var sunday: String
    
    init(barName: String, monday: String, tuesday: String, wednesday: String, thrusday: String, friday: String, saturday: String, sunday: String) {
        self.barName = barName
        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thrusday = thrusday
        self.friday = friday
        self.saturday = saturday
        self.sunday = sunday
    }
}




class Bar: ObservableObject {
    @StateObject var cloud = CloudKitCRUD()
    var name: String
    var description: String
    var fakeID: String
    var mood: String
    var expensive: String
    var grade: Double
    var reviews: [Review]
    var operatinHours: OperationHours
    var photos: [String] = []
    var latitude: Double
    var longitude: Double
    
    init(name: String, description: String, fakeID: String, mood: String, expensive: String, grade: Double, latitude: Double, longitude: Double) {
        self.name = name
        self.description = description
        self.fakeID = fakeID
        self.mood = mood
        self.expensive = expensive
        self.grade = grade
//        cloud.fetchoperationHours(barName: self.name)
//        guard let operation = cloud.operationHours else { return }
        self.operatinHours = operation
//        self.photos = photos
        self.latitude = latitude
        self.longitude = longitude
//        cloud.fetchItemsReview(barName: self.name)
//        self.reviews = cloud.reviewList
    }
    
    func changeDescription(description: String) {
        self.description = description
    }
    func addPhotos(photo: String) {
        self.photos.append(photo)
    }
    func removePhoto(photo: String) {
        for i in 0...photos.count {
            if photos[i] == photo{
                photos.remove(at: i)
            }
        }
    }
}




struct Review {
    var writerNickName: String
    var writerName: String
    var grade: Double
    var description: String
    var barName: String
}
