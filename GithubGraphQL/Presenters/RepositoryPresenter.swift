//
//  RepositoryPresenter.swift
//  GithubGraphQL
//
//  Created by TechFlitter on 08/08/17.
//  Copyright © 2017 TechFlitter. All rights reserved.
//

class RepositoryPresenter {
    private let recordsPerPage = 20
    private let baseString: String = "is:public"
    
    private let repositoryService: RepositoryService
    weak private var repositoryView: RepositoryView?
    private var repositoriesViewData = [RepositoryViewData]()
    
    init(repositoryService: RepositoryService) {
        self.repositoryService = repositoryService
    }
    
    func attachView(view: RepositoryView) {
        repositoryView = view
    }
    
    func detachView() {
        repositoryView = nil
    }
	
    func getRepositories(queryString: String, isClearResult: Bool) {
		if (isClearResult) {
            self.repositoriesViewData.removeAll()
			self.repositoryView?.startLoading()
		}
        
        let finalQuery = baseString.appending(" \(queryString) in:name")
		repositoryService.getRepositories(queryString: finalQuery, recordsPerPage: recordsPerPage) {
            (totalRepository, repositories, error) in
            
			if (isClearResult) {
				self.repositoryView?.finishLoading()
			}
			
            if (error != nil) {
                self.repositoryView?.setErrorRepositories(error: error!)
                return
            }
            
			let mappedRepositories = repositories.map {
				return RepositoryViewData(name: $0.name, ownerName: $0.nameWithOwner, createdAt: $0.createdAt,
					description: $0.description, descriptionHtml: $0.descriptionHtml, homepageUrl: $0.homepageUrl)
			}
			self.repositoriesViewData.append(contentsOf: mappedRepositories)
			self.repositoryView?.setRepositories(repositories: self.repositoriesViewData)
			
			if (self.repositoriesViewData.count == 0) {
				self.repositoryView?.setEmptyRepositories()
			}
		}
	}

}
