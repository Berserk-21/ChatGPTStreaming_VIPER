//
//  Presenter.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 28/11/2023.
//

import Foundation

protocol AnyPresenter {
    var view: AnyView? { get set }
    var router: AnyRouter? { get set }
    func onTextFieldShouldReturn(text: String)
}

class Presenter: AnyPresenter {

    var router: AnyRouter?
    var interactor: AnyInteractor?
    weak var view: AnyView?
    
    func onTextFieldShouldReturn(text: String) {
        
        interactor?.transform(string: text, completion: { [weak self] transformedText in
            self?.view?.didTransform(string: transformedText)
        })
    }
    
}
