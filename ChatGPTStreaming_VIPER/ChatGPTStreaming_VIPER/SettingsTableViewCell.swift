//
//  SettingsTableViewCell.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 12/12/2023.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let padding: CGFloat = 16.0
    
    static let identifier: String = "SettingsTableViewCell"
    
    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Layout
    
    private func setupConstraints() {
        
        addSubview(titleLabel)
        
        let constraints: [NSLayoutConstraint] =
        [
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: padding),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -padding),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Custom Methods
    
    func configure(with model: AnyModel) {
        
        if let settingsModel = model as? SettingsCellModel {
            
            let titleString: String = settingsModel.type == .model ? "model" : "role"
            var contentString: String?
            
            switch settingsModel.type {
            case .model:
                if let title = GPTModel(rawValue: settingsModel.titleType)?.title {
                    contentString = title
                }
            case .role:
                if let title = GPTRole(rawValue: settingsModel.titleType)?.title {
                    contentString = title
                }
            }
            
            if let unwrappedContentString = contentString {
                let title = NSAttributedString(string: titleString + ": ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0, weight: .medium)])
                            
                let content = NSAttributedString(string: unwrappedContentString, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0, weight: .regular)])
                
                let mutableAttributedText = NSMutableAttributedString(attributedString: title)
                mutableAttributedText.append(content)
                
                titleLabel.attributedText = mutableAttributedText
            }
        }
    }
}
