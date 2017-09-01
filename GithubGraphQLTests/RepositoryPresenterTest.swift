//
//  RepositoryPresenterTest.swift
//  GithubGraphQL
//
//  Created by TechFlitter on 08/08/17.
//  Copyright © 2017 TechFlitter. All rights reserved.
//

import XCTest
@testable import GithubGraphQL

class RepositoryPresenterTest: XCTestCase {
    
    let emptyRepositoriesServiceMock = RepositoryServiceMock(totalRepositories:0, repositories:[RepositoryDetail]())
    
    func testShouldSetUsers() {
        //given
        let repositoryViewMock = RepositoryViewMock()
        let repositoryPresenterUnderTest = RepositoryPresenter(repositoryService: emptyRepositoriesServiceMock)
        repositoryPresenterUnderTest.attachView(view: repositoryViewMock)
        
        //when
        repositoryPresenterUnderTest.getRepositories(queryString: "", isClearResult: true)
        
        //verify
        XCTAssertTrue(repositoryViewMock.setEmptyRepositoriesCalled)
    }
}
