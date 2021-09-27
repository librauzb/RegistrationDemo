//
//  MainButtonTableViewCell.swift
//  RegistrationDemo
//
//  Created by Ulmasbek on 2021/09/27.
//

import UIKit
import SnapKit

class MainButtonTableViewCell: UITableViewCell {
    
    var buttonTappedAction : (() -> Void)? = nil
    
    let containerView = UIView()
    let btn = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        
        
        contentView.addSubview(containerView)
        containerView.addSubview(btn)
        containerView.backgroundColor = .clear
        self.containerView.shadowColor = UIColor.black.withAlphaComponent(0.7)
        
        containerView.snp.makeConstraints { (make) in
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(70)
            make.top.equalTo(20)
            make.bottom.equalTo(-20)
        }
        
        btn.titleLabel?.font =  UIFontMetrics.default.scaledFont(for: UIFont(name: "Segoe UI", size: 16) ?? UIFont.systemFont(ofSize: 16))
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(hexString: "#FF3E2F")
        
        btn.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
        
        btn.layer.cornerRadius = 7
        btn.clipsToBounds = true
        
        btn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(containerView.snp_leftMargin).offset(0)
            make.right.equalTo(containerView.snp_rightMargin).offset(0)
            make.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func btnPressed(){
        if let btnTapped = self.buttonTappedAction{
            btnTapped()
        }
    }

}
