class GistGraphQl {
  static const String gist = r'''query user($login: String!, $endCursor: String) {
    user(login: $login) {
      gists(first: 10, orderBy: {field: CREATED_AT, direction: DESC}, after: $endCursor) {
        totalCount
        pageInfo {
          endCursor
          hasNextPage
        }
        nodes {
          ... on Gist {
            owner {
              login
              avatarUrl
            }
          }
          files {
            name
            extension
          }
          description
          createdAt
          isFork
          isPublic
          name
          stargazers {
            totalCount
          }
          updatedAt
          pushedAt
        }
      }
    }
  }
''';
}