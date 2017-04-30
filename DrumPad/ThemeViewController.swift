//
//  ThemeViewController.swift
//  DrumPad
//
//  Created by Jared Annibale on 4/28/17.
//  Copyright © 2017 Jared Annibale. All rights reserved.
//

import Foundation
import UIKit


class ThemeViewController: UITableViewController {
    
    var parentController: ViewController?
    var selectedTheme: Theme = bostonCollege
    
    
    
    
    
    override func viewDidLoad() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed))
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = themes[indexPath.row].name
        
        if selectedTheme.name == themes[indexPath.row].name {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        selectedTheme = themes[indexPath.row]
              
        self.tableView.reloadData()
    }
    
    func cancelPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func donePressed() {
        
        parentController?.updateColors(selectedTheme: selectedTheme)
        self.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
}
