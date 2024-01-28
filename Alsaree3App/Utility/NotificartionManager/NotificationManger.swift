//
//  NotificationManger.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 24/01/24.
//

import Foundation
extension Notification.Name {
    static let networkStatusChanged = Notification.Name("NetworkStatusChanged")
    static let locationAccessRestricted = Notification.Name("locationAccessRestricted")
    static let reloadData = Notification.Name("ReloadData")
    static let noLocationDeliverable = Notification.Name("noLocationDeliverable")
}

class NotificationManager {
    
    func postNetworkStatusChanged() {
        NotificationCenter.default.post(name: .networkStatusChanged, object: nil)
    }
    
    func postLocationAccessRestricted() {
        NotificationCenter.default.post(name: .locationAccessRestricted, object: nil)
    }
    
    func postReloadData(){
        NotificationCenter.default.post(name: .reloadData, object: nil)
    }
    
    func postnoLocationDeliverable(){
        NotificationCenter.default.post(name: .noLocationDeliverable, object: nil)
    }
    
    func addObserver(forName name: Notification.Name, using block: @escaping (Notification) -> Void) {
        NotificationCenter.default.addObserver(forName: name, object: nil, queue: nil, using: block)
    }
    
    func removeObserver(_ observer: Any) {
        NotificationCenter.default.removeObserver(observer)
    }
}
