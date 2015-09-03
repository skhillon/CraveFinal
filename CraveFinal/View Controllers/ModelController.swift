//
//  ModelController.swift
//  PageBased
//
//  Created by Sarthak Khillon on 8/31/15.
//  Copyright (c) 2015 Sarthak Khillon. All rights reserved.
//

import UIKit

/*
A controller object that manages a simple model -- a collection of month names.

The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.

There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
*/

// FIX: This whole setup is excessive for your needs. Seriously, just a single VC in storyboard would have been fine, heck even just an overlay on the CategoryVC with the intro info would have been fine.
// The info on your second pageView isn't very informative beyond what the user will already see when they actually do it. I'd just remove it.
// Made a quick mockup of a simple static page intro scene above yours in storyboard

// FIX: Also, organizationally, this is not a VC, so shouldn't be in this folder

class ModelController: NSObject, UIPageViewControllerDataSource {
    
    var pageData: NSArray = ["Welcome to Crave", "Getting started is as easy as 1, 2, 3"]
    //var imageData: NSArray = ["One Finger-100.png", "Ingredients-100.png", "Restaurant-100.png"]
    var detailsArray = ["Crave lets you find food based on what ingredients you know you want. \n\nSwipe left to learn more or press Get Started.",
        "1. Choose the types of food you're willing to eat. You can select up to 5 food categories. \n\n2. Select the ingredients you know you want in your meal. \n\n3. See results and go eat!"]
    
    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> DataViewController? {
        // Return the data view controller for the given index.
        if (self.pageData.count == 0) || (index >= self.pageData.count) {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewControllerWithIdentifier("DataViewController") as! DataViewController
        dataViewController.dataObject = self.pageData[index]
        //dataViewController.iconImage = UIImage(named: self.imageData[index] as! String)
        dataViewController.detailText = detailsArray[index]
        dataViewController.pageIndex = index
        return dataViewController
    }
    
    func indexOfViewController(viewController: DataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        if let dataObject: AnyObject = viewController.dataObject {
            return self.pageData.indexOfObject(dataObject)
        } else {
            return NSNotFound
        }
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if index == NSNotFound {
            return nil
        }
        
        index++
        if index == self.pageData.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
}

