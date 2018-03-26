//
//  ViewController.swift
//  LocationTask
//
//  Created by Robert Berry on 3/26/18.
//  Copyright © 2018 Robert Berry. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: Properties
    
    let locationManager = CLLocationManager()
    
    // Labels
    
    @IBOutlet weak var latitudeLabel: UILabel!
    
    @IBOutlet weak var longitudeLabel: UILabel!
    
    @IBOutlet weak var geocodeAddressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func findLocation(_ sender: UIButton) {
        
        // The view controller class is set as the delegate for the location manager.
        
        locationManager.delegate = self
        
        // Set the location accuracy.
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Specifies that the location data should only be read when the app is in the foreground.
        
        locationManager.requestWhenInUseAuthorization()
        
        // Method begins the generation of location updates.
        
        locationManager.startUpdatingLocation()
    }
    
    // MARK: CLLocationManager Delegates
    
    // Method is called when when location updates are available.
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Pass the location coordinates.
        
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placemarks, error) in
            
            if (error != nil) {
                
                print("Error: " + error!.localizedDescription)
                return
            }
            
            // Displays location details.
            
            if placemarks!.count > 0 {
                
                let placemark = placemarks![0] as CLPlacemark
                
                self.displayLocationDetails(placemark: placemark, location: manager.location!)
                
            } else {
                
                print("Error retrieving data")
            }
        }
    }
    
    // Method called in case of an error receiving location updates.
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("Error: " + error.localizedDescription)
    }
    
    func displayLocationDetails(placemark: CLPlacemark, location: CLLocation) {
        
        locationManager.stopUpdatingLocation()
        
        // Print location information to the console.
        
        print("Latitude: \(location.coordinate.latitude)")
        print("Longitude: \(location.coordinate.longitude)")
        print("Locality: \(placemark.locality!). Postal Code: \(placemark.postalCode!), Administrative Area: \(placemark.administrativeArea!), Country: \(placemark.country!)")
        
        // Update labels to display location information to the user.
        
        latitudeLabel.text = "Latitude: \(location.coordinate.latitude)"
        longitudeLabel.text = "Longitude: \(location.coordinate.longitude)"
        geocodeAddressLabel.text = "City: \(placemark.locality!). Postal Code: \(placemark.postalCode!), Administrative Area: \(placemark.administrativeArea!), Country: \(placemark.country!)"
    }
    
}

