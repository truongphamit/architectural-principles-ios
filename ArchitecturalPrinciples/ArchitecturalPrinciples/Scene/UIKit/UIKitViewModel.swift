//
//  UIKitViewModel.swift
//  ArchitecturalPrinciples
//
//  Created by Truong Pham on 28/09/2022.
//

import Combine

final class UIKitViewModel {
    private var disposables = Set<AnyCancellable>()
    private let flightApi: FlightApi
    
    init(flightApi: FlightApi) {
        self.flightApi = flightApi
        searchTicket()
    }
    
    private func searchTicket() {
        let request = SearchTicketRequest(
            waitFor: nil,
            fromAirport: "HAN",
            toAirport: "SGN",
            depart: "17-11-2022",
            numAdults: 1,
            numChilds: 0,
            numInfants: 0,
            oneWay: true,
            currency: "VND",
            lang: "vi",
            sort: nil
        )
        self.flightApi.search(request)
            .sink {
                print($0)
            } receiveValue: {
                print($0)
            }
            .store(in: &disposables)
    }
}
