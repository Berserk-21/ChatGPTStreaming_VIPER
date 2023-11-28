//
//  Presenter.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 28/11/2023.
//

import Foundation

protocol AnyPresenter {
    var view: AnyView? { get set }
    func onTextFieldShouldReturn(text: String)
    func didTransform(string: String)
}

class Presenter: AnyPresenter {

    var interactor: AnyInteractor?
    var view: AnyView?
    
    func onTextFieldShouldReturn(text: String) {
        
        interactor?.transform(string: text)
    }
    
    func didTransform(string: String) {
        
        view?.didTransform(string: string)
    }
    
}
