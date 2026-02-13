//
//  CoinRankingResponse.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 11/02/26.
//

import Foundation

struct CoinRankingResponse<T: Decodable>: Decodable {
    let status: String
    let data: T
}
