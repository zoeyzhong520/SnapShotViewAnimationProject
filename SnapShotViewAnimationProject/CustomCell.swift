//
//  CustomCell.swift
//  SnapShotViewAnimationProject
//
//  Created by zhifu360 on 2019/5/24.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    ///创建UIImageView
    lazy var backImgView: UIImageView = {
        let imgView = UIImageView(frame: self.bounds)
        imgView.layer.cornerRadius = 3
        imgView.clipsToBounds = true
        imgView.contentMode = UIView.ContentMode.scaleAspectFill
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(backImgView)
    }
    
    ///创建Cell
    class func createCellWith(collection: UICollectionView, indexPath: IndexPath, imageName: String) -> CustomCell {
        guard let cell = collection.dequeueReusableCell(withReuseIdentifier: BaseCollectReuseIdentifier, for: indexPath) as? CustomCell else { fatalError() }
        cell.backImgView.image = UIImage(named: imageName)
        return cell
    }
    
}
