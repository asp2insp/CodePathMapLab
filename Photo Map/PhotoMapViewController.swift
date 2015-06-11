//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Chen NC on 6/10/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cameraButton: UIButton!
    
    var chosenImage : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1)), animated: false)
        //one degree of latitude is approximately 111 kilometers (69 miles) at all times.
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didTapCameraButton(sender: AnyObject) {
        var vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
//        vc.sourceType = UIImagePickerControllerSourceType.Camera
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
            var originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            var editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            self.chosenImage = editedImage
            picker.dismissViewControllerAnimated(true, completion: nil)
            performSegueWithIdentifier("tagWithLocation", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationController = segue.destinationViewController as! LocationsViewController
        destinationController.image = self.chosenImage
    }
}
