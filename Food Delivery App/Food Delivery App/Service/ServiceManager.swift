//
//  ServiceManager.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 22.11.2023.
//

import Foundation
import Alamofire

final class ServiceManager {
    static let shared = ServiceManager()
    
    private init() { }
    
    func fetchRequest<T: Decodable>(urlString: String, completion: @escaping(Result<T, AFError>) ->()) {
     
        guard let url = URL(string: urlString) else {
            completion(.failure(AFError.invalidURL(url: urlString)))
            return}
        
        AF.request(url,encoding: JSONEncoding.default).validate().responseDecodable(of:T.self) { response in
            
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure.localizedDescription as! Error as! AFError))
            }
            
        }
    }
    
}
