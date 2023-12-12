//
//  GPTRequestData.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 12/12/2023.
//

import Foundation

enum GPTModel: String {
    case gpt3 = "gpt-3.5-turbo"
    case gpt4 = "gpt-4"
    
    var modelName: String {
        return self.rawValue
    }
}

enum GPTRole: String {
    case teacher = "You are a teacher and help me understand Swift programming language and build apps with xCode"
    case shakespeare = "You are a helpful assistant that speaks like Shakespeare"
    
    var content: String {
        return self.rawValue
    }
}
