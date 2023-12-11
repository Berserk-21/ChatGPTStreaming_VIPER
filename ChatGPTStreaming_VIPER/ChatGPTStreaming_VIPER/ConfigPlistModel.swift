//
//  ConfigPlistModel.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 07/12/2023.
//

import Foundation

struct ConfigPlistModel: Decodable {
    
    let apiKey: String
    
    private enum CodingKeys: String, CodingKey {
        case apiKey = "OPENAI_API_KEY"
    }
}
