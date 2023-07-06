//
//  BarAppFindApp.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 28/04/23.
//
import SwiftUI
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    static var orientationLock = UIInterfaceOrientationMask.portrait

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}

class SceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
    var cloud: CloudKitCRUD!
    var map: MapViewModel!

//    func sceneWillEnterForeground(_ scene: UIScene) {
//        print("✅✅✅ sceneWillEnterForeground ✅✅✅")
//    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        print("✅✅✅ sceneDidBecomeActive ✅✅✅")
//        cloud.fetchBars { result in
//            if result {
                for i in 0..<self.cloud.barsList.count{
                    self.cloud.barsList[i].calculateDistance(userLocation: self.map.userCLlocation2d)
                }
                self.cloud.barsList.sort{$0.distanceFromUser ?? 100000 < $1.distanceFromUser ?? 100000}
//           t
        
    }
    
//    func sceneWillResignActive(_ scene: UIScene) {
//        print("✅✅✅ sceneWillResignActive ✅✅✅")
//    }
}




@main
struct BarAppFindApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environmentObject(MapViewModel())
                .environmentObject(CloudKitCRUD())
        }
    }
}
