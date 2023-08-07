//
//  BarAppFindApp.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 28/04/23.
//
import SwiftUI
import UIKit
import AppTrackingTransparency

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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.requestDataPermission()
        }
        cloud.fetchBars { result in
            DispatchQueue.main.async {
                if result {
                    for i in 0..<self.cloud.barsList.count{
                        self.cloud.barsList[i].calculateDistance(userLocation: self.map.userCLlocation2d)
                    }
                    self.cloud.barsList.sort{$0.distanceFromUser ?? 100000 < $1.distanceFromUser ?? 100000}
                }
            }
            
        }
    }
    
    func requestDataPermission() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                switch status {
                case .authorized:
                    // Tracking authorization dialog was shown
                    // and we are authorized
                    print("Authorized")
                case .denied:
                    // Tracking authorization dialog was
                    // shown and permission is denied
                    print("Denied")
                case .notDetermined:
                    // Tracking authorization dialog has not been shown
                    print("Not Determined")
                case .restricted:
                    print("Restricted")
                @unknown default:
                    print("Unknown")
                }
            })
        } else {
            //you got permission to track, iOS 14 is not yet installed
        }
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
