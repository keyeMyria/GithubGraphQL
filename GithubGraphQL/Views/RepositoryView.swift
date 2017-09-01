//
//  RepositoryView.swift
//  GithubGraphQL
//
//  Created by TechFlitter on 08/08/17.
//  Copyright © 2017 TechFlitter. All rights reserved.
//

import Apollo

protocol RepositoryView: NSObjectProtocol {
    func setRepositories(repositories: [RepositoryViewData])
    func setErrorRepositories(error: String)
    func setEmptyRepositories()
    func startLoading()
    func finishLoading()
}
