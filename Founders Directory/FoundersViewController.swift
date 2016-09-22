//
//  FoundersViewController.swift
//  Founders Directory
//
//  Created by Steve Liddle on 9/21/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import UIKit

class FoundersViewController : UITableViewController {
    
    // MARK: - Constants
    
    private struct Storyboard {
        static let CellIdentifier = "FounderCell"
        static let CornerRadius: CGFloat = 30
        static let ViewSegueIdentifier = "ViewProfile"
    }

    // MARK: - Properties
    
    var founders = [
        Founder(name: "Chewbacca",
                company: "Millennial Enterprises",
                phone: "801-787-9015",
                email: "chewie@gmail.com",
                photoName: "founder1",
                spouseName: "Chewette",
                profile: "Chewbacca, nicknamed \"Chewie\", is a fictional character in the Star Wars franchise. He is a Wookiee, a tall, hirsute biped and intelligent species from the planet Kashyyyk. Chewbacca is the loyal friend and associate of Han Solo, and serves as co-pilot on Solo's ship, the Millenium Falcon."),
        Founder(name: "Leia Organa",
                company: "Death Stars R Us",
                phone: "408-555-1212",
                email: "leia@gmail.com",
                photoName: "founder2",
                spouseName: "Han",
                profile: ""),
        Founder(name: "Han Solo",
                company: "Millennial Enterprises",
                phone: "946-555-1212",
                email: "han@gmail.com",
                photoName: "founder3",
                spouseName: "Leia",
                profile: ""),
        Founder(name: "Luke Skywalker",
                company: "Forceful Feed Co.",
                phone: "385-555-1212",
                email: "luke@gmail.com",
                photoName: "founder4",
                spouseName: "",
                profile: "")
        
    ]

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? ProfileViewController {
            if let indexPath = sender as? IndexPath {
                destVC.founder = founders[indexPath.row]
            }
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.CellIdentifier, for: indexPath)
        let founder = founders[indexPath.row]

        cell.textLabel?.text = founder.name
        cell.detailTextLabel?.text = founder.company
        
        if let imageView = cell.imageView {
            // Note that when we use one of the default tableview cell types, we get the
            // imageview property for free.  Here we load it from one of the pre-loaded
            // image assets and then make it circular by setting the corner radius.
            imageView.image = UIImage(named: founder.photoName)
            imageView.layer.cornerRadius = Storyboard.CornerRadius
            imageView.layer.masksToBounds = true
            imageView.layer.borderColor = UIColor.gray.cgColor
            imageView.layer.borderWidth = 1.0
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return founders.count
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Storyboard.ViewSegueIdentifier, sender: indexPath)
    }
}
