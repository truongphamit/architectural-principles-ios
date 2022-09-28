//
//  FlightApi.swift
//  ArchitecturalPrinciples
//
//  Created by Truong Pham on 21/09/2022.
//

import Foundation
import Combine

protocol FlightApi {
    func search(_ request: SearchTicketRequest) -> AnyPublisher<SearchTicketResponse, Error>
}

class FlightApiImpl: FlightApi {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func search(_ request: SearchTicketRequest) -> AnyPublisher<SearchTicketResponse, Error> {
        let enpoint = Endpoint(path: "searchOneDirectionTickets", method: .post, bodyParametersEncodable: request)
        return apiClient.run(enpoint)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    
}
