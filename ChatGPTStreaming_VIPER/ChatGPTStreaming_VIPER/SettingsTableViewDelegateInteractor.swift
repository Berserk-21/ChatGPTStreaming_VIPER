//
//  SettingsTableViewDelegateInteractor.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 13/12/2023.
//

import Foundation

protocol SettingsTableViewDelegateInterface {
    
    func didSelectRowAt(indexPath: IndexPath)
}

class SettingsTableViewDelegateInteractor: SettingsTableViewDelegateInterface {
    
    func didSelectRowAt(indexPath: IndexPath) {
        print("did Select row \(indexPath.row)")
    }
}
