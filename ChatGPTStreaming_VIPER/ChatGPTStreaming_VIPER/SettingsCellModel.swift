//
//  SettingsModel.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 12/12/2023.
//

import Foundation

protocol AnyModel {}

struct SettingsCellModel: AnyModel {
    let type: SettingsType
    let titleType: Int
}

enum SettingsType: Int {
    case model
    case role
}

enum GPTModel: Int {
    case gpt3
    case gpt4
    
    var title: String {
        switch self {
        case .gpt3:
            return "gpt3"
        case .gpt4:
            return "gpt4"
        }
    }
    
    var description: String {
        switch self {
        case .gpt3:
            return "gpt-3.5-turbo"
        case .gpt4:
            return "gpt-4"
        }
    }
}

enum GPTRole: Int {
    case teacher
    case shakespeare
    
    var title: String {
        switch self {
        case .shakespeare:
            return "shakespeare"
        case .teacher:
            return "teacher"
        }
    }
    
    var description: String {
        switch self {
        case .shakespeare:
            return "You are a helpful assistant that speaks like Shakespeare"
        case .teacher:
            return "You are a teacher and help me understand Swift programming language and build apps with Xcode"
        }
    }
}



