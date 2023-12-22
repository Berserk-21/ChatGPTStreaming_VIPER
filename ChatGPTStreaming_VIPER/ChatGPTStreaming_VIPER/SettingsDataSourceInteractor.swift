//
//  SettingsTableViewCellInteractor.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 12/12/2023.
//

import Foundation

// On fait un fichier séparé pour les protocol top niveau comme lui ?
protocol ListDataSourceInterface {
    func dataForItem(at indexPath: IndexPath) -> AnyModel?
    var numberOfRows: Int { get }
}

protocol SettingsDataSourceInterface: ListDataSourceInterface {
    func updateSettingsAt(indexPath: IndexPath, completion: (Bool) -> Void)
    func getSettingsModels(completion: (Bool) -> Void)
}

class SettingsDataSourceInteractor: SettingsDataSourceInterface {
    
    private var settingsModels: [SettingsCellModel] = []
    
    // MARK: - ListDataSourceInterface
    
    var numberOfRows: Int {
        return settingsModels.count
    }
    
    func dataForItem(at indexPath: IndexPath) -> AnyModel? {
                
        guard settingsModels.count > indexPath.row else { return nil }
        
        return settingsModels[indexPath.row]
    }
    
    // MARK: - SettingsDataSourceInterface
    
    func updateSettingsAt(indexPath: IndexPath, completion: (Bool) -> Void) {
        
        let currentModel = settingsModels[indexPath.row]
        
        updateUserDefaultsFor(model: currentModel)
        
        settingsModels = []
        getSettingsModels { success in
            completion(success)
        }
    }
    
    func getSettingsModels(completion: (Bool) -> Void) {
        
        guard settingsModels.isEmpty else {
            completion(false)
            return
        }
        
        settingsModels = [
            getModelFor(type: .model),
            getModelFor(type: .role)
        ]
        
        completion(true)
    }
    
    // MARK: - Helper Methods
    
    // Get or create a SettingsCellModel for a specified type.
    private func getModelFor(type: SettingsType) -> SettingsCellModel {
        
        let titleType: Int
        let userDefaults = UserDefaults.standard
        
        switch type {
        case .model:
            if let gptModel = userDefaults.object(forKey: SettingsConstants.UserDefaults.gptModelKey) as? Int {
                titleType = gptModel
            } else {
                // Default
                titleType = GPTModel.gpt3.rawValue
                userDefaults.setValue(GPTModel.gpt3.rawValue, forKey: SettingsConstants.UserDefaults.gptModelKey)
            }
            
            return SettingsCellModel(type: .model, titleType: titleType)
        case .role:
            if let gptRole = userDefaults.object(forKey: SettingsConstants.UserDefaults.gptRoleKey) as? Int {
                titleType = gptRole
            } else {
                // Default
                titleType = GPTRole.teacher.rawValue
                userDefaults.setValue(GPTRole.teacher.rawValue, forKey: SettingsConstants.UserDefaults.gptRoleKey)
            }
            
            return SettingsCellModel(type: .role, titleType: titleType)
        }
    }
    
    private func updateUserDefaultsFor(model: SettingsCellModel) {
        
        let userDefault = UserDefaults.standard
        
        var newValue: Int?
        let key: String
        
        switch model.type {
        case .model:
            
            key = SettingsConstants.UserDefaults.gptModelKey
            
            if model.titleType == GPTModel.gpt3.rawValue {
                newValue = GPTModel.gpt4.rawValue
            } else if model.titleType == GPTModel.gpt4.rawValue {
                newValue = GPTModel.gpt3.rawValue
            }
        case .role:
            
            key = SettingsConstants.UserDefaults.gptRoleKey

            if model.titleType == GPTRole.shakespeare.rawValue {
                newValue = GPTRole.teacher.rawValue
            } else if model.titleType == GPTRole.teacher.rawValue {
                newValue = GPTRole.shakespeare.rawValue
            }
        }
        
        if let unwrappedNewValue = newValue {
            userDefault.setValue(unwrappedNewValue, forKey: key)
        }
    }
}
