//
//  ViewController.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 28/11/2023.
//

import UIKit

protocol AnyView: AnyObject {
    func didTransform(string: String)
}

class RootViewController: UIViewController, AnyView, UITextFieldDelegate {
    
    // MARK: - Properties
    
    var presenter: AnyPresenter
    
    private let padding: CGFloat = 24.0
    
    private let answerTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Bonjour, que puis-je faire pour vous ?"
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let questionTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Poser une question à chatGPT.."
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    init(presenter: AnyPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupLayout()
        
        questionTextField.delegate = self
    }
    
    // MARK: - Setup Layout
    
    private func setupLayout() {
        
        view.backgroundColor = .lightGray
        
        view.addSubview(questionTextField)
        view.addSubview(answerTextView)

        let constraints: [NSLayoutConstraint] = [
            questionTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            questionTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            questionTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            answerTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            answerTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            answerTextView.topAnchor.constraint(equalTo: questionTextField.bottomAnchor, constant: padding),
            answerTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let text = textField.text, !text.isEmpty {
            presenter.onTextFieldShouldReturn(text: text)
        }
        
        return true
    }
    
    // MARK: - AnyView
    
    func didTransform(string: String) {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                self.answerTextView.text = string
            }
        } else {
            self.answerTextView.text = string
        }
    }
    
}

