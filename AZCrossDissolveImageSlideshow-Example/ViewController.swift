//
//  ViewController.swift
//  AZCrossDissolveImageSlideshow-Example
//
//  Created by ApolloZhu on 2019/7/23.
//
//  Copyright (c) 2019 Zhiyu Zhu/朱智语/ApolloZhu
//  Copyright (c) 2019 XiangWuShuo
//  MIT License.
//

import UIKit
import AZCrossDissolveImageSlideshow
import ImageSlideshow

class ViewController: UIViewController {
    @IBOutlet weak var imageSlideshow: AZCrossDissolveImageSlideshow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageSlideshow.setImageInputs([
            ImageSource(image: #imageLiteral(resourceName: "0")),
            ImageSource(image: #imageLiteral(resourceName: "1")),
            ImageSource(image: #imageLiteral(resourceName: "2"))
        ])
        
        imageSlideshow.crossFadeDuration = 0.5
        imageSlideshow.crossFadeInterval = 2.0
        imageSlideshow.contentScaleMode = .scaleAspectFill
        
        for item in imageSlideshow.slideshowItems {
            item.imageView.cornerRadius = 10
        }
        imageSlideshow.configurePreviewImageView = { imageView in
            imageView.cornerRadius = 10
        }
    }
}

extension UIView {
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = cornerRadius != 0
        }
    }
}
