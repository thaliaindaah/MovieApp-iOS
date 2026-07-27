//
//  Endpoint.swift
//  MovieApp
//
//  Created by Thalia Indah on 27/07/26.
//

import Foundation
import Alamofire

public protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var query: [URLQueryItem]? { get }
}

