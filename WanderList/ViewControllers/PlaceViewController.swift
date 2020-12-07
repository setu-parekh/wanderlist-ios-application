//
//  PlaceViewController.swift
//  WanderList
//
//  Created by Neel B Gandhi on 11/27/20.
//

import UIKit

class PlaceViewController: UIViewController {

    // MARK: Variables and Properties
    var place:Place?
    
    lazy var infoViewController:InfoViewController = {
        let infoVC = self.storyboard?.instantiateViewController(identifier: Constants.INFO_VIEW_CONTROLLER) as! InfoViewController
        
        return infoVC
    }()
    
    lazy var mapViewController:MapViewController = {
        let mapVC = self.storyboard?.instantiateViewController(identifier: Constants.MAP_VIEW_CONTROLLER) as! MapViewController
        
        return mapVC
    }()
    
    lazy var notesViewController:NotesViewController = {
        let notesVC = self.storyboard?.instantiateViewController(identifier: Constants.NOTES_VIEW_CONTROLLER) as! NotesViewController
        
        return notesVC
    }()
    
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    
    // MARK: View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Set the image of the place
        if place?.imageName != nil {
            placeImageView.image = UIImage(named: place!.imageName!)
        }
        
        // Set the name of the place
        placeNameLabel.text = place?.name
        
        // Make sure that first segment is displayed
        segmentChanged(self.segmentedControl)
    }

    // MARK: Methods
    private func switchChildViewControllers(_ childVC:UIViewController) {
        // Add InfoViewController as a child controller
        addChild(childVC)
        
        // Add InfoViewController's view as a subview of the container view
        containerView.addSubview(childVC.view)
        
        // Set InfoViewController's frame and sizing
        childVC.view.frame = containerView.bounds
        childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Indicate that InfoViewController is now a child view controller
        childVC.didMove(toParent: self)
    }

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            infoViewController.place = self.place
            switchChildViewControllers(infoViewController)
        case 1:
            mapViewController.place = self.place
            switchChildViewControllers(mapViewController)
        case 2:
            notesViewController.place = self.place
            switchChildViewControllers(notesViewController)
        default:
            infoViewController.place = self.place
            switchChildViewControllers(infoViewController)
        }
        
    }
}
