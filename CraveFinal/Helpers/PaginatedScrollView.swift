//
//  PaginatedScrollView.swift
//  CraveFinal
//
//  Created by Sarthak Khillon on 8/15/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit

// FIX: What's going on here? Doesn't seem to be being used.
class PaginatedScrollView: UIScrollView {
    
    var images: [UIImage]? {
        didSet {
            displayImages(images)
        }
    }
    
    func displayImages(images: [UIImage]?) {
        
        self.pagingEnabled = true // enable paging effect
        
        if let images = images {
            
            self.contentSize = CGSizeMake(self.frame.size.width * CGFloat(images.count), self.frame.size.height) // Set amount of room in scrollview to scroll around
            
            for var i = 0; i < images.count; i++ {
                
                let image = images[i]
                let imageView = UIImageView(image: image)
                imageView.frame = CGRectMake(self.frame.size.width * CGFloat(i), 0, self.frame.size.width, self.frame.size.height)
                imageView.contentMode = .ScaleAspectFit // Size image according to scrollview size
                imageView.clipsToBounds = true // don't let big images take up more space
                self.addSubview(imageView)
            }
            
        }
    }
    
}