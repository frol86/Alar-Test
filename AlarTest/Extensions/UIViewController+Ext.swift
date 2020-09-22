//
//  UIViewController+Ext.swift
//  AlarTest
//
//  Created by Oleg Frolov on 22.09.2020.
//

import UIKit

extension UIViewController {
    
    func activityIndicatory(show: Bool) {
        if show {
            let container: UIView = UIView()
            container.tag = 1
            container.frame = view.frame
            container.center = view.center
            container.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            
            let loadingView: UIView = UIView()
            loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            loadingView.center = view.center
            loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            loadingView.clipsToBounds = true
            loadingView.layer.cornerRadius = 10
            
            let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
            indicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
            indicator.style =
                UIActivityIndicatorView.Style.whiteLarge
            indicator.center = CGPoint(x: loadingView.frame.size.width / 2,
                                       y: loadingView.frame.size.height / 2);
            loadingView.addSubview(indicator)
            container.addSubview(loadingView)
            view.addSubview(container)
            indicator.startAnimating()
        } else {
            let container = view.viewWithTag(1)
            container?.removeFromSuperview()
        }
    }
    
}


