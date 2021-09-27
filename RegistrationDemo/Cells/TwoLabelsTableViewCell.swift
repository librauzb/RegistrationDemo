//
//  TwoLabelsTableViewCell.swift
//  RegistrationDemo
//
//  Created by Ulmasbek on 2021/09/27.
//

import UIKit
import SnapKit

class TwoLabelsTableViewCell: UITableViewCell {
    
    let containerView = UIView()
    let label = UILabel()
    let btn = UIButton()
   
    var padding: ConstraintRelatableTarget = 16.0
    var rightPadding: ConstraintRelatableTarget = -16.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.addSubview(label)
      
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = .clear
        containerView.snp.makeConstraints { (make) in
            make.left.equalTo(padding)
            make.right.equalTo(rightPadding)
            make.height.equalTo(30)
            make.top.equalTo(5)
            make.bottom.equalTo(-30)
        }
        
        containerView.addSubview(btn)
        
        btn.setTitleColor(UIColor(hexString: "#2D4CA9"), for: .normal)
        btn.setTitle("Sign up", for: .normal)
        btn.titleLabel?.font = UIFontMetrics.default.scaledFont(for: UIFont(name: "Segoe UI", size: 16) ?? UIFont.systemFont(ofSize: 16))
        
        btn.snp.makeConstraints { make in
            
            make.centerY.equalToSuperview()
            make.right.equalTo(-50)
            make.width.equalTo("Sign up".width(withConstrainedHeight: 30, font: UIFontMetrics.default.scaledFont(for: UIFont(name: "Segoe UI Bold", size: 16) ?? UIFont.systemFont(ofSize: 16))))
        }
        
        label.font = UIFontMetrics.default.scaledFont(for: UIFont(name: "Segoe UI Bold", size: 16) ?? UIFont.systemFont(ofSize: 16))
        label.textColor = UIColor(hexString: "#BCBCBF")
        label.textAlignment = .right
        label.text = "Don't have an account?"
        
        label.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(padding)
            make.right.equalTo(btn.snp.left).offset(-10)
        }
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
