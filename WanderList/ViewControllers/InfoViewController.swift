//
//  InfoViewController.swift
//  WanderList
//
//  Created by Neel B Gandhi on 11/27/20.
//

import UIKit

class InfoViewController: UIViewController {

    // MARK: Variables and Properties
    var place:Place?
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    
    // MARK: View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        summaryLabel.text = place?.summary
    }
}
