//
//  LoginScreenServices.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 27/02/24.
//

import Foundation
class LoginScreenServices{
    func getCountryList(completion: @escaping (Result<CountryList, APIError>) -> Void){
        let param : [String:Any] = [:]
        APIManager.sharedInstance.performRequest(serviceType: .CountryList(parameters: param)) { response in
            switch response{
            case .success(let responseData):
                if let decodedResponseData = try? JSONDecoder().decode(CountryList.self, from: responseData){
                    completion(.success((decodedResponseData)))
                } else if let apiError = try? JSONDecoder().decode(ApiErrorModel.self, from: responseData) {
                    completion(.failure(.apiError(success: apiError.success, errorCode: apiError.error_code)))
                } else {
                    completion(.failure(.decodingError))
                }
                
            case .failure(_):
                completion(.failure(.decodingError))
            }
        }
    }
    
//    func getCountryList(completion: @escaping (Result<CountryList, APIError>) -> Void){
//        let param : [String:Any] = [:]
//        APIManager.sharedInstance.performRequest(serviceType: .CountryList(parameters: param)) { response in
//            switch response{
//            case .success(let responseData):
//                if let decodedResponseData = try? JSONDecoder().decode(CountryList.self, from: responseData){
//                    completion(.success((decodedResponseData)))
//                } else if let apiError = try? JSONDecoder().decode(ApiErrorModel.self, from: responseData) {
//                    completion(.failure(.apiError(success: apiError.success, errorCode: apiError.error_code)))
//                } else {
//                    completion(.failure(.decodingError))
//                }
//                
//            case .failure(_):
//                completion(.failure(.decodingError))
//            }
//        }
//    }

}
