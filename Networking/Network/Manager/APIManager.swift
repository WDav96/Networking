//
//  APIManager.swift
//  Networking
//
//  Created by Wilson David Molina Lozano on 18/08/22.
//

import Foundation
import Alamofire

final class APIManager {
    
    static let shared = APIManager()
    
    // MARK: - Private Properties
    
    private let baseUrl = "https://gorest.co.in/public-api/"
    private let statusOk = 200...299
    private let token = "23cf2efdb6001045d3ff6e705499e5294ea7094c117c7d07d2e1a06bd1fca2ae"
    
    // MARK: - Internal Methods
    
    func getUser(id: Int, onSuccess: @escaping (_ user: User) -> (), onFailure: @escaping (_ error: Error?) -> ()) {
        let url = "\(baseUrl)users/\(id)"
        
        AF.request(url, method: .get).validate(statusCode: statusOk).responseDecodable (of: UserResponse.self, decoder: DateDecoder()) { response in
            
            guard let user = response.value?.data else {
                onFailure(response.error)
                return
            }
            onSuccess(user)
        }
    }
    
    func addUser(user: NewUser, onSuccess: @escaping (_ user: User) -> (), onFailure: @escaping (_ error: Error?) -> ()) {
        let url = "\(baseUrl)users"
        
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: statusOk).responseDecodable (of: UserResponse.self, decoder: DateDecoder()) { response in
            
            guard let user = response.value?.data, user.id != nil else {
                onFailure(response.error)
                return
            }
            onSuccess(user)
        }
    }
    
    func updateUser(id: Int, user: NewUser, onSuccess: @escaping (_ user: User) -> (), onFailure: @escaping (_ error: Error?) -> ()) {
        let url = "\(baseUrl)users/\(id)"
        
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(url, method: .put, parameters: user, encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: statusOk).responseDecodable (of: UserResponse.self, decoder: DateDecoder()) { response in
            
            guard let user = response.value?.data, user.id != nil else {
                onFailure(response.error)
                return
            }
            onSuccess(user)
        }
    }
    
    func deleteUser(id: Int, onSuccess: @escaping () -> (), onFailure: @escaping (_ error: Error?) -> ()) {
        let url = "\(baseUrl)users/\(id)"
        
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(url, method: .delete, headers: headers).validate(statusCode: statusOk).response { response in
            if let error = response.error {
                onFailure(error)
            } else {
                onSuccess()
            }
        }
    }
    
}
