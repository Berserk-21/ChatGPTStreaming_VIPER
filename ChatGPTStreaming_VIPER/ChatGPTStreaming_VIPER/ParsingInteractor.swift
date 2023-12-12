//
//  ParsingInteractor.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 12/12/2023.
//

import Foundation

protocol ParsingInteractorInterface {
    func parseStreaming(data: Data, completion: (Result<String, Error>) -> Void)
}

final class ParsingInteractor: ParsingInteractorInterface {
    
    func parseStreaming(data: Data, completion: (Result<String, Error>) -> Void) {
        if let receivedString = String(data: data, encoding: .utf8) {
            let components = receivedString.components(separatedBy: "data: ")
            
            let cleanedComponents = components.map { component in
                var cleanedComponent = component
            
                if let endIndex = cleanedComponent.lastIndex(of: "}") {
                    let rangeToDelete = cleanedComponent.index(after: endIndex)..<cleanedComponent.endIndex
                    cleanedComponent.removeSubrange(rangeToDelete)
                }
                
                if let indexOfOpenBrace = cleanedComponent.firstIndex(of: "{") {
                    let rangeToDelete = cleanedComponent.startIndex..<indexOfOpenBrace
                    cleanedComponent.removeSubrange(rangeToDelete)
                }
                
                return cleanedComponent
            }
            
            cleanedComponents.forEach { component in
                
                if !component.isEmpty, let componentData = component.data(using: .utf8) {
                    
                    do {
                        let response = try JSONDecoder().decode(OpenAIStreamingJSON.self, from: componentData)
                        
                        if let finishReason = response.choices?[0].finish_reason, finishReason == "stop" {
                            completion(.failure(StreamingError.streamingWillEnd))
                            
                        } else if let answer = response.choices?[0].delta.content {
                            // Envoyer la réponse au presenter
                            completion(.success(answer))
                        }
                    } catch let error {
                        
                        if component.contains("[DONE]") {
                            print("Streaming is over.")
                            completion(.failure(StreamingError.streamingIsOver))
                        } else {
                            print("There was an error with this answer: \(component): \(error)")
                            completion(.failure(StreamingError.decodingError))
                        }
                    }
                }
            }
        }
    }
}
