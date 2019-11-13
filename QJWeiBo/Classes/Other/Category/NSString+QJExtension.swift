//
//  NSString+QJExtension.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/13.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

extension NSString {
    func size(maxWidth:CGFloat , textFont:UIFont) -> CGSize {
        return boundingRect(with: CGSize(width: maxWidth, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin , .usesFontLeading], attributes: [.font:textFont], context: nil).size
    }
}
