//
//  CoinCapEndpoint.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 10/02/26.
//

import Foundation

enum CoinRankingEndpoint: Endpoint {
    case coins(limit: Int, offset: Int)
    case coin(uuid: String)
    case coinHistory(uuid: String, period: TimePeriod)
    
    var path: String {
        switch self {
        case .coins:
            return "/v2/coins"
        case .coin(let uuid):
            return "/v2/coin/\(uuid)"
        case .coinHistory(let uuid, _):
            return "/v2/coin/\(uuid)/history"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String: String]? {
        switch self {
        case .coins(let limit, let offset):
            return [
                "limit": "\(limit)",
                "offset": "\(offset)"
            ]
        case .coinHistory(_, let period):
            return [
                "timePeriod": period.rawValue
            ]
        default:
            return nil
        }
    }
}

enum TimePeriod : String {
    case h24 = "24h"
    case d7  = "7d"
    case d30 = "30d"
    case d90 = "90d"
    case y1  = "1y"
    case y3  = "3y"
    case y5  = "5y"
}
