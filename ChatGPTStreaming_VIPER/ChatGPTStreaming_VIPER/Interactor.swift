//
//  Interactor.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 28/11/2023.
//

import Foundation

protocol AnyInteractor: AnyObject {
    func transform(string: String)
}

class Interactor: AnyInteractor {
    
    var presenter: AnyPresenter?
    
    func transform(string: String) {
        
        presenter?.didTransform(string: string.uppercased())
    }
}
