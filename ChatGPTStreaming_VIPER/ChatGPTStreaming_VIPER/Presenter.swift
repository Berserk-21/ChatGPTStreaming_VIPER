//
//  Presenter.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 28/11/2023.
//

import Foundation

protocol AnyPresenter: AnyObject {
    var view: AnyView? { get set }
    func onTextFieldShouldReturn(text: String)
}

class Presenter: AnyPresenter {
    
    var view: AnyView?
    
    func onTextFieldShouldReturn(text: String) {
        print("text: ",text)
    }
    
}
