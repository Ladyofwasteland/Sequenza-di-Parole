//
//  GameTableViewController.swift
//  Project1
//
//  Created by Eugenia Consoli on 16/03/22.
//

import UIKit

class GameTableViewController: UITableViewController {
    
    var selectedGame: String?
    var words = [String]()
    var solutionWords = [String]()
    var newTitle : String?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedGame
        newTitle = title?.replacingOccurrences(of: ".txt", with: "")
        title = newTitle
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "pexels-steve-johnson-1843717.jpg"))

        // upload game
        if let startWordsURL = Bundle.main.url(forResource: newTitle, withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                words = startWords.components(separatedBy: "\n")
            }
        }
        
        // upload solution
        if
            let title = newTitle,
            let solutionWordsURL = Bundle.main.url(forResource: "Soluzione \(title)", withExtension: "txt") {
        
            if let solution = try? String(contentsOf: solutionWordsURL) {
                solutionWords = solution.components(separatedBy: "\n")
            }
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.setEditing(true, animated: true)
        
    }
    
    func Solution(){
        
        if (words == solutionWords) {
            let ac = UIAlertController(title: title, message: "HAI VINTO!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continua", style: .default))
            present(ac, animated: true)
        }
    }

    // number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }

    
    // label row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = words[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = .boldSystemFont(ofSize: 16)
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        return cell
    }
    
    // Can Move Row
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Move Row
    override func tableView(_ tableView: UITableView, moveRowAt indexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = words[indexPath.row]
        words.remove(at: indexPath.row)
        words.insert(itemToMove, at: destinationIndexPath.row)
        Solution()
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}
