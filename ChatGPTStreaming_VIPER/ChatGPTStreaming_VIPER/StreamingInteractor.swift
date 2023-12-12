//
//  ChatGPTInteractor.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 07/12/2023.
//

import Foundation

protocol StreamingInteractorInterface: AnyObject {
    func startStreaming(for input: String, completionHandler: @escaping (Result<String, Error>) -> Void)
}

final class StreamingInteractor: NSObject, StreamingInteractorInterface, URLSessionDataDelegate {
    
    private var completionHandler: ((Result<String, Error>) -> Void)?
    private var urlSession: URLSession?
    
    func startStreaming(for input: String, completionHandler: @escaping (Result<String, Error>) -> Void) {
        
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            completionHandler(.failure(StreamingError.url))
            return
        }
        
        guard let configPlist = getConfigPlist() else {
            completionHandler(.failure(StreamingError.APIKeyMissing))
            return
        }
        
        if urlSession == nil {
            urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        }
                
        let requestData: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "system", "content": "You are a helpful assistant and you answer in french."],
                ["role": "user", "content": input]
            ],
            "stream": true
        ]
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(configPlist.apiKey)", forHTTPHeaderField: "Authorization")
        
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: requestData)
        } catch {
            completionHandler(.failure(StreamingError.requestDataSerialization))
        }
        
        self.completionHandler = completionHandler
        
        let task = urlSession?.dataTask(with: urlRequest)
        
        task?.resume()
    }
    
    // MARK: - URLSessionDataDelegate
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        return .allow
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
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
                            print("Streaming will stop")
                        } else if let answer = response.choices?[0].delta.content {
                            // Envoyer la réponse au presenter
                            completionHandler?(.success(answer))
                        }
                    } catch let error {
                        
                        if component.contains("[DONE]") {
                            print("Streaming is done.")
                        } else {
                            print("There was an error with this answer: \(component)")
                            print(String(describing: error))
                        }
                    }
                }
            }
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        if error != nil {
            completionHandler?(.failure(StreamingError.didCompleteWithError))
        }
        
        completionHandler = nil
    }
    
    // Helper Methods
    
    private func getConfigPlist() -> ConfigPlistModel? {
        
        guard let configUrl = Bundle.main.url(forResource: "Config", withExtension: "plist") else { return nil }
        
        do {
            let data = try Data(contentsOf: configUrl)
            let configPlist = try PropertyListDecoder().decode(ConfigPlistModel.self, from: data)
            return configPlist
        } catch let err {
            print("There was an error getting the Config.plist: \(err.localizedDescription)")
        }
        
        return nil
    }
}
