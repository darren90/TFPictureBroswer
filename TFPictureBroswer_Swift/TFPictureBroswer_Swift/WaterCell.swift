//
//  WaterCell.swift
//  TFPictureBroswer_Swift
//
//  Created by Fengtf on 2017/5/5.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

class WaterCell: UICollectionViewCell {
    @IBOutlet weak var iconView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

//        self.contentView.backgroundColor = UIColor.cyan;
    }

    var imgUrl:String?{
        didSet{
            guard let imgUrl = imgUrl else {
                return
            }
            guard let url = URL(string: imgUrl) else{
                return
            }
            let resource = ImageResource(downloadURL: url)
            iconView.kf.setImage(with: resource)
        }
    }
    
}
