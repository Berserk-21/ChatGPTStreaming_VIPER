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
    func pushToNextModule(on navigationController: UINavigationController)
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
    
    func pushToNextModule(on navigationController: UINavigationController) {
        
        let settingsPresenter = SettingsPresenter(settingsTableViewDataSourceInteractor: SettingsTableViewDataSourceInteractor(), settingsTableViewDelegateInteractor: SettingsTableViewDelegateInteractor())
        let settingsVC = SettingsViewController(presenter: settingsPresenter)
        navigationController.pushViewController(settingsVC, animated: true)
    }
}
