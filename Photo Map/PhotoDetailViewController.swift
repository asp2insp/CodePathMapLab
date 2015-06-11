//
//  PhotoDetailViewController.swift
//  Photo Map
//
//  Created by Josiah Gaskin on 6/10/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import Foundation

class PhotoDetailViewController : UIViewController {
    var image : UIImage!
    
    @IBOutlet weak var detailImageView: UIImageView!
    override func viewDidLoad() {
        detailImageView.image = self.image
    }
    
    @IBAction func didTapDone(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}