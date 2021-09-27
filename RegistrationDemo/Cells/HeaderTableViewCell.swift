//
//  HeaderTableViewCell.swift
//  RegistrationDemo
//
//  Created by Ulmasbek on 2021/09/27.
//

import UIKit
import SnapKit

class HeaderTableViewCell: UITableViewCell {
    
    let containerView = UIView()
    let label = UILabel()
   
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
            make.bottom.equalTo(-5)
        }
        
        label.font = UIFontMetrics.default.scaledFont(for: UIFont(name: "Segoe UI", size: 16) ?? UIFont.systemFont(ofSize: 16))
        label.textColor = UIColor(hexString: "#BCBCBF")
        label.textAlignment = .center
        
        label.snp.makeConstraints { (make) in
            make.centerY.equalTo(containerView.snp.centerY)
            make.left.equalTo(padding)
            make.right.equalTo(rightPadding)
        }
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
