

import Foundation

enum APiResponceError : Error {
    case noNetwork
    case noLocation
    case apiFailed
}
class APIManager {
    
    static let sharedInstance = APIManager()
    
    private init(){}
    
    public func performRequest(serviceType: APIServices, completionHandler: @escaping(Result<Data,Error>)->Void){
        
        //  Reachability to check network connected or not
        if !ReachabilityRevamp.isConnectedToNetwork() {
            NotificationManager().postNetworkStatusChanged()
            completionHandler(.failure(APiResponceError.noNetwork))
            return
        }
        
        if !LocationManagerRevamp.shared.isLocationAccess {
            NotificationManager().postLocationAccessRestricted()
            if case .AppSettings = serviceType {
                completionHandler(.failure(APiResponceError.noLocation))
            }else{
                return
            }
        }
        
        
        let session = URLSession.shared
        
        var request = URLRequest(url: URL(string: serviceType.Path)!)
        request.httpMethod = serviceType.httpMethod
        
        if let params = serviceType.parameters{
            if serviceType.httpMethod == "POST"{
                var requestBodyComponents = URLComponents()
                requestBodyComponents.queryItems = params.map{
                    (key, value) in
                    URLQueryItem(name: key, value: String(describing: value))
                }
                request.httpBody = requestBodyComponents.query?.data(using: .utf8)
            }
            else{
                var urlComponents = URLComponents(string: serviceType.Path)
                urlComponents?.queryItems = params.map{
                    (key, value) in
                    URLQueryItem(name: key, value: String(describing: value))
                }
                request.url = urlComponents?.url
            }
        }
        
        request.allHTTPHeaderFields = serviceType.header
        
        let task = session.dataTask(with: request as URLRequest){
            data, responce, error in
            
            // ensure there is no error for this HTTP response
            guard error == nil else {
                completionHandler(.failure(error!))
                debugPrint ("error: \(error!)")
                return
            }
            
            // ensure there is data returned from this HTTP response
            guard let content = data else {
                completionHandler(.failure(error!))
                debugPrint("No data")
                return
            }
            
            guard ( (responce as! HTTPURLResponse).statusCode == 200 ) else{
                completionHandler(.failure(APiResponceError.apiFailed))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)
                completionHandler(.success(content))
            } catch let decodingError {
                if (responce as! HTTPURLResponse).statusCode == 200{
                    completionHandler(.failure(decodingError))
                }
                debugPrint("Decoding error: \(decodingError)")
            }
            
        }
        task.resume()
    }
}
