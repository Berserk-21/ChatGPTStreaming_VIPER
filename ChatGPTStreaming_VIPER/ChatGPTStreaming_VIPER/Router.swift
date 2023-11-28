//
//  Router.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 28/11/2023.
//

import Foundation

protocol AnyRouter {
    static func start() -> RootViewController
}

class Router: AnyRouter {
    
    static func start() -> RootViewController {
        
        let interactor = Interactor()
        let presenter = Presenter()
        let router = Router()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        
        let view = RootViewController()
        view.presenter = presenter
        presenter.view = view

        return view
    }
    
}
