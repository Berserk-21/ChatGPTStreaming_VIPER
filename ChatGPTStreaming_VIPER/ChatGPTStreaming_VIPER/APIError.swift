//
//  APIError.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 07/12/2023.
//

import Foundation

enum APIError: Error {
    case url
    case requestDataSerialization
    case response
    case APIKeyMissing
    case didCompleteWithError
}
