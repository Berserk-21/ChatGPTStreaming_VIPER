//
//  SettingsPresenter.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 12/12/2023.
//

import Foundation
import UIKit

protocol SettingsPresenterInterface {
    var settingsTableViewDataSourceInteractor: SettingsTableViewDataSourceInteractor { get }
    func didSelectRowAt(indexPath: IndexPath)
}

class SettingsPresenter: SettingsPresenterInterface {

    let settingsTableViewDataSourceInteractor: SettingsTableViewDataSourceInteractor
    
    let settingsTableViewDelegateInteractor: SettingsTableViewDelegateInteractor
    
    init(settingsTableViewDataSourceInteractor: SettingsTableViewDataSourceInteractor, settingsTableViewDelegateInteractor: SettingsTableViewDelegateInteractor) {
        self.settingsTableViewDataSourceInteractor = settingsTableViewDataSourceInteractor
        self.settingsTableViewDelegateInteractor = settingsTableViewDelegateInteractor
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        settingsTableViewDelegateInteractor.didSelectRowAt(indexPath: indexPath)
    }
    
}

