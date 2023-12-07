//
//  Presenter.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 28/11/2023.
//

import Foundation
import UIKit

protocol AnyPresenter {
    func onTextFieldShouldReturn(text: String)
    func didTapRightBarButton()
}

final class Presenter: AnyPresenter {

    private let router: AnyRouter
    private let interactor: AnyInteractor
    
    weak var view: AnyView?
    
    init(router: AnyRouter, interactor: AnyInteractor) {
        self.router = router
        self.interactor = interactor
    }
    
    func onTextFieldShouldReturn(text: String) {
        
        interactor.transform(string: text, completion: { [weak self] transformedText in
            self?.view?.didTransform(string: transformedText)
        })
    }
    
    func didTapRightBarButton() {
        if let viewController = view as? UIViewController {
            router.pushToNextModule(from: viewController)
        }
    }
}
