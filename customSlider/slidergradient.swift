//
//  slidergradient.swift
//  customSlider
//
//  Created by Appnap WS02 on 28/10/19.
//  Copyright © 2019 Appnap WS02. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable class GradientSlider: UISlider {
    
    @IBInspectable var thickness: CGFloat = 20 {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var sliderThumbImage: UIImage? {
        didSet {
            setup()
        }
    }
    
    func setup() {
        let minTrackStartColor = UIColor(red: 239.0 / 255.0, green: 7.0 / 255.0, blue: 122.0 / 255.0, alpha: 1.0)// Palette.SelectiveYellow
        let minTrackEndColor = UIColor(red: 1.0, green: 106.0 / 255.0, blue: 0.0, alpha: 1.0)
        let maxTrackColor = UIColor.white//Palette.Firefly
        do {
            self.setMinimumTrackImage(try self.gradientImage(
                size: self.trackRect(forBounds: self.bounds).size,
                colorSet: [minTrackStartColor.cgColor, minTrackEndColor.cgColor]),
                                      for: .normal)
            self.setMaximumTrackImage(try self.gradientImage(
                size: self.trackRect(forBounds: self.bounds).size,
                colorSet: [maxTrackColor.cgColor, maxTrackColor.cgColor]),
                                      for: .normal)
            self.setThumbImage(sliderThumbImage, for: .normal)
        } catch {
            self.minimumTrackTintColor = minTrackStartColor
            self.maximumTrackTintColor = maxTrackColor
        }
    }
    
    func gradientImage(size: CGSize, colorSet: [CGColor]) throws -> UIImage? {
        let tgl = CAGradientLayer()
        tgl.frame = CGRect.init(x:0, y:0, width:size.width, height: size.height)
        tgl.cornerRadius = tgl.frame.height / 2
        tgl.masksToBounds = false
        tgl.colors = colorSet
        tgl.startPoint = CGPoint.init(x:0.0, y:0.5)
        tgl.endPoint = CGPoint.init(x:1.0, y:0.5)
        
        UIGraphicsBeginImageContextWithOptions(size, tgl.isOpaque, 0.0);
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        tgl.render(in: context)
        let image =
            
            UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets:
                UIEdgeInsets.init(top: 0, left: size.height, bottom: 0, right: size.height))
        UIGraphicsEndImageContext()
        return image!
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(
            x: bounds.origin.x,
            y: bounds.origin.y,
            width: bounds.width,
            height: thickness
        )
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
}
