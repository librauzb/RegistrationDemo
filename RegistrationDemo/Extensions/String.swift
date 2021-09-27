//
//  String.swift
//  RegistrationDemo
//
//  Created by Ulmasbek on 2021/09/27.
//

import UIKit

extension String{
    
    public func convertToDictionary(_ text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    public func getDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return Date()
        }
    }
    
    public func getCurrentDate(_ withTime:Bool = false) -> String {
        let curDate: Date = Date()
        let dateFormatter = DateFormatter()
        if withTime {
            dateFormatter.dateFormat = "yyyy-MM-dd-hh:mm"
            return   String(dateFormatter.string(from: curDate).prefix(10)) + "/" + String(dateFormatter.string(from: curDate).prefix(16)).suffix(5)
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return   String(dateFormatter.string(from: curDate))
        }
    }
    
    public func getPervMonthDate(_ withTime:Bool = false) -> String {
        let curDate: Date = Date()
        let dateFormatter = DateFormatter()
        if withTime {
            dateFormatter.dateFormat = "yyyy-MM-dd-hh:mm"
            return   String(dateFormatter.string(from: curDate).prefix(10)) + "/" + String(dateFormatter.string(from: curDate).prefix(16)).suffix(5)
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return   String(dateFormatter.string(from: curDate))
        }
    }
    
    public func convertTodate() -> String{
        
        let isoDate = self
        var result  = ""
        if isoDate.count > 15 {
            result = String(isoDate.prefix(10)) + " / " + String(isoDate.prefix(16).suffix(5))
        }
        return result
    }
    
    public func toDate(_ withTime:Bool = false) -> String{
        let fulldate = self.prefix(16)
        let date = fulldate.prefix(10)
        return String(withTime ? ("\(date) / \(fulldate.suffix(5))") : date)
    }
    
    public func getTime(_ withSec:Bool = false) -> String{
        let fulldate = self.prefix(19)
        let date = fulldate.suffix(8)
        return String(withSec ? (date) : date.prefix(5))
    }
    
    public func prepareForFiltr() -> String {
        if self.count > 0{
            var string = self.trimmingCharacters(in: CharacterSet(charactersIn: " "))
            string.removeLast()
            return string
        } else {
            return ""
        }
    }
    
    public func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    public func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func modifyPhoneNumberString() -> String {
        let creditCardString : String = self
        let trimmedString = removeSpecialCharsFromPhone(text: creditCardString.components(separatedBy: .whitespaces).joined())
        
        let arrOfCharacters = Array(trimmedString)
        
        var modifiedCreditCardString = ""
        
        if(arrOfCharacters.count > 0)
        {
            for i in 0...arrOfCharacters.count-1
            {
                modifiedCreditCardString.append(arrOfCharacters[i])
                
                if(findTwoPointPhone(i: (i+1)) && i+1 != arrOfCharacters.count)
                {
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        if modifiedCreditCardString.count > 12 {
            while modifiedCreditCardString.count > 12 {
                modifiedCreditCardString.removeLast()
            }
        }
        return modifiedCreditCardString
    }
    
    func modifyPhoneNumberStringWhole() -> String {
        let creditCardString : String = self
        let trimmedString = (creditCardString.components(separatedBy: .whitespaces).joined()).removeSpecialCharsFromPhoneWhole()
        
        let arrOfCharacters = Array(trimmedString)
        
        var modifiedCreditCardString = ""
        
        if(arrOfCharacters.count > 0)
        {
            for i in 0...arrOfCharacters.count-1
            {
                modifiedCreditCardString.append(arrOfCharacters[i])
                
                if(findTwoPointPhoneWhole(i: (i+1)) && i+1 != arrOfCharacters.count)
                {
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        
        if modifiedCreditCardString.count > 17 {
            while modifiedCreditCardString.count > 17 {
                modifiedCreditCardString.removeLast()
            }
        }
        return modifiedCreditCardString
    }
    
    func modifyJustPhoneNumberStringWhole() -> String {
        let creditCardString : String = self
        let trimmedString = (creditCardString.components(separatedBy: .whitespaces).joined()).removeSpecialCharsFromPhoneWhole()
        
        let arrOfCharacters = Array(trimmedString)
        
        var modifiedCreditCardString = ""
        
        if(arrOfCharacters.count > 0)
        {
            for i in 0...arrOfCharacters.count-1
            {
                modifiedCreditCardString.append(arrOfCharacters[i])
                
                if(findTwoPointJustPhoneWhole(i: (i+1)) && i+1 != arrOfCharacters.count)
                {
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        
        if modifiedCreditCardString.count > 17 {
            while modifiedCreditCardString.count > 17 {
                modifiedCreditCardString.removeLast()
            }
        }
        return modifiedCreditCardString
    }
    
    func modifyMaskedPhoneNumberStringWhole() -> String {
        let creditCardString : String = self
        let trimmedString = removeSpecialCharsFromMaskedPhoneWhole(text: creditCardString.components(separatedBy: .whitespaces).joined())
        
        let arrOfCharacters = Array(trimmedString)
        
        var modifiedCreditCardString = ""
        
        if(arrOfCharacters.count > 0)
        {
            for i in 0...arrOfCharacters.count-1
            {
                modifiedCreditCardString.append(arrOfCharacters[i])
                
                if(findTwoPointPhoneWhole(i: (i+1)) && i+1 != arrOfCharacters.count)
                {
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        
        if modifiedCreditCardString.count > 17 {
            while modifiedCreditCardString.count > 17 {
                modifiedCreditCardString.removeLast()
            }
        }
        return modifiedCreditCardString
    }
    
    func modifyCreditCardString() -> String {
        let creditCardString : String = self
        let trimmedString = removeSpecialCharsFromString(text: creditCardString.components(separatedBy: .whitespaces).joined())
        
        let arrOfCharacters = Array(trimmedString)
        
        var modifiedCreditCardString = ""
        
        if(arrOfCharacters.count > 0)
        {
            for i in 0...arrOfCharacters.count-1
            {
                modifiedCreditCardString.append(arrOfCharacters[i])
                
                if(findTwoPoint(i: (i+1)) && i+1 != arrOfCharacters.count)
                {
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        
        if modifiedCreditCardString.count > 19 {
            while modifiedCreditCardString.count > 19 {
                modifiedCreditCardString.removeLast()
            }
        }
        return modifiedCreditCardString
    }
    
    func modifyCreditCardStringData(creditCardString : String) -> String {
        let trimmedString = creditCardString.components(separatedBy: .whitespaces).joined().removeSpecialCharsFromStringPan()
        
        let arrOfCharacters = Array(trimmedString)
        
        var modifiedCreditCardString = ""
        
        if(arrOfCharacters.count > 0)
        {
            for i in 0...arrOfCharacters.count-1
            {
                modifiedCreditCardString.append(arrOfCharacters[i])
                
                if(findTwoPoint(i: (i+1)) && i+1 != arrOfCharacters.count)
                {
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        
        if modifiedCreditCardString.count > 19 {
            while modifiedCreditCardString.count > 19 {
                modifiedCreditCardString.removeLast()
            }
        }
        return modifiedCreditCardString
    }
    
    func modifyCreditCardStringDataForPager(creditCardString : String) -> String {
        let trimmedString = creditCardString.components(separatedBy: .whitespaces).joined().removeSpecialCharsFromStringPan()
        
        let arrOfCharacters = Array(trimmedString)
        
        var modifiedCreditCardString = ""
        
        if(arrOfCharacters.count > 0)
        {
            for i in 0...arrOfCharacters.count-1
            {
                modifiedCreditCardString.append(arrOfCharacters[i])
                
                if(findTwoPoint(i: (i+1)) && i+1 != arrOfCharacters.count)
                {
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        
        if modifiedCreditCardString.count > 19 {
            while modifiedCreditCardString.count > 19 {
                modifiedCreditCardString.removeLast()
            }
        }
        return modifiedCreditCardString
    }
    
    func modifyInnString() -> String {
        let innNumberString : String = self
        let trimmedString = removeSpecialCharsFromString(text: innNumberString.components(separatedBy: .whitespaces).joined())
        
        let arrOfCharacters = Array(trimmedString)
        
        var modifiedInnNumberString = ""
        
        if(arrOfCharacters.count > 0)
        {
            for i in 0...arrOfCharacters.count-1
            {
                modifiedInnNumberString.append(arrOfCharacters[i])
                
                
            }
        }
        
        if modifiedInnNumberString.count > 9 {
            while modifiedInnNumberString.count > 9 {
                modifiedInnNumberString.removeLast()
            }
        }
        return modifiedInnNumberString
    }
    
    func modifySummeryEntering(_ creditCardString : String) -> String {
        var trimmedString = removeSpecialCharsFromString(text: creditCardString.components(separatedBy: .whitespaces).joined())
        
        if trimmedString.count > 10 {
            while trimmedString.count > 10 {
                trimmedString.removeLast()
            }
        }
        if trimmedString.count > 0 {
            if nil == Double(trimmedString){
                trimmedString = ""
            }
        }
        let arrOfCharacters = Array(trimmedString)
        var modifiedCreditCardString = ""
        
        if(arrOfCharacters.count > 0)
        {
            
            for i in (0 ... (arrOfCharacters.count - 1)).reversed()
            {
                modifiedCreditCardString.append(arrOfCharacters[i])
            }
            
            let arrOfCharacterss = Array(modifiedCreditCardString)
            modifiedCreditCardString = ""
            for i in (0 ... (arrOfCharacterss.count - 1))
            {
                modifiedCreditCardString.append(arrOfCharacterss[i])
                
                if(findTwoPointSum(i: (i+1)) && i+1 != arrOfCharacterss.count)
                {
                    modifiedCreditCardString.append(" ")
                }
            }
            
            let arrOfCharactersss = Array(modifiedCreditCardString)
            modifiedCreditCardString = ""
            for i in (0 ... (arrOfCharactersss.count - 1)).reversed()
            {
                modifiedCreditCardString.append(arrOfCharactersss[i])
            }
            
        }
        
        return modifiedCreditCardString
    }
    
    func modifySummery() -> String {
        let creditCardString: String = self
        var trimmedString = removeSpecialCharsFromString(text: creditCardString.components(separatedBy: .whitespaces).joined())
        
        if trimmedString.count > 0{
            if nil == Double(trimmedString){
                trimmedString = ""
            }
        }
        let arrOfCharacters = Array(trimmedString)
        var modifiedCreditCardString = ""
        
        if(arrOfCharacters.count > 0)
        {
            
            for i in (0 ... (arrOfCharacters.count - 1)).reversed()
            {
                modifiedCreditCardString.append(arrOfCharacters[i])
            }
            
            let arrOfCharacterss = Array(modifiedCreditCardString)
            modifiedCreditCardString = ""
            for i in (0 ... (arrOfCharacterss.count - 1)){
                modifiedCreditCardString.append(arrOfCharacterss[i])
                
                if(findTwoPointSum(i: (i+1)) && i+1 != arrOfCharacterss.count)
                {
                    modifiedCreditCardString.append(" ")
                }
            }
            
            let arrOfCharactersss = Array(modifiedCreditCardString)
            modifiedCreditCardString = ""
            for i in (0 ... (arrOfCharactersss.count - 1)).reversed()
            {
                modifiedCreditCardString.append(arrOfCharactersss[i])
            }
        }
        return modifiedCreditCardString
    }
    
    func modifyBalance(_ creditCardString : String) -> String {
        let balance = creditCardString.components(separatedBy: .whitespaces).joined() //self.components(separatedBy: .whitespaces).joined()
        
        var trimmedString = balance
        var addition = ""
        if balance.contains(".") {
            let array = balance.split(separator: ".")
            trimmedString = String(array[0])
            addition = String(array[1])
        }
        if trimmedString.count > 0{
            if nil == Double(trimmedString){
                trimmedString = ""
            }
        }
        let arrOfCharacters = Array(trimmedString)
        var modifiedCreditCardString = ""
        
        if(arrOfCharacters.count > 0){
            for i in (0 ... (arrOfCharacters.count - 1)).reversed()
            {
                modifiedCreditCardString.append(arrOfCharacters[i])
            }
            
            let arrOfCharacterss = Array(modifiedCreditCardString)
            modifiedCreditCardString = ""
            for i in (0 ... (arrOfCharacterss.count - 1))
            {
                modifiedCreditCardString.append(arrOfCharacterss[i])
                
                if(findTwoPointSum(i: (i+1)) && i+1 != arrOfCharacterss.count)
                {
                    modifiedCreditCardString.append(" ")
                }
            }
            let arrOfCharactersss = Array(modifiedCreditCardString)
            modifiedCreditCardString = ""
            for i in (0 ... (arrOfCharactersss.count - 1)).reversed()
            {
                modifiedCreditCardString.append(arrOfCharactersss[i])
            }
        }
        return modifiedCreditCardString + ((addition.count > 0) ? ".\(addition)" : "")
    }
    
    func modifyExperyDateStringForPagerCell() -> String {
        let creditCardString : String = self
        var trimmedString = removeSpecialCharsFromString(text: creditCardString.components(separatedBy: .whitespaces).joined())
        
        trimmedString = String(trimmedString.reversed())
        
        let arrOfCharacters = Array(trimmedString)
        
        var modifiedCreditCardString = ""
        
        if(arrOfCharacters.count > 0)
        {
            for i in 0...arrOfCharacters.count-1
            {
                modifiedCreditCardString.append(arrOfCharacters[i])
                
                if((i+1)%2 == 0 && i+1 != arrOfCharacters.count)
                {
                    modifiedCreditCardString.append("/")
                }
            }
        }
        
        if modifiedCreditCardString.count > 5 {
            while modifiedCreditCardString.count > 5 {
                modifiedCreditCardString.removeLast()
            }
        }
        
        let numbers = modifiedCreditCardString.split(separator: "/")
        
        if numbers.count == 2 {
            let first = String((numbers.first ?? "").reversed())
            let second = String((numbers[1]).reversed())
            modifiedCreditCardString = first + "/" + second
        }
        
        
        return modifiedCreditCardString
    }
    
    
    func modifyExperyDateString() -> String {
        let creditCardString : String = self
        var trimmedString = removeSpecialCharsFromString(text: creditCardString.components(separatedBy: .whitespaces).joined())
        
        
        let arrOfCharacters = Array(trimmedString)
        
        var modifiedCreditCardString = ""
        
        if(arrOfCharacters.count > 0)
        {
            for i in 0...arrOfCharacters.count-1
            {
                modifiedCreditCardString.append(arrOfCharacters[i])
                
                if((i+1)%2 == 0 && i+1 != arrOfCharacters.count)
                {
                    modifiedCreditCardString.append("/")
                }
            }
        }
        
        if modifiedCreditCardString.count > 5 {
            while modifiedCreditCardString.count > 5 {
                modifiedCreditCardString.removeLast()
            }
        }
        
        
        return modifiedCreditCardString
    }
    
    
    func modifyPassport() -> String {
        let creditCardString : String = self
        let trimmedString = creditCardString.components(separatedBy: .whitespaces).joined()
        //        if !trimmedString.validateForPassport() {
        //            trimmedString.removeLast()
        //        }
        
        let arrOfCharacters = Array(trimmedString)
        
        var modifiedCreditCardString = ""
        
        if(arrOfCharacters.count > 0)
        {
            //            for i in 0...arrOfCharacters.count-1
            //            {
            //                modifiedCreditCardString.append(arrOfCharacters[i])
            //
            //                if(findTwoPointPassport(i: (i+1)) && i+1 != arrOfCharacters.count)
            //                {
            //                    modifiedCreditCardString.append("")
            //                }
            //            }
            
            for i in 0...arrOfCharacters.count-1
            {
                modifiedCreditCardString.append(arrOfCharacters[i])
                
                if(i == 1)
                {
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        
        if modifiedCreditCardString.hasCyrillic() && !modifiedCreditCardString.isEmpty{
            modifiedCreditCardString.removeLast()
        }
        
        if modifiedCreditCardString.count > 10 {
            while modifiedCreditCardString.count > 10 {
                modifiedCreditCardString.removeLast()
            }
        }
        return modifiedCreditCardString
    }
    
    func hasCyrillic() ->Bool {
        let upper = "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЮЯЫ"
        let lower = "абвгдежзийклмнопрстуфхцчшщьюя"
        
        var hasCyrill = false
        
        for c in self.map({ String($0) }) {
            hasCyrill = hasCyrill || upper.contains(c) || lower.contains(c)
            //            if !upper.contains(c) && !lower.contains(c) {
            //                return false
            //            }
        }
        
        return hasCyrill
        //        return true
    }
    
    func modifyTechPassport() -> String {
        let creditCardString : String = self
        let  trimmedString = creditCardString.components(separatedBy: .whitespaces).joined()
        //        if !trimmedString.validateForPassport() {
        //            trimmedString.removeLast()
        //        }
        let arrOfCharacters = Array(trimmedString)
        
        var modifiedCreditCardString = ""
        
        if(arrOfCharacters.count > 0)
        {
            for i in 0...arrOfCharacters.count-1
            {
                modifiedCreditCardString.append(arrOfCharacters[i])
                
                if(findTwoPointTechPassport(i: (i+1)) && i+1 != arrOfCharacters.count)
                {
                    //                    modifiedCreditCardString.append(" ")
                    modifiedCreditCardString.append("")
                }
            }
        }
        
        
        if modifiedCreditCardString.hasCyrillic() && !modifiedCreditCardString.isEmpty {
            modifiedCreditCardString.removeLast()
        }
        
        if modifiedCreditCardString.count > 10 {
            while modifiedCreditCardString.count > 10 {
                modifiedCreditCardString.removeLast()
            }
        }
        return modifiedCreditCardString
    }
    
    func modifyCarNumner() -> String {
        let creditCardString : String = self
        let  trimmedString = creditCardString.components(separatedBy: .whitespaces).joined()
        //        if !trimmedString.validateForPassport() {
        //            trimmedString.removeLast()
        //        }
        let arrOfCharacters = Array(trimmedString)
        
        var modifiedCreditCardString = ""
        
        if(arrOfCharacters.count > 0)
        {
            for i in 0...arrOfCharacters.count-1
            {
                modifiedCreditCardString.append(arrOfCharacters[i])
                
                if(findTwoPointTechPassport(i: (i+1)) && i+1 != arrOfCharacters.count)
                {
                    //                    modifiedCreditCardString.append(" ")
                    modifiedCreditCardString.append("")
                }
            }
        }
        
        if modifiedCreditCardString.hasCyrillic() && !modifiedCreditCardString.isEmpty {
            modifiedCreditCardString.removeLast()
        }
        
        if modifiedCreditCardString.count > 8 {
            while modifiedCreditCardString.count > 8 {
                modifiedCreditCardString.removeLast()
            }
        }
        return modifiedCreditCardString
    }
    
    func removeWhiteSpaces() -> String {
        let creditCardString : String = self
        return creditCardString.components(separatedBy: .whitespaces).joined()
    }
    
    func findTwoPointTechPassport(i: Int) -> Bool{
        
        let trimarray = [3,10]
        
        for item in trimarray {
            if item == i {
                return true
            }
        }
        
        return false
    }
    
    
    func findTwoPointPassport(i: Int) -> Bool{
        
        let trimarray = [2,9]
        
        for item in trimarray {
            if item == i {
                return true
            }
        }
        
        return false
    }
    
    
    func findTwoPoint(i: Int) -> Bool{
        
        let trimarray = [4,8,12,16]
        
        for item in trimarray {
            if item == i {
                return true
            }
        }
        
        return false
    }
    
    func findTwoPointSum(i: Int) -> Bool{
        
        let trimarray = [3,6,9,12,15]
        
        for item in trimarray {
            if item == i {
                return true
            }
        }
        
        return false
    }
    
    func findTwoPointPhone(i: Int) -> Bool{
        let trimarray = [2,5,7,9]
        
        for item in trimarray {
            if item == i {
                return true
            }
        }
        
        return false
    }
    
    func findTwoPointPhoneWhole(i: Int) -> Bool{
        let trimarray = [4, 6, 9, 11, 13]
        
        for item in trimarray {
            if item == i {
                return true
            }
        }
        
        return false
    }
    
    func findTwoPointJustPhoneWhole(i: Int) -> Bool{
        let trimarray = [2, 5, 7, 9] //+998 99 722 00 96     99 722 00 96
        
        for item in trimarray {
            if item == i {
                return true
            }
        }
        
        return false
    }
    
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("0123456789*")
        return String(text.filter {okayChars.contains($0) })
    }
    
    func removeSpecialCharsFromStringPan() -> String {
        let text = self
        let okayChars : Set<Character> =
            Set("0123456789*")
        return String(text.filter {okayChars.contains($0) })
    }
    
    func removeSpecialCharsFromString() -> String {
        let okayChars : Set<Character> =
            Set("0123456789")
        return String(self.filter {okayChars.contains($0) })
    }
    
    func removeSpecialCharsFromPhone(text: String) -> String {
        let okayChars : Set<Character> =
            Set("0123456789")
        return String(text.filter {okayChars.contains($0) })
    }
    
    func removeSpecialCharsFromAmount() -> String {
        let text: String = self
        let okayChars : Set<Character> =
            Set(".,0123456789")
        return String(text.filter {okayChars.contains($0) })
    }
    
    func removeSpecialCharsFromMaskedPhoneWhole(text: String) -> String {
        let okayChars : Set<Character> =
            Set("+0123456789*")
        return String(text.filter {okayChars.contains($0) })
    }
    
    func removeSpecialCharsFromPhone() -> String {
        let text: String = self
        let okayChars : Set<Character> =
            Set("0123456789")
        return String(text.filter {okayChars.contains($0) })
    }
    
    func removeSpecialCharsFromPhoneWhole() -> String {
        let text: String = self
        let okayChars : Set<Character> =
            Set("+0123456789")
        return String(text.filter {okayChars.contains($0) })
    }
    
    func formatExpiery() -> String {
        let exp: String = self
        var res = String(exp.suffix(2))
        res.append("/")
        res.append(contentsOf: exp.prefix(2))
        return res
    }
    
//    func signatureForServer() -> String {
//        let time = Date().timeForSighnature()
//        let rand = Int.random(in: 1 ... 9)
//        var randText: String = ""
//        for _ in 0 ..< rand {
//            randText += "\(Int.random(in: 1 ... 9))"
//        }
//        randText = "\(rand)\(randText)"
//        print("RANDOM TEXT FOR SIGNATURE : \(randText)")
//        var hash: String = randText + time + Constants.UZCARD_SIGNAURE_FOR_IOS
//        print("RANDOM TEXT FOR SIGNATURE : \(hash)")
//        for _ in 0 ... 2 {
//            let nran = Int.random(in: 1 ... 9)
//            let remove = hash.prefix(nran)
//            hash.removeFirst(nran)
//            hash = String(nran) + hash + remove
//            print("RANDOM TEXT FOR SIGNATURE MOVE \(nran) RESULT \(hash)")
//        }
//        return hash
//    }
}
