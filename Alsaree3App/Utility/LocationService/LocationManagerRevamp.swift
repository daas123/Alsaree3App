import CoreLocation
import UIKit

class LocationManagerRevamp: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManagerRevamp()
    
    private var locationManager: CLLocationManager
    var currentLocation: CLLocationCoordinate2D?
    var isLocationAccess = false
    
#if targetEnvironment(simulator)
    private let isSimulator = true
#else
    private let isSimulator = false
#endif
    
    private override init() {
        locationManager = CLLocationManager()
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    func requestLocationPermission(completion: @escaping (Bool) -> Void) {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            completion(true)
        case .denied, .restricted:
            locationManager.requestWhenInUseAuthorization()
            completion(false)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            completion(false)
        @unknown default:
            fatalError("Unhandled case in requestLocationPermission")
        }
    }
    
    func startMonitoringSignificantLocationChanges() {
        if CLLocationManager.significantLocationChangeMonitoringAvailable() {
            locationManager.startMonitoringSignificantLocationChanges()
        }
    }
    
    func stopMonitoringSignificantLocationChanges() {
        locationManager.stopMonitoringSignificantLocationChanges()
    }
    
    func getCurrentLocation(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        requestLocationPermission { granted in
            //            if granted {
            //                self.startMonitoringSignificantLocationChanges()
            //                completion(self.currentLocation)
            //            } else {
            //                completion(nil)
            //            }
            
            if granted {
                if self.isSimulator {
                    completion(self.currentLocation)
                } else {
                    self.currentLocation?.longitude = 44.416270
                    self.currentLocation?.latitude = 33.341658
                    NotificationManager().postReloadData()
                    completion(self.currentLocation)
                }
            } else {
                //33.186011
                //44.607282
                completion(nil)
            }
            
        }
    }
        // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            startMonitoringSignificantLocationChanges()
        case .denied, .restricted:
            locationManager.requestWhenInUseAuthorization()
            isLocationAccess = false
        case .notDetermined:
            break
        @unknown default:
            fatalError("Unhandled case in locationManager(_:didChangeAuthorization:)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last?.coordinate else { return }
//        currentLocation = newLocation
        isLocationAccess = true
        if self.isSimulator {
            currentLocation = newLocation
            NotificationManager().postReloadData()
        } else {
            currentLocation = CLLocationCoordinate2D(latitude: 33.341658, longitude: 44.416270)
            NotificationManager().postReloadData()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Location manager failed with error: \(error.localizedDescription)")
    }
}
