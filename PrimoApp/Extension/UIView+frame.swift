//
//  UIView+frame.swift
//  PrimoApp
//
//  Created by Perm on 15/4/2567 BE.
//

import Foundation
import UIKit

let screen_width    = UIScreen.main.bounds.size.width
let screen_height   = UIScreen.main.bounds.size.height

var top_safearea    : CGFloat {
    if #available(iOS 15.0, *) {
        if let safeAreaInsets = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets {
            return safeAreaInsets.top
        }
    }
    return UIApplication.shared.windows.first?.window?.safeAreaInsets.top ?? 0
}
var bottom_safearea : CGFloat {
    if #available(iOS 15.0, *) {
        if let safeAreaInsets = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets {
            return safeAreaInsets.bottom
        }    }
    return UIApplication.shared.windows.first?.window?.safeAreaInsets.bottom ?? 0
}

extension UIView {
    var x: CGFloat {
        set { self.frame.origin.x = newValue }
        get { return self.frame.origin.x}
    }
    var y: CGFloat {
        set { self.frame.origin.y = newValue }
        get { return self.frame.origin.y}
    }
    var width: CGFloat {
        set { self.frame.size.width = newValue }
        get { return self.frame.size.width}
    }
    var height: CGFloat {
        set { self.frame.size.height = newValue }
        get { return self.frame.size.height}
    }
    var bottom: CGFloat {
        get { self.y+self.height }
    }
    var trailing: CGFloat {
        get { self.x+self.width }
    }
}
