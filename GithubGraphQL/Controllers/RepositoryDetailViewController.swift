//
//  RepositoryDetailViewController.swift
//  GithubGraphQL
//
//  Created by TechFlitter on 08/08/17.
//  Copyright © 2017 TechFlitter. All rights reserved.
//

import UIKit
import SafariServices

class RepositoryDetailViewController: UIViewController, SFSafariViewControllerDelegate {
	var repositoryViewData:RepositoryViewData?
	
	@IBOutlet weak var tableView: UITableView!
	
	@IBOutlet weak var scrollView: UIScrollView!

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var homeUrlButton: UIButton!

	@IBOutlet weak var repoDetailView: UIView!
	@IBOutlet weak var repoHeightConstraint: NSLayoutConstraint!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		self.title = NSLocalizedString("Repository Detail", comment: "")
		
		self.tableView.rowHeight = UITableViewAutomaticDimension
		self.tableView.estimatedRowHeight = 1000
		self.tableView.tableFooterView = UIView()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	@IBAction func homeUrlPressed(_ sender: UIButton) {
		if (sender.title(for: .normal) != NSLocalizedString("Homepage url not available", comment: "")) {
            if let homePageUrl = repositoryViewData!.homepageUrl as String! {
                if (homePageUrl.contains("http")) {
                    let safariViewController = SFSafariViewController.init(url: URL(string: homePageUrl)!)
                    safariViewController.delegate = self
                    
                    if #available(iOS 10.0, *) {
                        safariViewController.preferredControlTintColor = .darkGray
                    } else {
                        safariViewController.view.tintColor = .darkGray
                    }
                    
                    self.present(safariViewController, animated: true, completion: nil)
                }
            }
		}
	}

	func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
		self.dismiss(animated: true, completion: nil)
	}
}

extension RepositoryDetailViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 3
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = RepoDetailTableViewCell()
		if (indexPath.section == 0) {
			cell = tableView.dequeueReusableCell(withIdentifier: "nameCell") as! RepoDetailTableViewCell
			cell.repoNameLabel.text = repositoryViewData!.name
			cell.createdAtLabel.text = repositoryViewData!.createdAt
		}
		else if (indexPath.section == 1) {
			cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as! RepoDetailTableViewCell
            if let name = repositoryViewData!.name as String! {
                cell.descriptionLabel.text = name
            }
            else {
                cell.descriptionLabel.text = NSLocalizedString("Description not available", comment: "")
            }
		}
		else {
			cell = tableView.dequeueReusableCell(withIdentifier: "urlCell") as! RepoDetailTableViewCell
            if let homepageUrl = repositoryViewData!.homepageUrl {
                if (homepageUrl.characters.count) > 0 {
                    cell.urlButton.setTitle(homepageUrl, for: .normal)
                }
                else {
                    cell.urlButton.setTitle(NSLocalizedString("Homepage url not available", comment: ""), for: .normal)
                    cell.urlButton.isEnabled = false
                }
            }
            else {
                cell.urlButton.setTitle(NSLocalizedString("Homepage url not available", comment: ""), for: .normal)
                cell.urlButton.isEnabled = false
            }
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
}
