//
//  RepositoryService.swift
//  GithubGraphQL
//
//  Created by TechFlitter on 08/08/17.
//  Copyright © 2017 TechFlitter. All rights reserved.
//

import Apollo

let graphQLEndpoint = "https://api.github.com/graphql?access_token=eb80eb981a7f7c07cec12d1ae53fc8a5aba53124"
let apollo = ApolloClient(url: URL(string: graphQLEndpoint)!)

class RepositoryService {
    var cursor: String?
    var allPublicRespositoriesWatcher: GraphQLQueryWatcher<AllPublicRespositoriesQuery>?
    
    func getRepositories(queryString: String, recordsPerPage: Int, callBack:@escaping (Int, [RepositoryDetail], String?) -> Void) {
        var repositories: [RepositoryDetail] = [RepositoryDetail]()
        var totalCounts: Int = 0
        
        let allPublicRepositoriesQuery = AllPublicRespositoriesQuery(queryString: queryString,
                                                                     recordsPerPage: recordsPerPage, cursor: cursor)
        allPublicRespositoriesWatcher = apollo.watch(query: allPublicRepositoriesQuery) { result, error in
            if (error != nil) {
                callBack(totalCounts, repositories, error?.localizedDescription)
                return
            }
            
            totalCounts = (result?.data?.search.repositoryCount)!
            for edge in (result?.data?.search.edges)! {
                self.cursor = edge?.cursor
                let repositoryDetail: RepositoryDetail = (edge?.node?.fragments.repositoryDetail)!
                repositories.append(repositoryDetail)
            }
            
            callBack(totalCounts, repositories, nil)
        }
    }
}
