//
//  APIClient.swift
//  MovieApp
//
//  Created by Thalia Indah on 27/07/26.
//

import Foundation
import Combine
import Alamofire

protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: String, parameters: Parameters?) -> AnyPublisher<T, Error>
}

final class APIClient: APIClientProtocol {
    func request<T>(_ endpoint: String, parameters: Alamofire.Parameters?) -> AnyPublisher<T, any Error> where T : Decodable {
        Future <T, Error> { result in
            let baseURL: String = "https://api.themoviedb.org/3"
            let bearerToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNmU5YzBlZmRlZmU4NDU0NDFlNDBjMDU5ZjBjNzEyMyIsIm5iZiI6MTc4NDc5OTMzNi4yMTUwMDAyLCJzdWIiOiI2YTYxZTA2ODVkYjBhNTEwZjVmYTg0MzMiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.KaHPGklzlNieRI1kEbKsG7jrfp64LoCDxHcG6DlWi4Y"
            
            let headers: HTTPHeaders = [
                "Authorization" : "Bearer \(bearerToken)"
            ]
            AF.request(
                baseURL + endpoint,
                method: .get,
                parameters: parameters,
                headers: headers
            )
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    result(.success(data))
                case .failure(let error):
                    result(.failure(error))
                
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
