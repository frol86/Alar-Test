//
//  UIImageView+Ext.swift
//  AlarTest
//
//  Created by Oleg Frolov on 22.09.2020.
//

import UIKit

extension UIImageView {
    
    func generateImage() {
        let url = URL(string: "https://loremflickr.com/50/50/sky")!
        self.image = UIImage(named: "placeholder")
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
