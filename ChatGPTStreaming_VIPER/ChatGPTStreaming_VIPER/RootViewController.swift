//
//  ViewController.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 28/11/2023.
//

import UIKit

protocol AnyView: AnyObject {
    var presenter: AnyPresenter? { get set }
}

class RootViewController: UIViewController, AnyView {
    
    var presenter: AnyPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .red
        
        presenter?.onDeveloperTest()
    }

}

