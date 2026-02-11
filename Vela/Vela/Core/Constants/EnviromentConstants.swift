//
//  EnviromentConstants.swift
//  Vela
//
//  Created by Manuel Alejandro Hernandez Marín on 10/02/26.
//

import Foundation

enum Environment {
    static let coinRankingAPIKey = Bundle.main.object(
        forInfoDictionaryKey: "COIN_RANKING_API_KEY"
    ) as? String ?? ""
}
