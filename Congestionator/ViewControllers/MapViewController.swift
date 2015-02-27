//
//  ViewController.swift
//  Congestionator
//
//  Created by Dean Woodward on 27/02/15.
//  Copyright (c) 2015 Datacom. All rights reserved.
//

import UIKit
import MapKit

var mapViewController: MapViewController!

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    private var congestionLocations = [CongestionLocation]()
    
    var dummyImageView: UIImageView!
    var timer: NSTimer?
    var counter = 0
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        loadCongestionLocations()
        
        dummyImageView = UIImageView()
        dummyImageView.hidden = true
        view.addSubview(dummyImageView)
        
        mapViewController = self
        
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("loadImages"), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        timer = NSTimer.scheduledTimerWithTimeInterval(15, target: self, selector: Selector("loadImages"), userInfo: nil, repeats: true)
//    }
    
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
    
    func loadImages() {
        println("In load images")
        let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: NSURL!) -> () in
            println("In block")
                if cacheType == .None {
                    println("Downloaed from the web")
//                    var bob = mapViewController.congestionLocations.filter(){
//                        return $0.imageUrl! == imageURL
//                    }
                    var jim = mapViewController.congestionLocations[mapViewController.counter]
                    //jim.storedImages.append(mapViewController.dummyImageView.image!)
                    jim.storedImages.append(image)
                    mapViewController.counter = ++mapViewController.counter % (mapViewController.congestionLocations.count - 1)
                }
                //mapViewController.counter = ++mapViewController.counter % (mapViewController.congestionLocations.count - 1)
            }
        //let url = NSURL(string: congestionLocation.imageUrl!)
        if !congestionLocations.isEmpty {
//            for congestionLocation in congestionLocations {
//                let url = NSURL(string: congestionLocation.imageUrl!)
//                println("URL: \(url)")
//                dummyImageView.sd_setImageWithURL(url, placeholderImage: nil, options: .RefreshCached, completed: block)
//            }
            var alfred = congestionLocations[counter]
            let url = NSURL(string: alfred.imageUrl!)
            println("URL: \(url)")
            dummyImageView.sd_setImageWithURL(url, placeholderImage: nil, options: .RefreshCached, completed: block)
            
        }
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

