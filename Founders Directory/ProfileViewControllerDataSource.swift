//
//  ProfileViewControllerDataSource.swift
//  Founders Directory
//
//  Created by Steve Liddle on 9/28/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import UIKit

// MARK: - Table view data source

extension ProfileViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row <= 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.InfoCellIdentifier, for: indexPath)
            
            if let infoCell = cell as? InfoCell {
                infoCell.emailLabel.text = founder.isEmailListed ? founder.email : ""
                infoCell.phoneLabel.text = founder.isPhoneListed ? founder.cell : ""
                
                if founder.spousePreferredFullName == "" {
                    infoCell.spouseNameIndicatorLabel.isHidden = true
                    infoCell.spouseNameLabel.isHidden = true
                } else {
                    infoCell.spouseNameIndicatorLabel.isHidden = false
                    infoCell.spouseNameLabel.isHidden = false
                    infoCell.spouseNameLabel.text = founder.spousePreferredFullName
                }
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.ProfileCellIdentifier, for: indexPath)
            
            if let profileCell = cell as? ProfileCell {
                profileCell.biographyLabel.text = founder.biography.length > 0 ?
                    founder.biography :
                "This is not the Founder you're looking for.  You can go about your business.  Move along... move along."
                profileCell.founderLevelLabel.text = founder.status
                profileCell.yearSinceLabel.text = founder.yearJoined
            }
            
            return cell
        }
    }
    
    @objc(tableView:heightForRowAtIndexPath:)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row <= 0 {
            return Size.InfoCellHeight
        } else {
            return Size.ProfileCellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}
