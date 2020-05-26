//
//  File.swift
//  WorldTrotter
//
//  Created by Anatolii Tomazov on 16/11/2019.
//  Copyright © 2019 Anatolii Tomazov. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    
    
    override func loadView() {
          super.loadView()
          mapView = MKMapView()
          
          view = mapView
        
        let standartString = NSLocalizedString("Standard", comment: "Standard map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let segmentedControl = UISegmentedControl(items: [standartString,satelliteString,hybridString])
        
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let segmentControl = UISegmentedControl(items: ["Standart", "Hybrid", "Satellite"])
        segmentControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentControl.selectedSegmentIndex = 0
        
        segmentControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentControl)
        
        let topConstraint = segmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
       

        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
}
