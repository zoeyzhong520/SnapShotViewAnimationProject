//
//  ViewController.swift
//  SnapShotViewAnimationProject
//
//  Created by zhifu360 on 2019/5/23.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    ///创建UICollectionView
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100*SCALE_X, height: 100*SCALE_Y)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        let collec = UICollectionView(frame: CGRect(x: 0, y: view.bounds.size.height-120*SCALE_Y, width: view.bounds.size.width, height: 120*SCALE_Y), collectionViewLayout: layout)
        collec.backgroundColor = UIColor.clear
        collec.delegate = self
        collec.dataSource = self
        collec.register(CustomCell.self, forCellWithReuseIdentifier: BaseCollectReuseIdentifier)
        return collec
    }()
    
    ///创建UIImageView
    lazy var targetImgView: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300*SCALE_X, height: 300*SCALE_Y))
        imgView.layer.cornerRadius = 3
        imgView.contentMode = UIView.ContentMode.scaleAspectFill
        imgView.clipsToBounds = true
        imgView.center = view.center
        return imgView
    }()
    
    ///数据源
    let dataArray = ["1","2","3","4","5","6"]
    
    ///选中的cell
    var selectedCell: CustomCell?
    
    ///当前的截图
    var snapShotView: UIView?
    
    ///之前的截图
    var afterSnapShotView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
    }
    
    func setPage() {
        title = "演示"
        view.addSubview(collectionView)
        view.addSubview(targetImgView)
    }

}

extension ViewController: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CustomCell = CustomCell.createCellWith(collection: collectionView, indexPath: indexPath, imageName: dataArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if snapShotView != nil {
            afterSnapShotView = snapShotView
            afterSnapShotView?.isHidden = false
            //执行动画
            backAction(snapShotView: afterSnapShotView!, selectedCell: selectedCell!)
        }
        
        selectedCell = collectionView.cellForItem(at: indexPath) as? CustomCell
        //截图
        snapShotView = selectedCell?.snapshotView(afterScreenUpdates: false)
        snapShotView?.frame = view.convert(selectedCell!.frame, from: collectionView)
        selectedCell?.isHidden = true
        view.addSubview(snapShotView!)
        //执行动画
        moveAction(snapShotView: snapShotView!, selectedCell: selectedCell!)
    }
    
    func moveAction(snapShotView: UIView, selectedCell: CustomCell) {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            self.snapShotView?.frame = self.view.convert(self.targetImgView.frame, from: self.view)
        }) { (finished) in
            snapShotView.isHidden = true
            self.targetImgView.image = selectedCell.backImgView.image
        }
    }
    
    func backAction(snapShotView: UIView, selectedCell: CustomCell) {
        targetImgView.image = UIImage()
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            self.snapShotView?.frame = self.view.convert(selectedCell.frame, from: self.collectionView)
        }) { (finished) in
            selectedCell.isHidden = false
            snapShotView.removeFromSuperview()
        }
    }
    
}
