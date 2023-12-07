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
    func pushToNextModule(from view: AnyView)
}

final class Router: AnyRouter {
    
    func getRootView() -> UIViewController {
        
        let interactor = Interactor()
        let router = Router()
        
        let presenter = Presenter(router: router, interactor: interactor)
        
        let view = RootViewController(presenter: presenter)
        presenter.view = view

        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
    
    func pushToNextModule(from view: AnyView) {
                
        let settingsVC = SettingsViewController()
        if let navigationController = (view as? UIViewController)?.navigationController {
            navigationController.pushViewController(settingsVC, animated: true)
        }
    }
}
