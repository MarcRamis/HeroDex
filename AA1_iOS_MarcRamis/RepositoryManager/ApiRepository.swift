//
//  ApiRepository.swift
//  AA1_iOS_MarcRamis
//
//  Created by Marc Ramis on 28/4/23.
//

import Foundation
import CryptoKit

class Api{
    
    static let Marvel: MarvelRepository = MarvelRepository()
    
    static func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
}

