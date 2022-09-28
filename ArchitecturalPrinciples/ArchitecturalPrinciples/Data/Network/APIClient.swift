//
//  APIClient.swift
//  ArchitecturalPrinciples
//
//  Created by Truong Pham on 20/09/2022.
//

import Foundation
import Combine

struct APIClient {
    
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    let baseUrl: String
    
    let decoder: JSONDecoder
    
    let interceptors : [Interceptor]
    
    init(baseUrl: String, decoder: JSONDecoder, interceptors: [Interceptor] = []) {
        self.baseUrl = baseUrl
        self.decoder = decoder
        self.interceptors = interceptors
    }
    
    func run<T: Decodable>(_ enpoint: Endpoint) -> AnyPublisher<Response<T>, Error> {
        do {
            let request = try enpoint.urlRequest(with: baseUrl)
            interceptors.forEach { interceptor in
                interceptor.interceptRequest(request)
            }
            return URLSession.shared
                .dataTaskPublisher(for: request)
                .tryMap { result -> Response<T> in
                    interceptors.forEach { interceptor in
                        interceptor.interceptResponse(result.data, response: result.response, error: nil)
                    }
                    let value = try decoder.decode(T.self, from: result.data)
                    return Response(value: value, response: result.response)
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
}
