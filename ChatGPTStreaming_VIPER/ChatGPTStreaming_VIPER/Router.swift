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
        let router = Router()
        
        let presenter = Presenter(router: router, interactor: interactor)
        
        presenter.interactor = interactor
        presenter.router = router
        
        let view = RootViewController()
        view.presenter = presenter
        presenter.view = view

        return view
    }
    
}
