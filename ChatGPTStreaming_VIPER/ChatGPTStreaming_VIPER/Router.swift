//
//  Router.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 28/11/2023.
//

import Foundation
import UIKit

protocol AnyRouter {
    func getRootView() -> UIViewController
}

final class Router: AnyRouter {
    
    func getRootView() -> UIViewController {
        
        let interactor = Interactor()
        let streamingInteractor = StreamingInteractor()
        let router = Router()
        
        let presenter = Presenter(router: router, interactor: interactor, streamingInteractor: streamingInteractor)
        
        let view = RootViewController(presenter: presenter)
        presenter.view = view

        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
    
}
