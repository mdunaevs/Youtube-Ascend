//
//  MenuBar.swift
//  YoutubeHomeDemo
//
//  Created by Max Dunaevschi on 7/24/19.
//  Copyright © 2019 Max Dunaevschi. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 32/255, alpha: 1)
        return cv
    }()
    
    let headerTaskLabel: UILabel = {
        let label = UILabel()
        label.text = "Tasks"
        label.textColor = UIColor.white
        //label.backgroundColor = UIColor.blue
        label.font = label.font.withSize(30)
        return label
    }()
    
    var overviewLabel: UILabel = {
        let label = UILabel()
        label.text = "overview"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        collectionView.addSubview(headerTaskLabel)
        collectionView.addSubview(overviewLabel)
        addConstraintsWithFormat(format: "H:|-14-[v0(150)]-20-[v1(50)]", views: headerTaskLabel, overviewLabel)
        addConstraintsWithFormat(format: "V:|[v0(50)]|", views: headerTaskLabel)
        addConstraintsWithFormat(format: "V:|[v0(20)]", views: overviewLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class MenuCell: BaseCell{
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home (1)")
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addConstraintsWithFormat(format: "H:[v0(28)]", views: imageView)
        addConstraintsWithFormat(format: "V:[v0(28)]", views: imageView)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        //backgroundColor = UIColor.yellow
    }
    
    
}
