//
//  ViewController.swift
//  Congestionator
//
//  Created by Dean Woodward on 27/02/15.
//  Copyright (c) 2015 Datacom. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    private var congestionLocations = [CongestionLocation]()
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        loadCongestionLocations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Congestion Location data
    
    func loadCongestionLocations() {
        ContentService.sharedInstance.getCongestionLocations(
            success: {(congestionLocations) -> () in
                self.congestionLocations = congestionLocations
                
                for congestionLocation in congestionLocations {
                    var thumbnail = JPSThumbnail()
                    thumbnail.image = UIImage(named: "Cat")
                    thumbnail.title = congestionLocation.name
                    thumbnail.coordinate = congestionLocation.coordinate
                    thumbnail.imageUrl = congestionLocation.imageUrl
                    thumbnail.disclosureBlock = { self.loadImage(congestionLocation) }
                    self.mapView.addAnnotation(JPSThumbnailAnnotation(thumbnail: thumbnail))
                }
                
                self.mapView.setVisibleMapRect(self.mapRectForCongestionLocations(congestionLocations), edgePadding: UIEdgeInsetsMake(74, 10, 50, 10), animated: true)

            },
            failure: {(errorResponse, operation) -> () in
                //self.refreshControl.endRefreshing()
            }
        )
    }
    
    func mapRectForCongestionLocations(congestionLocations: [CongestionLocation]) -> MKMapRect {
        let rectToDisplay = congestionLocations.reduce(MKMapRectNull) { (mapRect: MKMapRect, congestionLocation: CongestionLocation) -> MKMapRect in
            let collectorPointRect = MKMapRect(origin: congestionLocation.mapPoint, size: MKMapSize(width: 0, height: 0))
            return MKMapRectUnion(mapRect, collectorPointRect)
        }
        return rectToDisplay
    }
    
    func loadImage(congestionLocation: CongestionLocation) {
        var navController = storyboard?.instantiateViewControllerWithIdentifier("ImageNavigationController") as UINavigationController
        var expandedView = navController.childViewControllers.first! as ExpandedImageViewController
        expandedView.setCongestionLocation(congestionLocation)
        presentViewController(navController, animated: true, completion: nil)
    }
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {

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
            //var annotationView = (annotation as JPSThumbnailAnnotation).annotationViewInMap(mapView)
            //var annotationView2 = annotationView as JPSThumbnailAnnotationView
            return (annotation as JPSThumbnailAnnotation).annotationViewInMap(mapView)
        }
        return nil
    }
    

}

