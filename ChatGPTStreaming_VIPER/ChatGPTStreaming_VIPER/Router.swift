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
        let view = RootViewController()
        let presenter = Presenter()
        view.presenter = presenter
        return view
    }
    
}
