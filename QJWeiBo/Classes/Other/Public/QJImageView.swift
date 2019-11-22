//
//  QJImageView.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/22.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJImageView: UIImageView {

    var maximumZoomScale : CGFloat = 1.0
    var minimumZoomScale : CGFloat = 1.0
    var zoomScale : CGFloat {
        return zoomScale_tm
    }
    private var zoomScale_tm:CGFloat = 1.0

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /** 图片缩放 */
    func zoom(scale:CGFloat , zoomCenter loction:CGPoint) {
        if scale > 1.0 { // 更改锚点，动画的缩放中收
            let imageViewFrame = self.frame
            self.layer.anchorPoint = CGPoint(x: loction.x / imageViewFrame.size.width, y: loction.y / imageViewFrame.size.height)
            self.frame = imageViewFrame
        }
        // 指定的缩放大小
        UIView.animate(withDuration: 0.5) {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        zoomScale_tm = scale
        if scale > maximumZoomScale {
            zoomScale_tm = maximumZoomScale
            UIView.animate(withDuration: 0.5) {
                self.transform = CGAffineTransform(scaleX: self.maximumZoomScale, y: self.maximumZoomScale)
            }
        } else if(scale < minimumZoomScale) {
            zoomScale_tm = minimumZoomScale
            UIView.animate(withDuration: 0.5) {
                self.transform = CGAffineTransform(scaleX: self.minimumZoomScale, y: self.minimumZoomScale)
            }
        }
    }
}
