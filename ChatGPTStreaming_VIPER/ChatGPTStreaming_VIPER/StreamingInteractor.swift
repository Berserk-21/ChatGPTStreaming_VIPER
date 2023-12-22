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
    private let parsingInteractor: ParsingInteractorInterface
    
    init(parsingInteractor: ParsingInteractorInterface = ParsingInteractor()) {
        self.parsingInteractor = parsingInteractor
        super.init()
    }
    
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
        
        let model = getModel()
        let role = getRole()
                
        let requestData: [String: Any] = [
            "model": model,
            "messages": [
                ["role": "system", "content": role],
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
        
        parsingInteractor.parseStreaming(data: data) { result in
            switch result {
            case .success(let string):
                completionHandler?(.success(string))
            case .failure(let error):
                completionHandler?(.failure(error))
            }
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        if error != nil {
            completionHandler?(.failure(StreamingError.didCompleteWithError))
        }
        
        completionHandler = nil
    }
    
    // MARK: - Helper Methods
    
    /// Use this method to get the config plist containing the openai api key.
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
    
    /// Use this method to get the chat gpt model used in the streaming request.
    private func getModel() -> String {
        
        if let modelType: Int = UserDefaults.standard.value(forKey: SettingsConstants.UserDefaults.gptModelKey) as? Int, let modelName = GPTModel(rawValue: modelType)?.description {
            return modelName
        } else {
            return GPTModel.gpt3.description
        }
    }
    
    /// Use this method to get the chat gpt role used in the streaming request.
    private func getRole() -> String {
        if let roleType = UserDefaults.standard.value(forKey: SettingsConstants.UserDefaults.gptRoleKey) as? Int, let roleDescription = GPTRole(rawValue: roleType)?.description {
            return roleDescription
        } else {
            return GPTRole.shakespeare.description
        }
    }
}
