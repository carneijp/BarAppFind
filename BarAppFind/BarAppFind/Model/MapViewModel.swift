//
//  MapViewModel.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 29/04/23.
//
import MapKit

enum MapDetails{
    static let initialCoordinate = CLLocationCoordinate2D(latitude: -29.983333, longitude: -051.1666)
    static let defaultSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.initialCoordinate , span: MapDetails.defaultSpan)
    
    var locationManager: CLLocationManager?
    
    func chekIfLocationService() {
        
        DispatchQueue.global(qos: .userInitiated).async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager = CLLocationManager()
                self.locationManager!.delegate = self
            }else{
                print("location servise desable, please enable for a better experience.")
            }
        }
    }
    
    private func checkLocationPermission() {
        
        guard let locationManager = locationManager else {return}
        
        switch locationManager.authorizationStatus{
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("your location is restricted")
        case .denied:
            print("You have denied location permission, you can change on settings.")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate,
                                        span:  MapDetails.defaultSpan)
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationPermission()
    }
}
