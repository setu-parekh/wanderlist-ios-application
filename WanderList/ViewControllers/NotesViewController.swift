//
//  NotesViewController.swift
//  WanderList
//
//  Created by Neel B Gandhi on 11/27/20.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {
    // MARK: Variables and Properties
    var place:Place?
    
    // Get a reference to core data context and app delegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // Declare a Notes View Results Controller
    var fetchedNotesRC:NSFetchedResultsController<Note>?
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshNotes()
    }
    
    // MARK: Methods
    func refreshNotes() {
        // Check if there is a place set
        if let placeForNote = place {
            // Get a fetch request for Notes with specific place
            let request:NSFetchRequest<Note> = Note.fetchRequest()
            request.predicate = NSPredicate(format: "place = %@", placeForNote)
            
            // Set a sort descriptor
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]
            
            // Create a fetched results controller
            fetchedNotesRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            
            // Execute the fetch
            do {
                try fetchedNotesRC!.performFetch()
            }
            catch {
                print("Failed to fetch notes results controller")
            }
            
            // Tell the table view in Notes View Controller to refresh the data
            tableView.reloadData()
        }
    }
    
    @IBAction func addNoteTapped(_ sender: Any) {
        // Display the popup to add note
        let addNoteVC = storyboard?.instantiateViewController(identifier: Constants.ADD_NOTE_VIEW_CONTROLLER) as! AddNoteViewController
        
        // Set self as delegate so we can be notified that a new note is added
        addNoteVC.delegate = self
        
        // Pass the place object through to the AddNoteViewController
        addNoteVC.place = place
        
        // Configure the popup mode
        addNoteVC.modalPresentationStyle = .overCurrentContext
        
        // Present the popup
        present(addNoteVC, animated: true, completion: nil)
    }
}

extension NotesViewController: AddNoteDelegate {
    func noteAdded() {
        // Refetch the notes data from Core Data and display in table view
        refreshNotes()
    }
}

extension NotesViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchedNotesRC?.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Display the popup to update existing note
        let addNoteVC = storyboard?.instantiateViewController(identifier: Constants.ADD_NOTE_VIEW_CONTROLLER) as! AddNoteViewController
        
        // Set self as delegate so we can be notified that a new note is added
        addNoteVC.delegate = self
        
        // Pass the place object and note object through to the AddNoteViewController
        addNoteVC.place = place
        addNoteVC.note = fetchedNotesRC?.object(at: indexPath)
        
        // Configure the popup mode
        addNoteVC.modalPresentationStyle = .overCurrentContext
        
        // Present the popup
        present(addNoteVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NOTE_CELL, for: indexPath)
        
        // Get references to date and text labels
        let dateLabel = cell.viewWithTag(1) as! UILabel
        let noteLabel = cell.viewWithTag(2) as! UILabel
        
        // Get the details for this indexPath
        let note = fetchedNotesRC?.object(at: indexPath)
        
        if let noteData = note {
            let df = DateFormatter()
            df.dateFormat = "MMM d, yyyy - h:mm a"
            
            dateLabel.text = df.string(from: noteData.date!)
            noteLabel.text = noteData.text
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            
            if self.fetchedNotesRC == nil {
                // Nothing to delete
                return
            }
            
            // Get a refrence to the note to be deleted
            let note = self.fetchedNotesRC!.object(at: indexPath)
            
            // Pass it to the Core Data context delete method
            self.context.delete(note)
            
            // Save the context
            self.appDelegate.saveContext()
            
            // Refetch the notes and refresh table view
            self.refreshNotes()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
