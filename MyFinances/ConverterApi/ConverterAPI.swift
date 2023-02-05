//
//  ConverterAPI.swift
//  Converter
//
//  Created by Vlad Kulakovsky  on 15.12.22.
//

import Foundation
import Moya

enum ConverterAPI {
    case getCurrency
}

extension ConverterAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.nbrb.by/api/exrates/rates")!
    }
    
    var path: String {
        ""
    }
    
    var method: Moya.Method {
        switch self {
            case    .getCurrency: return .get
        }
    }
    
    var task: Moya.Task {
        guard let parameters else { return .requestPlain }
        
        return .requestParameters(parameters: parameters, encoding: encoding)
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var parameters: [String: Any]? {
        var params = [String: Any]()
        
        switch self {
            case .getCurrency:
                params["periodicity"] = 0
        }
        return params
    }
    
    var encoding: ParameterEncoding {
        switch self {
            case .getCurrency: return URLEncoding.queryString
        }
    }
}
