class GistGraphQl {
  static const String gist = r'''query user($login: String!) {
    user(login: $login) {
      gists(first: 30) {
        totalCount
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