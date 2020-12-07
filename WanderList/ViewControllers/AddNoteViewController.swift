//
//  AddNoteViewController.swift
//  WanderList
//
//  Created by Neel B Gandhi on 11/28/20.
//

import UIKit
import CoreData


protocol AddNoteDelegate {
    func noteAdded()
}


class AddNoteViewController: UIViewController {

    // MARK: Variables and Properties
    
    var place:Place?
    var note:Note?
    var delegate:AddNoteDelegate?
    
    // Get a reference to core data context and app delegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    
    // MARK: View controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        cardView.layer.cornerRadius = 5
        cardView.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.8)
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 5
        
        // If current note is not nil, that means user is updating an existing note.
        // Set the current note text so user can see it by default.
        if note != nil {
            textView.text = note?.text
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Methods
    
    @IBAction func cancelTapped(_ sender: Any) {
        // Dismiss the pop up
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        // Check if the note already exists
        if note != nil {
            // Configure the properties
            note!.date = Date()
            note!.text = textView.text
            note!.place = place
        }
        else {
            // Check if the note text is empty. In this case, user tapped add new note but saved the note without adding any text. Hence, do not save this note in DB.
            if textView.text == "" {
                // Dismiss the pop up and return
                dismiss(animated: true, completion: nil)
                return
            }
            
            // Create a new note
            let note = Note(context: context)
            
            // Configure the properties
            note.date = Date()
            note.text = textView.text
            note.place = place
        }
        
        // User has added something in the new note or has updated existing note. So save it in DB.
        saveContext()
    }
    
    func saveContext() {
        // Save the core data context
        appDelegate.saveContext()
        
        // Let the delegate know that a new note was added
        delegate?.noteAdded()
        
        // Dismiss the pop up
        dismiss(animated: true, completion: nil)
    }
}
