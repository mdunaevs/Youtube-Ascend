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
        
        self.backgroundColor = UIColor.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
