//
//  SearchTicketRequest.swift
//  ArchitecturalPrinciples
//
//  Created by Truong Pham on 28/09/2022.
//

struct SearchTicketRequest: Codable {
    var waitFor: String?
    var fromAirport: String?
    var toAirport: String?
    var depart: String?
    var numAdults: Int?
    var numChilds: Int?
    var numInfants: Int?
    var oneWay: Bool?
    var currency: String?
    var lang: String?
    var sort: String?
    
    enum CodingKeys: String, CodingKey {
        case waitFor
        case fromAirport = "from_airport"
        case toAirport = "to_airport"
        case depart
        case numAdults = "num_adults"
        case numChilds = "num_childs"
        case numInfants = "num_infants"
        case oneWay = "one_way"
        case currency, lang, sort
    }
}

