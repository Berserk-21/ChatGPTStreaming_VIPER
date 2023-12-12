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
        
        let streamingInteractor = StreamingInteractor()
        let fluidWritingInteractor = FluidWritingInteractor()
        let router = Router()
        
        let presenter = Presenter(router: router, streamingInteractor: streamingInteractor, fluidWritingInteractor: fluidWritingInteractor)
        
        let view = RootViewController(presenter: presenter)
        presenter.view = view

        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
    
}
