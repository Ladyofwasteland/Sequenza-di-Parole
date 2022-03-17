//
//  ViewController.swift
//  Project1
//
//  Created by Eugenia Consoli on 11/03/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var games = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sequenza di Parole"
        navigationController?.navigationBar.prefersLargeTitles = true //large title
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "pexels-steve-johnson-1843717.jpg"))
        
        let infoButton = UIButton(type: .infoDark)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: infoButton)
        self.navigationItem.rightBarButtonItem = barButton
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("Gioco") {
                games.append(item)
            }
        }
        
        games = games.sorted(by: <)
        
    }
    
    // game rules
    @objc func infoButtonTapped() {
        let info = UIAlertController(title: "Regole", message: "Parti dalla parola indicata con INIZIO, raggiungi quella indicata con FINE, riordinando le parole incluse, in base alle regole: \n * La parola può essere un anagramma della precedente. \n * Può essere un sinonimo o un contrario. \n * La si può ottenere aggiungendo, togliendo o cambiando una lettera della parola precendente. \n * Può unirsi alla parola precedente tramite un detto, una similitudine, una metafora o un'associazione di idee. \n * Può formare, con la precedente, il nome di una persona famosa, un luogo reale o immaginario. \n * Può associarsi alla parola nel titolo o nella trama di un libro, opera teatrale o letteraria, o altri componimenti vari. \n Buon divertimento!", preferredStyle: .actionSheet)
        info.addAction(UIAlertAction(title: "Continua", style: .default))
        present(info, animated: true)
    }
    
    // number of row
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return games.count
    }
     
    // label row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Games", for: indexPath)
        cell.textLabel?.text = games[indexPath.row].replacingOccurrences(of: ".txt", with: "")
        cell.textLabel?.font = .boldSystemFont(ofSize: 16)
        cell.backgroundColor = UIColor.white.withAlphaComponent(0)
        
        return cell
    }
        
    // select row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Game") as?
                GameTableViewController {
                vc.selectedGame = games[indexPath.row]
                navigationController?.pushViewController(vc, animated: true)
                
            }
    }
    
}



