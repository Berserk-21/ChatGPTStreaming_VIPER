//
//  SettingsPresenter.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 12/12/2023.
//

import Foundation
import UIKit

protocol SettingsPresenterInterface {
    var settingsTableViewCellInteractor: SettingsTableViewCellInteractor { get }
}

class SettingsPresenter: SettingsPresenterInterface {
    
    let settingsTableViewCellInteractor: SettingsTableViewCellInteractor
    
    init(settingsTableViewCellInteractor: SettingsTableViewCellInteractor) {
        self.settingsTableViewCellInteractor = settingsTableViewCellInteractor
    }
    
}

