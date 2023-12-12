//
//  StreamingError.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 07/12/2023.
//

import Foundation

enum StreamingError: Error {
    case url
    case requestDataSerialization
    case response
    case APIKeyMissing
    case didCompleteWithError
    case streamingWillEnd
    case streamingIsOver
    case decodingError
}
