class GistGraphQl {
  static const String gist = r'''query user($login: String!) {
    user(login: $login) {
      gists(first: 30, orderBy: {field: CREATED_AT, direction: DESC}) {
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