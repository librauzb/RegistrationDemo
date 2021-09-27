//
//  Constants.swift
//  RegistrationDemo
//
//  Created by Ulmasbek on 2021/09/27.
//

import UIKit

public let windowWidth = UIScreen.main.bounds.width
public let windowHeight = UIScreen.main.bounds.height

enum Currency : Int {
    case uzs
    case usd
    case rub
    
    func name() -> String {
        switch self {
        case .rub : return " RUB"
        case .uzs : return " UZS"
        case .usd : return " USD"
        }
    }
    
}

enum UNISTREAMOPERATIONTYPE {
    case PHONE
    case CARD
}
