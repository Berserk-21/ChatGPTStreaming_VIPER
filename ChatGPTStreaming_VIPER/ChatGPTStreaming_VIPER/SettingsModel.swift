//
//  SettingsModel.swift
//  ChatGPTStreaming_VIPER
//
//  Created by Berserk on 12/12/2023.
//

import Foundation


// Je ne sais pas si ce niveau d'abstraction est nécessaire ?
protocol AnyModel {
    
}

struct SettingsModel: AnyModel {
    let title: String
}


