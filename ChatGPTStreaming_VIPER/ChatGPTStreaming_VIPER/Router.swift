//
//  Router.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 28/11/2023.
//

import Foundation

protocol AnyRouter {
    func start() -> RootViewController
}

class Router: AnyRouter {
    
    func start() -> RootViewController {
        
        let interactor = Interactor()
        let router = Router()
        
        let presenter = Presenter(router: router, interactor: interactor)
        
        let view = RootViewController(presenter: presenter)
        presenter.view = view

        return view
    }
    
}
