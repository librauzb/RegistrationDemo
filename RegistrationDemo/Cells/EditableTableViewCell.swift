//
//  EditableTableViewCell.swift
//  RegistrationDemo
//
//  Created by Ulmasbek on 2021/09/27.
//

import UIKit

class EditableTableViewCell: UITableViewCell , UITextFieldDelegate {
    
    var onRightAction: ((Bool) -> Void)?
    
    var onText: ((String) -> Void)?
    
    var onFocused: (() -> Void)?
    
    var onCurrencyPressed: (() -> Void)?
    
    var onOperationPressed: (() -> Void)?
    
    var onGenderSelected: ((Bool) -> Void)?
        
    var textField: UITextField!
            
    private var type: CellType = .typeName
        
    private var editable: Bool = true
    
    private var model: Model = Model()
    
    private var subLabel : UILabel?
        
    private var maleBtn  = UIButton()
    
    private var femaleBtn = UIButton()
    
    private var selectCurrencyBtn = UIButton()
    
    private var myFont: UIFont = UIFontMetrics.default.scaledFont(for: UIFont(name: "Segoe UI Bold", size: 16) ?? UIFont.systemFont(ofSize: 16))
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?,model: Model, rect: CGRect,type: CellType = .typeName,imagex: UIImage? = nil, imageLeft: UIImage? = nil) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if model.editableCellType != nil {
            self.type = model.editableCellType!
        }else {
            self.type = type
        }
        self.model = model
        self.editable = model.editable
        self.initViews(frame: rect,imagex: imagex, imageLeft: imageLeft)
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    private func initViews(frame: CGRect,imagex: UIImage?, imageLeft: UIImage?){
        
        
        let topMargin: CGFloat = (self.type == .typeSMS) ? 15 : 5
        
        let bottomMargin: CGFloat = 5

        let baseView = UIView(frame: CGRect(x: frame.minX, y: frame.minY + topMargin, width: frame.width, height: frame.height - (topMargin + bottomMargin)))
       
        baseView.layer.cornerRadius = 12
        
        var labelFrame: CGRect = CGRect(x: 66, y: 10 , width: baseView.frame.width - 20, height: 20)
        if self.model.removeTitleLabel {
            labelFrame = CGRect(x: 16, y: 0 , width: baseView.frame.width - 20, height: 0)
        }
        let label = UILabel(frame: labelFrame)
        label.textColor = UIColor(hexString: "#404F6D")
        label.text = self.model.removeTitleLabel ? nil : self.model.title
        label.textAlignment = .left
        label.contentMode = .center
        label.numberOfLines = 1
        label.font = myFont
        
        baseView.backgroundColor = .white
        let phoneCodeWidth: CGFloat = (self.type == .typePhone) ? "+998 ".width(withConstrainedHeight: baseView.frame.height, font: myFont) + 4 : 0
        
        //        textField = UITextField(frame: CGRect(x: phoneCodeWidth + 20, y: 25, width: baseView.frame.width - 40 - phoneCodeWidth, height: baseView.frame.height - 25 - (self.model.hasSubTitle ? 25 : 0)))
        if self.type == .typeSMS {
            textField = UITextField(frame: CGRect(x: phoneCodeWidth + 16, y: 0, width: baseView.frame.width - 40 - phoneCodeWidth, height: baseView.frame.height))
            baseView.layer.borderColor = UIColor.gray.cgColor
            baseView.layer.borderWidth = 1.0
            textField.textAlignment = .center
        }
        else
        if self.type == .typeSex {
            
            let labelSex = UILabel(frame: CGRect(x:  baseView.frame.width - 100, y: 10 , width: 100, height: 20))
            labelSex.textColor = .blue
            labelSex.text = "sex"
            labelSex.textAlignment = .left
            labelSex.contentMode = .center
            labelSex.numberOfLines = 1
            labelSex.font = myFont
            baseView.addSubview(labelSex)
            textField = UITextField(frame: CGRect(x: phoneCodeWidth + 16, y: label.maxY + 5, width: baseView.frame.width / 2 , height: 35))
            
            maleBtn = UIButton(frame:CGRect(x: baseView.frame.width - 100, y:  label.maxY + 10 , width: 30, height: 30))
            femaleBtn =  UIButton(frame:CGRect(x: baseView.frame.width - 50, y: label.maxY + 10, width: 30, height: 30))
            
            maleBtn.addTarget(self, action: #selector(onMaleButtonPressed(_:)), for: .touchUpInside)
            femaleBtn.addTarget(self, action: #selector(onFeMaleButtonPressed(_:)), for: .touchUpInside)
            
//            maleBtn.set(.maleIcon)
//            femaleBtn.set(.female)
            maleBtn.backgroundColor = .gray
            
            femaleBtn.layer.cornerRadius = 6
            maleBtn.layer.cornerRadius = 6
            
            baseView.addSubview(maleBtn)
            baseView.addSubview(femaleBtn)
            
        } else if (self.type == .typeSelectCurrency || self.type == .typeSelectOperation ) {
            
            
            var space = -4
            
            if self.type == .typeSelectCurrency {
                textField = UITextField(frame: CGRect(x: phoneCodeWidth + 16, y: label.maxY + 5, width: baseView.frame.width - 40 - phoneCodeWidth - 100, height: 35))
                
                selectCurrencyBtn =  UIButton(frame:CGRect(x: baseView.frame.width - 100, y: label.maxY + 10, width: 60, height: 30))
                selectCurrencyBtn.setTitle("\(self.model.currencyType)", for: .normal)
                selectCurrencyBtn.setTitleColor(.black, for: .normal)
                
            } else {
                textField = UITextField(frame: CGRect(x: phoneCodeWidth + 66, y: label.maxY + 5, width: 0, height: 35))
                
                selectCurrencyBtn =  UIButton(frame:CGRect(x: phoneCodeWidth + 16, y: label.maxY + 10, width: baseView.frame.width - 40 - phoneCodeWidth - 10, height: 30))
                selectCurrencyBtn.setTitle("\(self.model.operationType)", for: .normal)
                selectCurrencyBtn.titleLabel?.font = myFont
                selectCurrencyBtn.contentHorizontalAlignment = .left
                selectCurrencyBtn.titleLabel?.textAlignment = .left
                selectCurrencyBtn.setTitleColor(.black, for: .normal)
                space = -10
            }
            
            
            selectCurrencyBtn.addTarget(self, action: #selector(currencySelected), for: .touchUpInside)
            baseView.addSubview(selectCurrencyBtn)
            
            let arrow =  UIButton(frame:CGRect(x: selectCurrencyBtn.maxX + CGFloat(space), y: label.maxY + 10, width: 30, height: 30))
//            arrow.set(.bottomArrow)
            arrow.addTarget(self, action: #selector(currencySelected), for: .touchUpInside)
            baseView.addSubview(arrow)
            
        }else  if self.type == .typeCountryPhones {
            textField = UITextField(frame: CGRect(x: phoneCodeWidth + 66, y: label.maxY + 5, width: 0, height: 35))
            
//            phoneNumberTextField = FPNTextField(frame: CGRect(x: phoneCodeWidth + 16, y: label.maxY + 5, width: baseView.frame.width - 40 - phoneCodeWidth, height: 35))
//            //            textField.getFormattedPhoneNumber(format: .E164)
//            phoneNumberTextField.setFlag(key: .RU)
//
//            phoneNumberTextField.textColor = .colorTextDark
//            phoneNumberTextField.font = .appFont(18)
//            phoneNumberTextField.delegate = self
//            phoneNumberTextField.addTarget(self, action: #selector(onFocuseChanged), for: .editingDidBegin)
//            phoneNumberTextField.addTarget(self, action: #selector(onTextChanged), for: .editingChanged)
//            baseView.addSubview(phoneNumberTextField)
            
        } else {
            textField = UITextField(frame: CGRect(x: phoneCodeWidth + 66, y: label.maxY + 5, width: baseView.frame.width - 40 - phoneCodeWidth, height: 35))
            
        }
        
        textField.textColor = .black
//        textField.setPlaceHolder(self.model.placeHolder ?? self.model.title)
        //        textField.setPlaceHolder(self.model.placeHolder ?? "")
        
        textField.attributedPlaceholder = NSAttributedString(string: (self.model.placeHolder ?? self.model.title),
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.5)])
        textField.font = myFont
        textField.delegate = self
        textField.addTarget(self, action: #selector(onFocuseChanged), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(onTextChanged), for: .editingChanged)
        if self.type != .typeSMS {
        baseView.addSubview(label)
        }
        baseView.addSubview(textField)
        
        if self.model.hasSubTitle {
            subLabel = UILabel(frame: CGRect(x: 16, y: textField.maxY + 1, width: baseView.frame.width - 32, height: 20))
            subLabel?.contentMode = .top
            subLabel?.textColor = .darkGray
            subLabel?.font = myFont
            subLabel?.numberOfLines = 2
            subLabel?.text = self.model.subText
        }
        
        if let sub = subLabel { baseView.addSubview(sub) }
        
        self.contentView.addSubview(baseView)
        
        switch self.type {
        
        case .typeSelectCurrency :
            textField.keyboardType = .numberPad
            break
        case .typeCountryPhones : break
        case .typeSelectOperation : break
        case .typePhone:
            textField.keyboardType = .phonePad
            textField.placeholder = "99 123 45 67"
            let buttonx = UILabel(frame: CGRect(x: 66, y:  label.maxY + 5, width: phoneCodeWidth , height: textField.frame.height))
            buttonx.contentMode = .center
            buttonx.font = myFont
            buttonx.text = "+998"
            buttonx.textColor = .black
            baseView.addSubview(buttonx)
            break
        case .typeName:
            textField.keyboardType = .default
            break
            
        case .typeNameUpper:
            textField.keyboardType = .default
            break
            
        case .typeCardNumber:
            textField.keyboardType = .numberPad
            textField.placeholder = "**** **** **** ****"
            break
        case .typeSumma:
            textField.setPlaceHolder(self.model.placeHolder ?? "from 500 to 9 999 999 999 sum")
            textField.keyboardType = .numberPad
            break
            
        case .typeCardExpiry:
            textField.placeholder = "mm/yy"
            textField.keyboardType = .numberPad
            break
        case .typrPassword:
            textField.keyboardType = .default
            textField.isSecureTextEntry = true
            textField.textContentType = .init(rawValue: "")
            break
        case .typeSMS:
            textField.keyboardType = .numberPad
            if #available(iOS 12.0, *) {
                textField.textContentType = .oneTimeCode
            } else {
                textField.keyboardType = .numberPad
            }
            textField.isSecureTextEntry = false
            
            break
        case .typeBirthDay , .typeSex:
            textField.keyboardType = .default
            textField.placeholder = "01.01.1996"
            textField.isUserInteractionEnabled = true
            textField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onDatePicker)))
            baseView.isUserInteractionEnabled = true
            baseView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onDatePicker)))
            break
        case .typeInn:
            textField.keyboardType = .numberPad
            break
        case .typeInnDoc:
            textField.keyboardType = .default
            textField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onInnTypePicker)))
            baseView.isUserInteractionEnabled = true
            baseView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onInnTypePicker)))
        case .typeMilitary:
            textField.keyboardType = .default
            
            break
        case .typeCertificate:
            textField.keyboardType = .default
            
            break
        case .typePassport:
            textField.keyboardType = .default
            
        case .typeCarNumber:
            textField.keyboardType = .default
            
            break
        case .typeTechPassport:
            
            textField.keyboardType = .default
            self.textField.autocapitalizationType = .allCharacters
            
        }
        
        
        if model.isUpperCased {
            self.textField.autocapitalizationType = .allCharacters
        }
        
        if let image = imagex {
            let buttonx = UIButton(frame: CGRect(x: baseView.frame.width - 50, y: label.maxY + 5, width: 30, height: textField.frame.height))
            buttonx.setImage(image, for: .normal)
            buttonx.contentMode = .center
            buttonx.addTarget(self, action: #selector(onRightImage), for: .touchUpInside)
            baseView.addSubview(buttonx)
        }
        
        if let image = imageLeft {
            let buttony = UIButton(frame: CGRect(x: 16, y: baseView.centerY - 30, width: 30, height: textField.frame.height))
            buttony.setImage(image, for: .normal)
            buttony.contentMode = .center
            baseView.addSubview(buttony)
        }
        
        let delimitView = UIView(frame: CGRect(x: 66, y: textField.maxY + 2, width: windowWidth - 100, height: 1))
        delimitView.backgroundColor = .gray
        baseView.addSubview(delimitView)
        
        if type == .typeBirthDay || type == .typeSex {
            let buttonx = UIButton(frame: CGRect(x:type == .typeSex ? baseView.frame.width / 2 - 16 : baseView.frame.width  - 50 , y: label.maxY + 5, width: 30, height: textField.frame.height))
//            buttonx.set(.calendar)
            buttonx.contentMode = .center
            buttonx.addTarget(self, action: #selector(onRightImage), for: .touchUpInside)
            baseView.addSubview(buttonx)
        }
        
    }
    
    
    @objc func onMaleButtonPressed(_ sender: UIButton) {
        updateSexType(isMale: true)
    }
    
    @objc func onFeMaleButtonPressed(_ sender: UIButton) {
        updateSexType(isMale: false)
    }
    
    func updateSexType(isMale: Bool)  {
        
        onGenderSelected?(isMale)
        
        if isMale{
            maleBtn.backgroundColor = .yellow
            femaleBtn.backgroundColor = .white
        }else{
            maleBtn.backgroundColor = .white
            femaleBtn.backgroundColor = .yellow
        }
    }
    
    func updateCurrencyType(type : Currency, title: String) {
        self.model.currencyType = type
        selectCurrencyBtn.setTitle("\(title)", for: .normal)
    }
    
    func updateOperationType(type : UNISTREAMOPERATIONTYPE, title: String) {
        self.model.operationType = type
        selectCurrencyBtn.setTitle("\(title)", for: .normal)
    }
    
    func setEditable(editable: Bool)  {
        self.editable = editable
    }
    
    func updateCommission(commission: Float)  {
        subLabel?.text = "\(commission)" + " uzs"
    }
    
    func updaet(text: String, _ update:  Bool = false , hasCommission: Bool = false){
        print("updaet (\(self.type) = \(text)")
        
        if self.type == .typeBirthDay {
           
            self.textField.text = text
            //            if text.count >= 10 {
            //                self.textField.text = String(text.prefix(10))
            //            }else{
            //                self.textField.text = text
            //            }
            
        } else {
            self.textField.text = text
        }
        if update {
            self.textField.sendActions(for: .editingChanged)
        }
        
        if self.type == .typeInn {
            self.textField.text = (text.count <= 9) ? String(text.prefix(9)) : text
        } else {
            self.textField.text = text
        }
        
        if self.type == .typeMilitary{
            self.textField.text = (text.count <= 10) ? String(text.prefix(10)) : text
        } else {
            self.textField.text = text
        }
        
        if self.type == .typePassport{
            self.textField.text = (text.count <= 10) ? String(text.prefix(10)) : text
        } else {
            self.textField.text = text
        }
        
        if self.type == .typeTechPassport{
            self.textField.text = (text.uppercased().count <= 10) ? String(text.uppercased().prefix(10)) : text.uppercased()
        } else {
            self.textField.text = text.uppercased()
        }
        
        if self.type == .typeCertificate{
            self.textField.text = (text.count <= 10) ? String(text.prefix(10)) : text
        } else {
            self.textField.text = text
        }
        
        if self.type == .typeSumma {
            if !hasCommission {
                let amount = (Float(text.removeSpecialCharsFromString()) ?? 0 )
                let commissionText = "comission " + "\(amount)" + " uzs"
                subLabel?.text  = commissionText
            }
        }
        
        if self.type == .typeCountryPhones {
//            self.phoneNumberTextField.text = text
        }
        
    }
    
    func startBecomingResponder(_ enable: Bool){
        if enable {
            self.textField.becomeFirstResponder()
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self.editable
    }
    
    @objc func onDatePicker(_ sender: UIGestureRecognizer){
        if let action = self.onRightAction{
            action(true)
        }
    }
    
    @objc func onInnTypePicker(_ sender: UIGestureRecognizer){
        if let action = self.onRightAction{
            action(true)
        }
    }
    
    @objc func onRightImage(_ sender: UIButton){
        if let action = self.onRightAction{
            action(true)
        }
        if self.type == .typrPassword || self.type == .typeSMS {
            self.textField.isSecureTextEntry = !self.textField.isSecureTextEntry
//            if self.textField.isSecureTextEntry {
//                sender.setBackgroundImage(UIImage(named: "eyeOpen"), for: .normal)
//            } else {
//                sender.setBackgroundImage(UIImage(named: "eyeOpen"), for: .normal)
//            }
        }
    }
    
    @objc func currencySelected(){
        if self.type == .typeSelectCurrency {
            onCurrencyPressed?()
        }else{
            onOperationPressed?()
        }
    }
    
    
    @objc func onFocuseChanged(_ textField: UITextField){
        onFocused?()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if self.type == .typeSumma || self.type == .typeCountryPhones{
            guard let textFieldText = textField.text,
                  let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            if self.type == .typeSumma {
                return count <= 13//self.summeryType.count(self.model.currencyType)
            }else{
                return count <= 13
            }
            
        }else{
            return true
        }
    }
    
    func beFirstResponder()  {
        self.textField?.becomeFirstResponder()
    }
    
    @objc func onTextChanged(_ textField: UITextField){
        switch self.type {
        case .typeCountryPhones : break
        case .typeSelectOperation : break
        case .typeSelectCurrency :
//            self.textField.text = "".modifySummeryEntering(textField.text ?? "")
            
//            if let text = self.textField.text {
//
//                if let amount = Double(text.removeSpecialCharsFromString()){
//
//                        if amount >= self.summeryType.min(self.model.currencyType) && amount <= self.summeryType.max(self.model.currencyType) {
//                            self.textField.textColor = .colorTextDark
//                        } else {
//                            self.textField.textColor = .colorSubMain
//                        }
//
//                }else {
//                    self.textField.textColor = .colorSubMain
//                }
//            } else {
//
//                self.textField.textColor = .colorTextDark
//            }
//
//            if let text = textField.text {
//
//                if text.trim().removeSpecialCharsFromString().count > 8 {
//                    self.textField.text?.removeLast()
//                }else{
//                    //textField?(text.removeSpecialCharsFromString())
//                }
//            }
            break
        case .typeSex: break
        case .typePhone:
            self.textField.text = textField.text?.modifyPhoneNumberString()
            if (self.textField.text?.removeSpecialCharsFromPhone().count ?? 0) > "946463646".count{
                self.textField.text?.removeLast()
            }
            break
        case .typeName:
            
            break
        case .typeNameUpper:
            self.textField.text = (textField.text ?? "").uppercased()
            break
        case .typrPassword:
            
            break
        case .typeSMS:
            if (self.textField.text?.count ?? 0) > "123456".count{
                self.textField.text?.removeLast()
            }
            break
        case .typeBirthDay:
            
            break
        case .typeSumma:
            
            
//            self.textField.text = "".modifySummeryEntering(textField.text ?? "")
//
//            if let text = self.textField.text {
//
//                var amountText = ((Float(text.removeSpecialCharsFromString()) ?? 0 ) * commissionPercent).formatCostNumber()
//
//                if let amount = Double(text.removeSpecialCharsFromString()){
//
//                    if amount >= self.summeryType.min(.uzs) && amount <= self.summeryType.max(.uzs) {
//
//                        self.textField.textColor = .colorTextDark
//                    } else {
//                        amountText = "0"
//                        self.textField.textColor = .colorSubMain
//                    }
//                }else {
//
//                    self.textField.textColor = .colorSubMain
//                }
//
//                let commissionText =  LanguageManager.get("comission") + " \(amountText) " + LanguageManager.get("uzs")
//
//                self.subLabel?.text  = commissionText
//
//            } else {
//
//                self.textField.textColor = .colorTextDark
//            }
//
//            if let text = textField.text {
//
//                if text.count > self.summeryType.count(self.model.currencyType) {
//                    self.textField.text?.removeLast()
//                } else {
//                    //textField?(text.removeSpecialCharsFromString())
//                }
//            }
//
            break
        case .typeCardNumber:
            self.textField.text = (textField.text ?? "").modifyCreditCardString()
            break
            
        case .typeCardExpiry:
            self.textField.text = (textField.text ?? "").modifyExperyDateString()
            break
        case .typeInn:
            self.textField.text = (textField.text ?? "").modifyInnString()
            break
        case .typeInnDoc:
            
            break
        case .typeMilitary:
            
            break
        case .typeCarNumber:
            self.textField.text = (textField.text ?? "").modifyCarNumner().uppercased()
        case .typeTechPassport:
            self.textField.text = (textField.text ?? "").modifyTechPassport().uppercased()
//            self.textField.text = (textField.text ?? "").uppercased()
        case .typeCertificate:
            
            break
        case .typePassport:
            self.textField.text = (textField.text ?? "").modifyPassport().uppercased()
            break
        }
        
        if let action = self.onText{
            
            if self.model.editableCellType != .typeCountryPhones {
                action(textField.text ?? "")
            }else{
//                let phoneCode = (textField as? FPNTextField)?.selectedCountry?.phoneCode as! String
//                let phone = textField.text ?? ""
//                onText?("\(phoneCode)\(phone)".replacingOccurrences(of: "+", with: ""))
            }
        }
        
        if let text = self.textField.text{
            if text.count > model.minElementCount {
                self.textField.text?.removeLast()
            }
        }
    }
    
    enum CellType {
        case typePhone
        case typeName
        case typeInn
        case typeBirthDay
        case typrPassword
        
        case typeNameUpper
        case typeCarNumber
        case typeSMS
        case typeCardNumber
        case typeCardExpiry
        case typeSumma
        case typeInnDoc
        case typePassport
        case typeMilitary
        case typeCertificate
        case typeTechPassport
        case typeSex
        case typeSelectCurrency
        case typeSelectOperation
        case typeCountryPhones
    }
    
    
    struct Model {
        
        init(title: String, text: String, placeHolder: String? = nil, subText: String? = nil, hasSubTitle: Bool,isUpperCased : Bool = false,editableCellType : CellType? = nil ,_ editable: Bool = true,minElementCount : Int = 27,currencyType : Currency = .uzs,operationType : UNISTREAMOPERATIONTYPE = .PHONE) {
            self.text = text
            self.title = title
            self.placeHolder = placeHolder
            self.subText = subText
            self.hasSubTitle = hasSubTitle
            self.editable = editable
            self.minElementCount = minElementCount
            self.currencyType = currencyType
            self.operationType = operationType
            self.isUpperCased = isUpperCased
            self.editableCellType = editableCellType
        }
        
        init(title: String,placeHolder: String? = nil,hasSubTitle: Bool = false, isUpperCased : Bool = false, editableCellType : CellType? = nil ,  _ editable: Bool = true, minElementCount : Int = 27, currencyType : Currency = .uzs,operationType : UNISTREAMOPERATIONTYPE = .PHONE) {
            self.text = ""
            self.title = title
            self.placeHolder = placeHolder
            self.subText = nil
            self.hasSubTitle = hasSubTitle
            self.editable = editable
            self.currencyType = currencyType
            self.operationType = operationType
            self.isUpperCased = isUpperCased
            self.editableCellType = editableCellType
            self.minElementCount = minElementCount
        }
        
        init() {
            self.text = ""
            self.title = ""
            self.placeHolder = nil
            self.subText = nil
            self.hasSubTitle = false
            self.editable = true
            self.isUpperCased = false
            self.editableCellType = nil
        }
        
        var text: String
        var title: String
        var placeHolder: String?
        var subText: String?
        var hasSubTitle: Bool
        var editable: Bool = true
        var isUpperCased = false
        var editableCellType : CellType? = nil
        var minElementCount = 27
        var currencyType : Currency = .uzs
        var operationType : UNISTREAMOPERATIONTYPE = .PHONE
        
        var removeTitleLabel: Bool {
            return (self.title.count == 1) && (self.title.contains("-"))
        }
    }
}
