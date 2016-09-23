//
//  ProfileViewController.swift
//  Founders Directory
//
//  Created by Steve Liddle on 9/22/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//
//  See http://bit.ly/2da8gxb for discussion of this animation pattern
//

import UIKit

class ProfileViewController : UIViewController {
    
    // MARK: - Constants
    
    struct Animation {
        static let Duration = 0.2
    }

    struct Size {
        static let InfoCellHeight: CGFloat = 114
        static let MaxFontSize: CGFloat = 15
        static let MinFontSize: CGFloat = 28
        static let MaxHeaderHeight: CGFloat = 280
        static let MinHeaderHeight: CGFloat = 166
        static let MaxImageHeight: CGFloat = 80
        static let MinImageHeight: CGFloat = 40
        static let MaxImageOffset: CGFloat = 8
        static let MinImageOffset: CGFloat = 4
        static let MaxSubtitleHeight: CGFloat = 38
        static let MinSubtitleHeight: CGFloat = 0
        // NEEDSWORK: calculate from profile text size; set high currently to test scrolling
        static let ProfileCellHeight: CGFloat = 400
        static let SubtitleLineHeight: CGFloat = 19
    }
    
    struct Storyboard {
        static let InfoCellIdentifier = "InfoCell"
        static let ProfileCellIdentifier = "ProfileCell"
    }

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageOffsetConstraint: NSLayoutConstraint!
    @IBOutlet weak var subtitleHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var callButton: CircleImageButton!
    @IBOutlet weak var callButtonLabel: UILabel!
    @IBOutlet weak var emailButton: CircleImageButton!
    @IBOutlet weak var emailButtonLabel: UILabel!
    @IBOutlet weak var textButton: CircleImageButton!
    @IBOutlet weak var textButtonLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    // MARK: - Properties

    var founder: Founder!
    var maxHeaderHeight = Size.MaxHeaderHeight
    var maxSubtitleHeight = Size.MaxSubtitleHeight
    var minHeaderHeight = Size.MinHeaderHeight
    var minSubtitleHeight = Size.MinSubtitleHeight
    var previousScrollOffset: CGFloat = 0

    // MARK: - View controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        imageView.applyCircleMask()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.makeBarTransparent()
        headerHeightConstraint.constant = maxHeaderHeight
        updateHeader()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? EditProfileViewController {
            destVC.founder = founder
        }
    }

    // MARK: - Helpers

    private func updateUI() {
        imageView.image = UIImage(named: founder.imageUrl)
        nameLabel.text = founder.preferredFullName

        var subtitleText = ""

        if founder.preferredFirstName.characters.count > 0 {
            subtitleText = "“\(founder.preferredFirstName)”"
        } else {
            maxHeaderHeight -= Size.SubtitleLineHeight
            maxSubtitleHeight -= Size.SubtitleLineHeight
        }

        if founder.organizationName.characters.count > 0 {
            if subtitleText.characters.count > 0 {
                subtitleText += "\n"
            }

            subtitleText += founder.organizationName
        } else {
            maxHeaderHeight -= Size.SubtitleLineHeight
            maxSubtitleHeight -= Size.SubtitleLineHeight
        }

        subtitleLabel.text = subtitleText

        callButton.setEnabledState(founder.isPhoneListed, including: callButtonLabel)
        textButton.setEnabledState(founder.isPhoneListed, including: textButtonLabel)
        emailButton.setEnabledState(founder.isEmailListed, including: emailButtonLabel)

        if founder.email != "chewie@gmail.com" {
            navigationItem.rightBarButtonItem = nil
        }
    }

    // MARK: - Actions

    @IBAction func callPhone(_ sender: UIButton) {
        if founder.isPhoneListed && founder.cell.characters.count > 0 {
            if let url = URL(string: "tel://\(founder.cell)") {
                UIApplication.shared.open(url)
            }
        }
    }

    @IBAction func sendEmail(_ sender: UIButton) {
        if founder.isEmailListed && founder.email.characters.count > 0 {
            if let url = URL(string: "mailto://\(founder.email)") {
                UIApplication.shared.open(url)
            }
        }
    }

    @IBAction func sendText(_ sender: UIButton) {
        if founder.isPhoneListed && founder.cell.characters.count > 0 {
            if let url = URL(string: "sms://\(founder.cell)") {
                UIApplication.shared.open(url)
            }
        }
    }
}

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
                profileCell.biographyLabel.text = founder.biography.characters.count > 0 ?
                    founder.biography :
                    "This is not the Founder you're looking for.  You can go about your business.  Move along... move along."
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

// MARK: - Table view delegate

extension ProfileViewController : UITableViewDelegate {

    // MARK: - Scroll view delegate

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidStopScrolling()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidStopScrolling()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = scrollView.contentOffset.y - previousScrollOffset
        let absoluteTop: CGFloat = 0;
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;
        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom

        var newHeight = headerHeightConstraint.constant

        if isScrollingDown {
            newHeight = max(Size.MinHeaderHeight, headerHeightConstraint.constant - abs(scrollDiff))
        } else if isScrollingUp {
            newHeight = min(Size.MaxHeaderHeight, headerHeightConstraint.constant + abs(scrollDiff))
        }

        if newHeight != headerHeightConstraint.constant {
            headerHeightConstraint.constant = newHeight
            updateHeader()
            setScrollPosition(position: previousScrollOffset)
        }

        previousScrollOffset = scrollView.contentOffset.y
    }

    func scrollViewDidStopScrolling() {
        let midPoint = minHeaderHeight + ((maxHeaderHeight - minHeaderHeight) / 2)

        if headerHeightConstraint.constant > midPoint {
            expandHeader()
        } else {
            collapseHeader()
        }
    }

    // MARK: - Helpers

    private func collapseHeader() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: Animation.Duration) {
            self.headerHeightConstraint.constant = self.minHeaderHeight
            self.updateHeader()
            self.view.layoutIfNeeded()
        }
    }

    private func expandHeader() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: Animation.Duration) {
            self.headerHeightConstraint.constant = self.maxHeaderHeight
            self.updateHeader()
            self.view.layoutIfNeeded()
        }
    }

    private func setScrollPosition(position: CGFloat) {
        tableView.contentOffset = CGPoint(x: tableView.contentOffset.x, y: position)
    }

    func updateHeader() {
        let range = maxHeaderHeight - minHeaderHeight
        let openAmount = headerHeightConstraint.constant - minHeaderHeight
        let percentage = openAmount / range

        imageHeightConstraint.constant = Size.MinImageHeight + percentage * (Size.MaxImageHeight - Size.MinImageHeight)
        imageOffsetConstraint.constant = Size.MinImageOffset + percentage * (Size.MaxImageOffset - Size.MinImageOffset)
        subtitleHeightConstraint.constant = minSubtitleHeight + percentage * (maxSubtitleHeight - minSubtitleHeight)

        nameLabel.font = UIFont(name: ".SFUIDisplay", size: Size.MaxFontSize - percentage * (Size.MaxFontSize - Size.MinFontSize))!
        subtitleLabel.alpha = percentage
    }
}
