//
//  ConverterProvider.swift
//  Converter
//
//  Created by Vlad Kulakovsky  on 15.12.22.
//

import Foundation
import Moya

typealias ArrayResponse<T: Decodable> = (([T]) -> Void)
typealias ObjectResponse<T: Decodable> = ((T) -> Void)
typealias Error = ((String) -> Void)

final class ConverterProvider {
    private let provider = MoyaProvider<ConverterAPI>(plugins: [NetworkLoggerPlugin()])
    
    func getCurrency(succed: @escaping ArrayResponse<Currency>, failure: @escaping Error) {
        provider.request(.getCurrency) { result in
            switch result {
                case .success(let response):
                    guard let currency = try? JSONDecoder().decode([Currency].self, from: response.data) else { return }
                    succed(currency)
                case .failure(let error):
                    failure(error.localizedDescription)
            }
        }
    }
}
