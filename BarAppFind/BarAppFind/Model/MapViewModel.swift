//
//  MapViewModel.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 29/04/23.
//
import MapKit

enum MapDetails{
    case bomFimCoordinate
    case cidadeBaixaCoordinate
    case quartoDistritoCoordinate
    static let initialCoordinate = CLLocationCoordinate2D(latitude: -29.983333, longitude: -051.1666)
    static let defaultSpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    
    var description: String {
        switch self {
        case .bomFimCoordinate:
            return "Bom Fim"
        case .cidadeBaixaCoordinate:
            return "Cidade Baixa"
        case .quartoDistritoCoordinate:
            return "Quarto Distrito"
        }
    }
    
    var coordinate: CLLocationCoordinate2D {
        switch self {
        case .bomFimCoordinate:
            return CLLocationCoordinate2D(latitude: -30.032882, longitude: -51.213410)

        case .cidadeBaixaCoordinate:
            return CLLocationCoordinate2D(latitude: -30.039670, longitude: -51.223117)
            
        case .quartoDistritoCoordinate:
            return CLLocationCoordinate2D(latitude: -30.009066, longitude: -51.206277)
        }
    }
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var chosen: MapDetails?
    @Published var latitude: Double?
    @Published var longitude: Double?
    @Published var userLocation: MKCoordinateRegion?
    @Published var region = MKCoordinateRegion(center: MapDetails.initialCoordinate , span: MapDetails.defaultSpan)
    
    var locationManager: CLLocationManager?
    
    func wheretoZoom(){
        chekIfLocationService()
        if let fixlatitude = latitude, let fixLongitude = longitude{
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: fixlatitude, longitude: fixLongitude) , span: MapDetails.defaultSpan)
        }else if let location = chosen{
            region = MKCoordinateRegion(center: location.coordinate, span: MapDetails.defaultSpan)
        }
        
    }
    
    func chekIfLocationService() {
        
        DispatchQueue.global(qos: .background).async {
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
