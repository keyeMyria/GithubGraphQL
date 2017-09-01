//  This file was automatically generated and should not be edited.

import Apollo

public final class AllPublicRespositoriesQuery: GraphQLQuery {
  public static let operationDefinition =
    "query AllPublicRespositories($queryString: String!, $recordsPerPage: Int!, $cursor: String) {" +
    "  search(query: $queryString, type: REPOSITORY, first: $recordsPerPage, after: $cursor) {" +
    "    __typename" +
    "    repositoryCount" +
    "    edges {" +
    "      __typename" +
    "      cursor" +
    "      node {" +
    "        __typename" +
    "        ...RepositoryDetail" +
    "      }" +
    "    }" +
    "  }" +
    "}"
  public static let queryDocument = operationDefinition.appending(RepositoryDetail.fragmentDefinition)

  public let queryString: String
  public let recordsPerPage: Int
  public let cursor: String?

  public init(queryString: String, recordsPerPage: Int, cursor: String? = nil) {
    self.queryString = queryString
    self.recordsPerPage = recordsPerPage
    self.cursor = cursor
  }

  public var variables: GraphQLMap? {
    return ["queryString": queryString, "recordsPerPage": recordsPerPage, "cursor": cursor]
  }

  public struct Data: GraphQLMappable {
    /// Perform a search across resources.
    public let search: Search

    public init(reader: GraphQLResultReader) throws {
      search = try reader.value(for: Field(responseName: "search", arguments: ["query": reader.variables["queryString"], "type": "REPOSITORY", "first": reader.variables["recordsPerPage"], "after": reader.variables["cursor"]]))
    }

    public struct Search: GraphQLMappable {
      public let __typename: String
      /// The number of repositories that matched the search query.
      public let repositoryCount: Int
      /// A list of edges.
      public let edges: [Edge?]?

      public init(reader: GraphQLResultReader) throws {
        __typename = try reader.value(for: Field(responseName: "__typename"))
        repositoryCount = try reader.value(for: Field(responseName: "repositoryCount"))
        edges = try reader.optionalList(for: Field(responseName: "edges"))
      }

      public struct Edge: GraphQLMappable {
        public let __typename: String
        /// A cursor for use in pagination.
        public let cursor: String
        /// The item at the end of the edge.
        public let node: Node?

        public init(reader: GraphQLResultReader) throws {
          __typename = try reader.value(for: Field(responseName: "__typename"))
          cursor = try reader.value(for: Field(responseName: "cursor"))
          node = try reader.optionalValue(for: Field(responseName: "node"))
        }

        public struct Node: GraphQLMappable {
          public let __typename: String

          public let fragments: Fragments

          public init(reader: GraphQLResultReader) throws {
            __typename = try reader.value(for: Field(responseName: "__typename"))

            let repositoryDetail = try RepositoryDetail(reader: reader, ifTypeMatches: __typename)
            fragments = Fragments(repositoryDetail: repositoryDetail)
          }

          public struct Fragments {
            public let repositoryDetail: RepositoryDetail?
          }
        }
      }
    }
  }
}

public struct RepositoryDetail: GraphQLNamedFragment {
  public static let fragmentDefinition =
    "fragment RepositoryDetail on Repository {" +
    "  __typename" +
    "  id" +
    "  name" +
    "  nameWithOwner" +
    "  isPrivate" +
    "  createdAt" +
    "  description" +
    "  descriptionHTML" +
    "  homepageUrl" +
    "}"

  public static let possibleTypes = ["Repository"]

  public let __typename: String
  public let id: GraphQLID
  /// The name of the repository.
  public let name: String
  /// The repository's name with owner.
  public let nameWithOwner: String
  /// Identifies if the repository is private.
  public let isPrivate: Bool
  /// Identifies the date and time when the object was created.
  public let createdAt: String
  /// The description of the repository.
  public let description: String?
  /// The description of the repository rendered to HTML.
  public let descriptionHtml: String
  /// The repository's URL.
  public let homepageUrl: String?

  public init(reader: GraphQLResultReader) throws {
    __typename = try reader.value(for: Field(responseName: "__typename"))
    id = try reader.value(for: Field(responseName: "id"))
    name = try reader.value(for: Field(responseName: "name"))
    nameWithOwner = try reader.value(for: Field(responseName: "nameWithOwner"))
    isPrivate = try reader.value(for: Field(responseName: "isPrivate"))
    createdAt = try reader.value(for: Field(responseName: "createdAt"))
    description = try reader.optionalValue(for: Field(responseName: "description"))
    descriptionHtml = try reader.value(for: Field(responseName: "descriptionHTML"))
    homepageUrl = try reader.optionalValue(for: Field(responseName: "homepageUrl"))
  }
}