//
//  ViewController.swift
//  RegistrationDemo
//
//  Created by Ulmasbek on 2021/09/27.
//

import UIKit
import SnapKit

struct RegisterModel{
    
    var myMail: String = ""
    var myPassword: String = ""
    var myNumber: String = ""
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    var isReady: Bool {
        var ready: Bool = false
        ready = isValidEmail(myMail) && myPassword.count > 0 && myNumber.count == 12
        return ready
    }
    
}

class ViewController: UIViewController {
    
    let tableView = UITableView()
    var registerModel: RegisterModel = RegisterModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        addTableView()
    }
    
    
    
    func addTableView(){
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.allowsSelection = false
        
        tableView.register(HeaderTableViewCell.self, forCellReuseIdentifier: "HeaderTableViewCell")
        tableView.register(ImgViewTableViewCell.self, forCellReuseIdentifier: "ImgViewTableViewCell")
        tableView.register(MainButtonTableViewCell.self, forCellReuseIdentifier: "MainButtonTableViewCell")
        tableView.register(TwoLabelsTableViewCell.self, forCellReuseIdentifier: "TwoLabelsTableViewCell")
    
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            
            make.bottom.right.left.equalToSuperview()
            
            make.top.equalToSuperview().offset(70)
        }
    }
    
  

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 8
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
            cell.label.text = "Sign Up"
            cell.label.font = UIFontMetrics.default.scaledFont(for: UIFont(name: "Segoe UI", size: 30) ?? UIFont.systemFont(ofSize: 30))
            cell.label.textColor = UIColor(hexString: "#415A60")
            cell.selectionStyle = .none
            return cell
        case  1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
            cell.label.text = "Fill the details & create your account"
            cell.label.textColor = UIColor(hexString: "#415A60")
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImgViewTableViewCell", for: indexPath) as! ImgViewTableViewCell
            cell.selectionStyle = .none
            return cell
            
        case 3:
            
            let cell = EditableTableViewCell(style: .default, reuseIdentifier: "EditableTableViewCell", model: EditableTableViewCell.Model(title: "Mail", text: "" ,placeHolder: "Enter email address here", subText: "", hasSubTitle: true, isUpperCased: false, true), rect: CGRect(x: 16, y: 0, width: windowWidth - 32, height: self.getItemHeight(indexPath.row) - 10), type: .typeName, imagex: nil, imageLeft: UIImage(named: "envelope"))
            
            cell.onText = { text in
                self.registerModel.myMail = text
            }
            return cell
        case 4:
            let cell = EditableTableViewCell(style: .default, reuseIdentifier: "EditableTableViewCell", model: EditableTableViewCell.Model(title: "Password", text: "" ,placeHolder: "Write your password", subText: "", hasSubTitle: true, isUpperCased: false, true), rect: CGRect(x: 16, y: 0, width: windowWidth - 32, height: self.getItemHeight(indexPath.row) - 10), type: .typrPassword, imagex: UIImage(named: "eyeOpen"), imageLeft: UIImage(named: "envelope"))
            
            cell.onText = { text in
                self.registerModel.myPassword = text
            }
            return cell
        case 5:
            let cell = EditableTableViewCell(style: .default, reuseIdentifier: "EditableTableViewCell", model: EditableTableViewCell.Model(title: "Your phone", text: "" ,placeHolder: "Enter email address here", subText: "", hasSubTitle: true, isUpperCased: false, true), rect: CGRect(x: 16, y: 0, width: windowWidth - 32, height: self.getItemHeight(indexPath.row) - 10), type: .typePhone, imagex: nil, imageLeft: UIImage(named: "phone"))
            
            cell.onText = { text in
                self.registerModel.myNumber = text
            }
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainButtonTableViewCell", for: indexPath) as! MainButtonTableViewCell
            cell.btn.setTitle("Sign up", for: .normal)
            cell.selectionStyle = .none
            cell.buttonTappedAction = {
                
            }
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TwoLabelsTableViewCell", for: indexPath) as! TwoLabelsTableViewCell
            cell.selectionStyle = .none
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.getItemHeight(indexPath.row)
    }
    
    private func getItemHeight(_ index: Int) -> CGFloat{
        switch index {
        case 0:
            return 36
        case  2:
            return 300
        case 3,4,5:
            return 100
        case 6:
            return 70
        case 7:
            return 100
        default:
            return 36
        }
    }
    
}
