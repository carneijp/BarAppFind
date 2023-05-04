//
//  City.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 30/04/23.
//

import Foundation

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
    var name: String
    var description: String = ""
    var fakeID: String
    var mood: String = ""
    var expensive: String = ""
    var grade: Double = 0.0
    var reviews: [Review] = []
    var operatinHours: OperationHours
    var photos: [String] = []
    var latitude: Double
    var longitude: Double
    
    
    init(name: String, latitude: Double, longitude: Double, operationHours: OperationHours, fakeID: String){
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.operatinHours = operationHours
        self.fakeID = fakeID
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
    var writerName: Clients
    var grade: Double
    var description: String
    var barName: Bar
}

//var cidade = City(name: "Porto Alegre")
//var bar1 = Bar(name: "Maza", latitude: -30.062134, longitude: -51.174497)

