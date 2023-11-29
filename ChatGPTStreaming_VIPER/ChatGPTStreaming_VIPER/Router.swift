//
//  Router.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 28/11/2023.
//

import Foundation
import UIKit

protocol AnyRouter {
    func start() -> UIViewController
}

class Router: AnyRouter {
    
    func start() -> UIViewController {
        
        let interactor = Interactor()
        let router = Router()
        
        let presenter = Presenter(router: router, interactor: interactor)
        
        let view = RootViewController(presenter: presenter)
        presenter.view = view

        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
    
}
