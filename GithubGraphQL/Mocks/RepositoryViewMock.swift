//
//  RepositoryViewMock.swift
//  GithubGraphQL
//
//  Created by TechFlitter on 08/08/17.
//  Copyright © 2017 TechFlitter. All rights reserved.
//

import Apollo

class RepositoryViewMock : NSObject, RepositoryView {
    var setRepositoriesCalled = false
    var setErrorRepositoriesCalled = false
    var setEmptyRepositoriesCalled = false
    
    func setRepositories(repositories: [RepositoryViewData]) {
        setRepositoriesCalled = true
    }

    func setErrorRepositories(error: String) {
        setErrorRepositoriesCalled = true
    }
    
    func setEmptyRepositories() {
        setEmptyRepositoriesCalled = true
    }
    
    func startLoading() {
    
    }
    
    func finishLoading() {
    
    }
}
