//
//  CloudKitUserIcloud.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 03/05/23.
//
import CloudKit
import SwiftUI

class CloudKitUserIcloudViewModel: ObservableObject{
    
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    @Published var userName: String = ""
    @Published var permission: Bool = false
    
    init(){
        getiCloudStatus()
//        requestPermission()
//        fetchiCloudUserId()
    }
    
    func requestPermission(){
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                if returnedStatus == .granted {
                    self?.permission = true
                }
            }
        }
    }
    
    func fetchiCloudUserId() {
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
            if let id = returnedID {
                self?.discoveriCloudUser(id: id)
            }
        }
    }
    
    
    private func getiCloudStatus(){
        CKContainer.default().accountStatus { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                switch returnedStatus {
                case.available:
                    self?.isSignedInToiCloud = true
                case.noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                case.couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccountNotDetermined.rawValue
                case.restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.rawValue
                default:
                    self?.error = CloudKitError.iCloudAccountUnknown.rawValue
                }
            }
        }
    }
    
    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
        
    }
    
    
    func discoveriCloudUser(id: CKRecord.ID) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] returnedIdentity, returnedError in
            DispatchQueue.main.async {
                if let name = returnedIdentity?.nameComponents?.givenName {
                    self?.userName = name
                }
            }
        }
        
    }
    
    
    
    
}
//
//struct CloudKitUserIcloud: View {
//    @StateObject var cloudUser = CloudKitUserIcloudViewModel()
//    var body: some View {
////        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//        Text("User logged in: \(cloudUser.isSignedInToiCloud.description.uppercased())")
//        Text("User permission in: \(cloudUser.permission.description.uppercased())")
//        Text("User user name in: \(cloudUser.userName)")
////        Text("User logged in:\(cloudUser.isSignedInToiCloud)")
//    }
//}
//
//struct CloudKitUserIcloud_Previews: PreviewProvider {
//    static var previews: some View {
//        CloudKitUserIcloud()
//    }
//}
