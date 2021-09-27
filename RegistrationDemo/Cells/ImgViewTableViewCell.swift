//
//  ImgViewTableViewCell.swift
//  RegistrationDemo
//
//  Created by Ulmasbek on 2021/09/27.
//

import UIKit
import SnapKit

class ImgViewTableViewCell: UITableViewCell {
    
    let containerView = UIView()
    let imgView = UIImageView()
   
    var padding: ConstraintRelatableTarget = 32.0
    var rightPadding: ConstraintRelatableTarget = -32.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.addSubview(imgView)
      
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = .clear
        containerView.snp.makeConstraints { (make) in
            make.left.equalTo(padding)
            make.right.equalTo(rightPadding)
            make.height.equalTo(300)
            make.top.equalTo(20)
            make.bottom.equalTo(-20)
        }
        
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "bgImg")
        
        
        imgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
