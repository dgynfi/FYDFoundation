//
//  FYDProgressHud.swift
//
//  Created by dyf on 16/2/16.
//  Copyright © 2016 dyf. All rights reserved.
//

import UIKit

open class FYDProgressHud: NSObject, MBProgressHUDDelegate {
    
    private var hud: MBProgressHUD?
    
    open class var `default`: FYDProgressHud {
        struct Static {
            static let instance: FYDProgressHud = FYDProgressHud()
        }
        return Static.instance
    }
    
    public func hasHud() -> Bool {
        return self.hud != nil ? true : false
    }
    
    public func show(view: UIView, text: String, detailsText: String? = nil) {
        self.show(view: view, text: text, detailsText: detailsText, mode: MBProgressHUDModeIndeterminate, animationType: MBProgressHUDAnimationFade, customView: nil)
    }
    
    public func showCustomSpinner(view: UIView, text: String, detailsText: String? = nil) {
        self.show(view: view, text: text, detailsText: detailsText, mode: MBProgressHUDModeCustomView, animationType: MBProgressHUDAnimationFade, customView: spinner())
    }
    
    public func show(view: UIView, text: String, detailsText: String?, mode: MBProgressHUDMode, animationType aniType: MBProgressHUDAnimation, customView: UIView?) {
        hud = MBProgressHUD.showAdded(to: view, animated: true)
        
        hud?.opacity      = 0.8
        hud?.margin       = 10.0
        hud?.cornerRadius = 10.0
        
        hud?.labelText  = text
        if detailsText != nil {
            hud?.detailsLabelText = detailsText!
        }
        
        hud?.delegate      = self
        hud?.animationType = aniType
        hud?.mode          = mode
        
        if customView != nil {
            hud?.customView = customView
        }
        
        hud?.show(true)
    }
    
    public func hide() {
        hud?.hide(true)
    }
    
    public func hudWasHidden(_ hud: MBProgressHUD!) {
        
        if self.hud != nil && self.hud! === hud {
            self.hud!.removeFromSuperview()
            self.hud = nil
        }
    }
    
    public func showTip(view: UIView, text: String?, timeInterval: TimeInterval = 2.0) {
        if (text != nil && !text!.isEmpty) {
            let _hud: MBProgressHUD = MBProgressHUD.showAdded(to: view, animated: true)
            
            _hud.cornerRadius  = 5.0
            _hud.margin        = 10.0
            _hud.mode          = MBProgressHUDModeCustomView
            _hud.animationType = MBProgressHUDAnimationZoom
            _hud.customView    = textLabel(text: text!)
            
            _hud.removeFromSuperViewOnHide = true
            _hud.hide(true, afterDelay: timeInterval)
        }
    }
    
    private func spinner() -> DYFMaterialDesignSpinner {
        let spinner: DYFMaterialDesignSpinner = DYFMaterialDesignSpinner()
        
        spinner.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        spinner.lineWidth = 3.0
        spinner.lineColor = UIColor.white
        spinner.startAnimating()
        
        return spinner
    }
    
    private func textLabel(text: String) -> UILabel {
        let label: UILabel    = UILabel()
        label.text            = text
        label.textColor       = UIColor.white
        label.font            = UIFont.boldSystemFont(ofSize: isPhone() ? 14.0 : 16.0)
        label.textAlignment   = NSTextAlignment.center
        label.numberOfLines   = isPhone() ? 2 : 3
        label.backgroundColor = UIColor.clear
        label.lineBreakMode   = NSLineBreakMode.byCharWrapping
        
        let height: CGFloat = isPhone() ? 60.0  : 80.0
        let fitSize: CGSize = label.sizeThatFits(CGSize(width: CGFloat(MAXFLOAT),
                                                        height: height))
        let width: CGFloat  = fitSize.width + 10.0
        
        label.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        return label
    }
    
    fileprivate func isPhone() -> Bool {
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone {
            return true
        }
        return false
    }
    
}
