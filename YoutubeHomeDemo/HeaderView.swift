//
//  HeaderView.swift
//  YoutubeHomeDemo
//
//  Created by Max Dunaevschi on 7/27/19.
//  Copyright © 2019 Max Dunaevschi. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeader()
        //self.backgroundColor = UIColor.blue
    }
    
    let headerSectionLabel: UILabel = {
        let label = UILabel()
        //label.text = "Current"
        label.font = label.font.withSize(25)
        //label.backgroundColor = UIColor.green
        return label
    }()
    
    func setupHeader(){
        addSubview(headerSectionLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0(300)]", views: headerSectionLabel)
        addConstraintsWithFormat(format: "V:|-40-[v0(30)]", views: headerSectionLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
