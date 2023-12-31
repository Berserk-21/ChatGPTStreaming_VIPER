//
//  ViewController.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 28/11/2023.
//

import UIKit

protocol AnyView: AnyObject {
    var viewController: UIViewController { get }
    func updateStreamedAnswer(string: String)
}

final class RootViewController: UIViewController, AnyView, UITextFieldDelegate {
    
    var viewController: UIViewController { return self }
    
    // MARK: - Properties
    
    private enum Constants {
        static let padding: CGFloat = 24.0
    }
    
    private let presenter: AnyPresenter
    
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
    
    // MARK: - Life Cycle
    
    init(presenter: AnyPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupLayout()
        setupRightBarButton()
        
        questionTextField.delegate = self
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        
        view.backgroundColor = .lightGray
        
        view.addSubview(questionTextField)
        view.addSubview(answerTextView)

        let constraints: [NSLayoutConstraint] = [
            questionTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.padding),
            questionTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            questionTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.padding),
            answerTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.padding),
            answerTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.padding),
            answerTextView.topAnchor.constraint(equalTo: questionTextField.bottomAnchor, constant: Constants.padding),
            answerTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.padding)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupRightBarButton() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(didTapRightBarButton))
    }
    
    // MARK: - Actions
    
    @objc private func didTapRightBarButton() {
        
        presenter.didTapRightBarButton()
    }
    
    // MARK: - UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let text = textField.text, !text.isEmpty {
            self.answerTextView.text = ""
            presenter.onTextFieldShouldReturn(text: text)
        }
        
        return true
    }
    
    // MARK: - AnyView
    
    func updateStreamedAnswer(string: String) {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                self.answerTextView.text += string
            }
        } else {
            self.answerTextView.text += string
        }
    }
    
}

