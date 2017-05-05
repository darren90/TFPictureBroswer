//
//  TFPictureBroswerCell.swift
//  TFPictureBroswer_Swift
//
//  Created by Fengtf on 2017/5/5.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

protocol TFPictureBroswerCellDelegate : Protocol {
    func imageViewDidClick()
}

class TFPictureBroswerCell: UICollectionViewCell {

    lazy var scrollView = UIScrollView()
    lazy var iconView = UIImageView()
    lazy var progressView:TFProgressView = TFProgressView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func initUI(){
        contentView.addSubview(scrollView)
        contentView.addSubview(iconView)
//        contentView.addSubview(progressView)

        progressView.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        progressView.center = CGPoint(x: UIScreen.main.bounds.width*0.5, y: UIScreen.main.bounds.height * 0.5)
        progressView.isHidden = true
        progressView.backgroundColor = UIColor.clear
        scrollView.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width-kPhotoMargin, height: contentView.bounds.height)

        iconView.isUserInteractionEnabled = true
        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        iconView.frame = contentView.bounds
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismiss))
        iconView.addGestureRecognizer(tap)
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
//            iconView.kf.set
        }
    }



    func dismiss(){

    }



}
