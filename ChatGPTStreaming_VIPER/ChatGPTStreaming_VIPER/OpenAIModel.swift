//
//  OpenAIModel.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 07/12/2023.
//

import Foundation

struct OpenAIStreamingJSON: Decodable {
    var id: String?
    var object: String
    var created: Int
    var model: String
    var choices: [StreamingChoice]?
}

struct StreamingChoice: Decodable {
    let delta: StreamingDelta?
    let finish_reason: String?
    let index: Int?
}

struct StreamingDelta: Decodable {
    let content: String?
}

