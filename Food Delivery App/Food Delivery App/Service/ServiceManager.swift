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
            return }
        
        AF.request(url,encoding: JSONEncoding.default).validate().responseDecodable(of:T.self) { response in
            
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func post<T: Codable>(urlString: String,params: [String: Any], completion: @escaping(Result<T, Error>) ->())
    {
        AF.request(urlString,method: .post,parameters: params).response { response in
            let decoder = JSONDecoder()
            if let data = response.data {
                do{
                    let cevap = try decoder.decode(T.self, from: data)
                    completion(.success(cevap))
                } catch{
                    completion(.failure(error))
                }
            }
            
        }
    }
}
