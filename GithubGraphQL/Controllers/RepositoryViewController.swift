
//
//  RepositoryViewController.swift
//  GithubGraphQL
//
//  Created by TechFlitter on 08/08/17.
//  Copyright © 2017 TechFlitter. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class RepositoryViewController: UIViewController {
	let fetchThreshold = 5
	var canFetchMoreResults = true
    
	@IBOutlet weak var infoLabel: UILabel!
	@IBOutlet weak var infoView: UIView!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!
    
	fileprivate let repositoryPresenter = RepositoryPresenter(repositoryService: RepositoryService())
	fileprivate var repositoriesToDisplay = [RepositoryViewData]() {
		didSet {
			tableView.reloadData()
		}
	}
	
	let activityData = ActivityData(size: CGSize(width: 40, height: 40),
	                                message: nil,
	                                type: NVActivityIndicatorType(rawValue: 16),
	                                color: UIColor.white,
	                                padding: 0,
	                                minimumDisplayTime: 10,
	                                textColor: UIColor.white)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationItem.title = NSLocalizedString("Github Repositories", comment: "")
		
        searchBar.tintColor = UIColor.darkGray
        tableView.dataSource = self
		tableView.delegate = self
		
		let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
		spinner.startAnimating()
		spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: (self.tableView.bounds.width), height: CGFloat(44))
		self.tableView.tableFooterView = spinner
		self.tableView.tableFooterView?.isHidden = true
		self.tableView.rowHeight = UITableViewAutomaticDimension
		self.tableView.estimatedRowHeight = 1000

		repositoryPresenter.attachView(view: self)
		repositoryPresenter.getRepositories(queryString: "", isClearResult: true)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
    @IBAction func retryFetchRepositories() {
        tableView.isHidden = true
        infoView.isHidden = true
        repositoryPresenter.getRepositories(queryString: searchBar.text ?? "", isClearResult: true)
    }
    
	@IBAction func fetchRepositories() {
		tableView.isHidden = true
		infoView.isHidden = true
		repositoryPresenter.getRepositories(queryString: searchBar.text ?? "", isClearResult: false)
	}
}

extension RepositoryViewController: RepositoryView {
	func startLoading() {
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
        tableView.isHidden = true
        infoView.isHidden = true
		NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
	}
	
	func finishLoading() {
		UIApplication.shared.isNetworkActivityIndicatorVisible = false
		NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
	}
	
	func setRepositories(repositories: [RepositoryViewData]) {
		UIApplication.shared.isNetworkActivityIndicatorVisible = false
		self.tableView.tableFooterView?.isHidden = true
		
		if (repositories.count == repositoriesToDisplay.count) {
			canFetchMoreResults = false;
			return
		}
		
		repositoriesToDisplay = repositories
		tableView.isHidden = false
		infoView.isHidden = true;
	}
    
    func setErrorRepositories(error: String) {
        infoLabel.text = error
        tableView.isHidden = true
        infoView.isHidden = false;
    }
	
	func setEmptyRepositories() {
        infoLabel.text = NSLocalizedString("No repositories found!", comment: "")
		tableView.isHidden = true
		infoView.isHidden = false;
	}
}

extension RepositoryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        canFetchMoreResults = true
        repositoriesToDisplay.removeAll()
        searchBar.resignFirstResponder()
        repositoryPresenter.getRepositories(queryString: searchBar.text ?? "", isClearResult: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        canFetchMoreResults = true
        repositoriesToDisplay.removeAll()
        searchBar.resignFirstResponder()
        repositoryPresenter.getRepositories(queryString: "", isClearResult: true)
    }
    
}

extension RepositoryViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return repositoriesToDisplay.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "repositoryCell")
		let repositoryViewData = repositoriesToDisplay[indexPath.row]
		cell.textLabel?.text = repositoryViewData.name
		cell.textLabel?.font = UIFont(name: "OpenSans", size: 14.0)
		cell.textLabel?.numberOfLines = 0

		cell.detailTextLabel?.text = repositoryViewData.createdAt
		cell.detailTextLabel?.font = UIFont(name: "OpenSans", size: 12.0)
		
		cell.selectionStyle = .none
		cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let repositoryViewData = repositoriesToDisplay[indexPath.row]
		let repositoryDetailViewController: RepositoryDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "RepositoryDetailViewController") as! RepositoryDetailViewController
		repositoryDetailViewController.repositoryViewData = repositoryViewData
		self.navigationController?.pushViewController(repositoryDetailViewController, animated: true)
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if (repositoriesToDisplay.count - indexPath.row) == fetchThreshold && canFetchMoreResults {
			UIApplication.shared.isNetworkActivityIndicatorVisible = true
			self.tableView.tableFooterView?.isHidden = false
			repositoryPresenter.getRepositories(queryString: searchBar.text ?? "", isClearResult: false)
		}
	}
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
	
}

