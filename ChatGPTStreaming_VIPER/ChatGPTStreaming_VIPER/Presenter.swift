//
//  Presenter.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 28/11/2023.
//

import Foundation

protocol AnyPresenter: AnyObject {
    var view: AnyView? { get set }
    func onDeveloperTest()
}

class Presenter: AnyPresenter {
    
    var view: AnyView?
    
    func onDeveloperTest() {
        print("onDeveloperTest is running")
    }
}
