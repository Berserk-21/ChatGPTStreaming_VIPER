//
//  Presenter.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 28/11/2023.
//

import Foundation

protocol AnyPresenter {
    func onTextFieldShouldReturn(text: String)
}

final class Presenter: AnyPresenter {

    private let router: AnyRouter
    private let streamingInteractor: StreamingInteractorInterface
    
    weak var view: AnyView?
    
    init(router: AnyRouter, interactor: AnyInteractor, streamingInteractor: StreamingInteractorInterface) {
        self.router = router
        self.streamingInteractor = streamingInteractor
    }
    
    func onTextFieldShouldReturn(text: String) {
        
        streamingInteractor.startStreaming(for: text) { [weak self] result in
            switch result {
            case .success(let string):
                self?.view?.didTransform(string: string)
            case .failure(_):
                break
            }
        }
    }
}
