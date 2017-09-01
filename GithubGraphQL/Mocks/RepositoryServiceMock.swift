//
//  RepositoryServiceMock.swift
//  GithubGraphQL
//
//  Created by TechFlitter on 08/08/17.
//  Copyright © 2017 TechFlitter. All rights reserved.
//

import Apollo

class RepositoryServiceMock: RepositoryService {
    private let totlaCount: Int
    private let repositories: [RepositoryDetail]
    
    init(totalRepositories: Int, repositories: [RepositoryDetail]) {
        self.totlaCount = totalRepositories
        self.repositories = repositories
    }
    
    override func getRepositories(queryString: String, recordsPerPage: Int, callBack: @escaping (Int, [RepositoryDetail], String?) -> Void) {
        callBack(totlaCount, repositories, nil)
    }
    
}
