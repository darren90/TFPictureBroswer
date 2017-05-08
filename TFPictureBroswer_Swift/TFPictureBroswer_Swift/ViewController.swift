//
//  ViewController.swift
//  TFPictureBroswer_Swift
//
//  Created by Fengtf on 2017/5/5.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    lazy var photoBrowserAnimator : TFPictureBroswerAnimator = TFPictureBroswerAnimator()


    let imgs = ["http://p2.so.qhimgs1.com/t016ebb96578fbd0cd2.jpg",
                "http://p3.so.qhimgs1.com/sdr/1600_900_/t01f253abaecd67c7e3.jpg",
                "http://p3.so.qhmsg.com/sdr/1125_900_/t01c36a2828ada90988.jpg",
                "http://p5.so.qhimgs1.com/sdr/1440_900_/t010a549f1d8f4c5edb.jpg",
                "https://p2.so.qhimg.com/t013314dfd21f1c9bf7.jpg",
                "http://p4.so.qhimg.com/t010f4d848562ee4d89.jpg",
                "http://p1.so.qhmsg.com/sdr/1600_900_/t01b09a1a98e774af76.jpg",
                "http://p0.so.qhimg.com/t0161c53eef11d4a13f.jpg",
                "http://p1.so.qhimg.com/t018e0d5c95413e8716.jpg",
                "http://p1.so.qhimg.com/t01739d7baafb216b61.jpg"]

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionViewLayout.itemSize = CGSize(width: 200, height: 130)
        collectionViewLayout.minimumLineSpacing = 15
        collectionViewLayout.minimumInteritemSpacing = 15
    }



}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return imgs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WaterCell", for:  indexPath) as! WaterCell
        let url = imgs[indexPath.row];
        cell.imgUrl = url;
//        cell.backgroundColor = UIColor.cyan
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print("--:\(indexPath.row)");

        photoBrowserAnimator.presentedDelegate = self
        photoBrowserAnimator.indexPath = indexPath
        photoBrowserAnimator.dismissDelegate = self

        let pbVc = TFPictureBroswerController(indexPath: indexPath, picUrls: imgs)
        pbVc.modalPresentationStyle = .custom
//        pbVc.transitioningDelegate = self
        present(pbVc, animated: true, completion: nil)

    }


}

extension ViewController : PictureBroswerAnimatorPresentedDelegate {
    func startRect(indexPath: IndexPath) -> CGRect {
        let cell = self.collectionView.cellForItem(at: indexPath)
        if cell == nil {
            return CGRect(x: 0, y: 0, width: 0, height: 0)
        }

        let startFrame = self.view.convert((cell?.frame)!, to: UIApplication.shared.keyWindow)
        return startFrame
    }

    func endRect(indexPath: IndexPath) -> CGRect {
        return CGRect(x: 100, y: 100, width: 100, height: 100)
    }


    func imageView(indexPath:IndexPath) -> UIImageView {
        let imageView = UIImageView()
        let cell = self.collectionView.cellForItem(at: indexPath)
        if cell == nil {
            return imageView
        }

        imageView = cell.icon

        return imageView
    }

}

extension ViewController : PictureBroswerAnimatorDismissDelegate {

    func imageView(indexPath: IndexPath) -> UIImageView {

    }

    func indexPathForDismiss() -> IndexPath {

    }
    
}









