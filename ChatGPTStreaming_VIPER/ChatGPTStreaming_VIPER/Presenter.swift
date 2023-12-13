//
//  Presenter.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 28/11/2023.
//

import Foundation

protocol AnyPresenter {
    func onTextFieldShouldReturn(text: String)
    func didTapRightBarButton()
}

final class Presenter: AnyPresenter {

    private let router: AnyRouter
    private let streamingInteractor: StreamingInteractorInterface
    private let fluidWritingInteractor: FluidWritingInteractorInterface
    
    weak var view: AnyView?
    
    init(router: AnyRouter, streamingInteractor: StreamingInteractorInterface, fluidWritingInteractor: FluidWritingInteractorInterface) {
        self.router = router
        self.streamingInteractor = streamingInteractor
        self.fluidWritingInteractor = fluidWritingInteractor
    }
    
    func onTextFieldShouldReturn(text: String) {
        
        streamingInteractor.startStreaming(for: text) { [weak self] result in
            switch result {
            case .success(let string):
                self?.fluidWritingInteractor.addToQueue(string: string, completion: { string in
                    self?.view?.updateStreamedAnswer(string: string)
                })
            case .failure(_):
                break
            }
        }
    }
    
    
    func didTapRightBarButton() {
        if let navController = view?.viewController.navigationController {
            router.pushToNextModule(on: navController)
        }
    }
}
