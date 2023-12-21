//
//  SettingsPresenter.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 12/12/2023.
//

import Foundation

protocol SettingsPresenterInterface {
    var dataSource: ListDataSourceInterface { get }
}

class SettingsPresenter: SettingsPresenterInterface {

    let dataSource: ListDataSourceInterface
    
    init(listDataSourceInteractor: SettingsDataSourceInteractor) {
        self.dataSource = listDataSourceInteractor
    }
}

