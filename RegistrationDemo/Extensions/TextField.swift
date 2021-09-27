//
//  TextField.swift
//  RegistrationDemo
//
//  Created by Ulmasbek on 2021/09/27.
//

import UIKit

extension UITextField{
    
    func setPlaceHolder(_ placeHolder: String) {
        let firstRange = (placeHolder as NSString).range(of: placeHolder)
        let attributedPlacholder = NSMutableAttributedString(string:placeHolder)
        attributedPlacholder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray , range: firstRange)
        self.attributedPlaceholder = attributedPlacholder
    }
    
}
