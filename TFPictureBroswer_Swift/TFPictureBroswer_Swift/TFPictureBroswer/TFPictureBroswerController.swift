//
//  TFPictureBroswerController.swift
//  TFPictureBroswer_Swift
//
//  Created by Fengtf on 2017/5/5.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

private let KPictureBroswerCell = "TFPictureBroswerCell"
let kPhotoMargin:CGFloat = 10

class TFPictureBroswerController: UIViewController {

    // MARK:-- 定义属性
    var indexPath:IndexPath
    var picUrls : [String]

    lazy var collectionView:UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())

    lazy var closeBtn = UIButton()
    lazy var saveBtn = UIButton()

    // MARK:-- 自定义构造函数
    init(indexPath:IndexPath,picUrls:[String]){
        self.indexPath = indexPath
        self.picUrls = picUrls
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

       initUI()

       collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }

}

// MARK: -- set up UI
extension TFPictureBroswerController{
    func initUI(){
        view.addSubview(collectionView)
        view.addSubview(closeBtn)
        view.addSubview(saveBtn)

        collectionView.frame = CGRect(x: 0, y: 0, width: view.bounds.width + kPhotoMargin, height: view.bounds.height)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TFPictureBroswerCell.self, forCellWithReuseIdentifier: KPictureBroswerCell)

        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.itemSize = (collectionView.frame.size)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.collectionView?.isPagingEnabled = true
        layout.collectionView?.showsVerticalScrollIndicator = false
        layout.collectionView?.showsHorizontalScrollIndicator = false

        // setup btn
        closeBtn.setTitle("关闭", for: .normal)
        closeBtn.backgroundColor = UIColor.lightGray
        closeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        closeBtn.addTarget(self, action: #selector(self.closeAction), for: .touchUpInside)

        closeBtn.translatesAutoresizingMaskIntoConstraints = false
        saveBtn.translatesAutoresizingMaskIntoConstraints = false

        let cl = NSLayoutConstraint(item: closeBtn
            , attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 30)
        let cr = NSLayoutConstraint(item: closeBtn
            , attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 30)
        let cw = NSLayoutConstraint(item: closeBtn
            , attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 90)
        let ch = NSLayoutConstraint(item: closeBtn
            , attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30)
        view.addConstraints([cl,cr,cw,ch])

        saveBtn.setTitle("保存", for: .normal)
        saveBtn.backgroundColor = UIColor.lightGray
        saveBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        saveBtn.addTarget(self, action: #selector(self.saveAction), for: .touchUpInside)

        let sl = NSLayoutConstraint(item: saveBtn
            , attribute:.right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 30)
        let sr = NSLayoutConstraint(item: saveBtn
            , attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier:1.0, constant: 30)
        let sw = NSLayoutConstraint(item: saveBtn
            , attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 90)
        let sh = NSLayoutConstraint(item: saveBtn
            , attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier:1.0, constant: 30)
        view.addConstraints([sl,sr,sw,sh])
    }

    func closeAction(){
        dismiss(animated: true, completion: nil)
    }

    func saveAction(){

    }
}



extension TFPictureBroswerController : UICollectionViewDelegate,UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return picUrls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KPictureBroswerCell, for:  indexPath) as! TFPictureBroswerCell
        let url = picUrls[indexPath.row];
        cell.imgUrl = url;
        //        cell.backgroundColor = UIColor.cyan
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print("-tf-:\(indexPath.row)");


        
    }
    
}






