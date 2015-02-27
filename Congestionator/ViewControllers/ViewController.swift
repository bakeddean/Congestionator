//
//  ViewController.swift
//  Congestionator
//
//  Created by Dean Woodward on 27/02/15.
//  Copyright (c) 2015 Datacom. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.delegate = self
        loadCongestionLocations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Post data
    
    func loadCongestionLocations() {
        ContentService.sharedInstance.getCongestionLocations(
            success: {(congestionLocations) -> () in
                //self.refreshControl.endRefreshing()
                
//                self.posts = posts + self.posts
//                var indexPaths = [NSIndexPath]()
//                for index in 0..<posts.count {
//                    let indexPath = NSIndexPath(forRow: index, inSection: 0)
//                    indexPaths.append(NSIndexPath(forRow: index, inSection: 0))
//                }
//                self.collectionView?.insertItemsAtIndexPaths(indexPaths)
                for congestionLocation in congestionLocations {
                    var thumbnail = JPSThumbnail()
                    thumbnail.image = UIImage(named: "Cat")
                    thumbnail.title = congestionLocation.name
                    //thumbnail.subtitle = congestionLocation
                    thumbnail.coordinate = congestionLocation.coordinate
                    thumbnail.imageUrl = congestionLocation.imageUrl
                    thumbnail.disclosureBlock = { self.loadImage(congestionLocation) }
                    self.mapView.addAnnotation(JPSThumbnailAnnotation(thumbnail: thumbnail))
                }
            },
            failure: {(errorResponse, operation) -> () in
                //self.refreshControl.endRefreshing()
            }
        )
    }
    
    func loadImage(congestionLocation: CongestionLocation) {
        var navController = storyboard?.instantiateViewControllerWithIdentifier("ImageNavigationController") as UINavigationController
        var expandedView = navController.childViewControllers.first! as ExpandedImageViewController
        expandedView.setCongestionLocation(congestionLocation)
        presentViewController(navController, animated: true, completion: nil)
    }
}

extension ViewController: MKMapViewDelegate {

    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        if view is JPSThumbnailAnnotationView {
            (view as JPSThumbnailAnnotationView).didSelectAnnotationViewInMap(mapView)
        }
    }
    
    func mapView(mapView: MKMapView!, didDeselectAnnotationView view: MKAnnotationView!) {
        if view is JPSThumbnailAnnotationView {
            (view as JPSThumbnailAnnotationView).didDeselectAnnotationViewInMap(mapView)
        }
    }

    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if annotation is JPSThumbnailAnnotation {
            var annotationView = (annotation as JPSThumbnailAnnotation).annotationViewInMap(mapView)
            var annotationView2 = annotationView as JPSThumbnailAnnotationView
            //annotationView 2.imageView.image = sd
//            let bob = annotation as JPSThumbnailAnnotation
//            let jim = bob.a
//            annotationView2.imageView.sd_setImageWithURL(NSURL(string: (annotation as JPSThumbnailAnnotation).imageUrl))
            return (annotation as JPSThumbnailAnnotation).annotationViewInMap(mapView)
        }
        return nil
    }
    

}

