//
//  DataNetwork.swift
//  Cek Ongkir
//
//  Created by Muhammad Arif Hidayatulloh on 18/02/20.
//  Copyright © 2020 PT Goalkes Indonesia Jaya. All rights reserved.
//

import Foundation
import Moya

enum DataNetwork {
    case province
    case city(province:String)
    case cost(origin:String, destination: String, weight: String, courier: String)
}

private var key = "0df6d5bf733214af6c6644eb8717c92c"
private var base_url = "https://api.rajaongkir.com"

extension DataNetwork : TargetType {
    var baseURL: URL {
        return URL(string: base_url)!
    }
    
    var path: String {
        switch self {
        case .province:
            return "/starter/province"
        case .city:
            return "/starter/city"
        case .cost:
            return "/starter/cost"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .cost:
            return .post
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .city(let province):
            return "{\"province\": \"\(province)\"}".utf8Encoded
        case .cost(let origin, let destination, let weight, let courier):
            return "{\"origin\": \"\(origin)\", destination\": \"\(destination)\", weight\": \"\(weight)\", courier\": \"\(courier)\"}".utf8Encoded
        default:
            return "".utf8Encoded
        }
    }
    
    var task: Task {
        switch self {
        case let .city(province):
            return .requestParameters(parameters: ["province":province], encoding: URLEncoding.queryString)
        case let .cost(origin, destination, weight, courier):
            return .requestParameters(parameters: ["origin":origin, "destination":destination, "weight":weight, "courier":courier], encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var httpHeaders: [String: String] = [:]
        httpHeaders["Key"] = key
        return httpHeaders

    }
    
}

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

