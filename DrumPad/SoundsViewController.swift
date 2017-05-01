//
//  SoundsViewController.swift
//  DrumPad
//
//  Created by Jared Annibale on 4/28/17.
//  Copyright © 2017 Jared Annibale. All rights reserved.
//

import UIKit
import AVFoundation

class SoundsViewController: UITableViewController, UISearchResultsUpdating {
    
    
    var parentController: ViewController?
    var filteredSounds = [String]()
    let soundNames = ["Clap 1", "Clap 2", "Clap 3", "Clap 4", "Clap 5",
                      "Clave 1", "Clave 2",
                      "Conga 1", "Conga 2", "Conga 3", "Conga 4", "Conga 5",
                      "Cowbell 1", "Cowbell 2", "Cowbell 3",
                      "DJ Scratch",
                      "Dog Bark",
                      "FIRE!",
                      "Harp 1", "Harp 2", "Harp 3", "Harp 4",
                      "HiHat 1", "HiHat 2", "HiHat 3", "HiHat 4", "HiHat 5",
                      "Kick 1", "Kick 2", "Kick 3", "Kick 4", "Kick 5", "Kick 6", "Kick 7", "Kick 8",
                      "Luigi",
                      "Mario",
                      "Open HiHat 1", "Open HiHat 2", "Open HiHat 3", "Open HiHat 4",
                      "Snare 1", "Snare 2", "Snare 3", "Snare 4", "Snare 5",
                      "Tom 1", "Tom 2", "Tom 3",
                      "Voice",
                      "Yeah! 1",
                      "Yeah! 2"]
    var tag = 0
    
    var selectedName = ""
    var player = AVAudioPlayer()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed))
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search sounds"
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return self.filteredSounds.count
        } else {
            return self.soundNames.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.textLabel?.text = filteredSounds[indexPath.row]
            if filteredSounds[indexPath.row] == selectedName {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        } else {
            cell.textLabel?.text = soundNames[indexPath.row]
            if soundNames[indexPath.row] == selectedName {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            
            let name = filteredSounds[indexPath.row]
            
            playSound(soundName: name, audioPlayer: &player)
            selectedName = filteredSounds[indexPath.row]
        } else {
            
            let name = soundNames[indexPath.row]
            
            playSound(soundName: name, audioPlayer: &player)
            selectedName = soundNames[indexPath.row]
        }
        
        
        self.tableView.reloadData()
    }
    
    func cancelPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func donePressed() {
        
        //grab sound string name
        let controller = parentController!
        
        switch tag {
        case 1:
            controller.soundOne = selectedName
        case 2:
            controller.soundTwo = selectedName
        case 3:
            controller.soundThree = selectedName
        case 4:
            controller.soundFour = selectedName
        case 5:
            controller.soundFive = selectedName
        case 6:
            controller.soundSix = selectedName
        default:
            return
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) {
        if let sound = NSDataAsset(name: soundName) {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("Error: Data from \(soundName) could not be played as an audio file.")
            }
        } else {
            print("Error: Could not load data file.")
        }
    }
    
    
    func filteredSounds(searchText: String) {
        
        self.filteredSounds = soundNames.filter({ (sound) -> Bool in
            let mSound = sound.lowercased()
            return mSound.contains(searchText.lowercased())
        })
        
        self.tableView.reloadData()
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredSounds(searchText: searchController.searchBar.text!)
    }
    
}

