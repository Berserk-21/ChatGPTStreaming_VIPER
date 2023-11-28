//
//  Interactor.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 28/11/2023.
//

import Foundation

protocol AnyInteractor: AnyObject {
    func transform(string: String, completion: @escaping (String) -> Void)
}

class Interactor: AnyInteractor {
    
    var presenter: AnyPresenter?
    
    func transform(string: String, completion: @escaping (String) -> Void) {
        
        let transformedString = string.uppercased()
        
        completion(transformedString)
    }
}