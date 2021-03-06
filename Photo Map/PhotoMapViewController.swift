//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Chen NC on 6/10/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationsViewDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cameraButton: UIButton!
    
    var chosenImage : UIImage!
    
    var images : [String:UIImage] = [:]
    
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
        // use camera for real device
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
        if segue.identifier == "showDetail" {
            let destinationController = segue.destinationViewController as! PhotoDetailViewController
            destinationController.image = self.chosenImage
        } else {
            let destinationController = segue.destinationViewController as! LocationsViewController
            destinationController.delegate = self
        }
    }
    
    func onSelectLocation(latitude: Double, longtitude: Double, locationName: String) {
        let annotation = MKPointAnnotation()
        let locationCoordinate = CLLocationCoordinate2DMake(latitude, longtitude)
        annotation.coordinate = locationCoordinate
        annotation.title = locationName
        mapView.addAnnotation(annotation)
        mapView.setCenterCoordinate(locationCoordinate, animated: true)
        images[locationName] = chosenImage
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        let name = view.annotation.title!
        self.chosenImage = images[name]
        performSegueWithIdentifier("showDetail", sender: self)
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let reuseID = "myAnnotationView"
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID)
        if (annotationView == nil) {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            annotationView.canShowCallout = true
            annotationView.leftCalloutAccessoryView = UIImageView(frame: CGRect(x:0, y:0, width: 50, height:50))
            let detailButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIButton
            annotationView.rightCalloutAccessoryView = detailButton
        }
        
        let imageView = annotationView.leftCalloutAccessoryView as! UIImageView
        imageView.image = images[annotation.title!]
        
        
        return annotationView
    }
    
}
