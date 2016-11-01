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

    var founders = FounderDatabase.shared.founders()

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        founders[0].preferredFirstName = "Chewie"
        founders[1].isPhoneListed = false
        
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

        if let founderCell = cell as? FounderCell {
            founderCell.founderNameLabel?.text = founder.preferredFullName
            founderCell.founderCompanyLabel?.text = founder.organizationName
            
            if let imageView = founderCell.founderImageView {
                // Note that when we use one of the default tableview cell types, we get the
                // imageview property for free.  Here we load it from one of the pre-loaded
                // image assets and then make it circular by setting the corner radius.
                imageView.image = UIImage(named: founder.imageUrl)
                imageView.layer.cornerRadius = Storyboard.CornerRadius
                imageView.layer.masksToBounds = true
            }
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
