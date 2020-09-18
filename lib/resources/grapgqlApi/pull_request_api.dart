class PullRequestQraphQl {
  static const String pullRequests = r'''query user($login: String!, $endCursor: String) {
    user(login: $login) {
      login
      pullRequests(first: 10, orderBy: {field: CREATED_AT, direction: DESC}, after: $endCursor) {
        pageInfo {
          endCursor
          hasNextPage
        }
        nodes {
          number
          closed
          title
          author {
            login
            avatarUrl
            url
          }
          repository {
            nameWithOwner
          }
          viewerDidAuthor
          state
          closedAt
          createdAt
          deletions
          files {
            totalCount
          }
        }
        totalCount
      }
    }
  }
''';

  static const String repoPullRequest = r'''query repo($name: String!, $owner: String!, $endCursor: String) {
    repository(name: $name, owner: $owner) {
      ... on Repository {
        pullRequests(first: 10, orderBy: {field: CREATED_AT, direction: DESC}, after: $endCursor) {
          pageInfo {
            endCursor
            hasNextPage
          }
          nodes {
            number
            closed
            title
            author {
              login
              avatarUrl
              url
            }
            repository {
              nameWithOwner
            }
            viewerDidAuthor
            state
            closedAt
            createdAt
            deletions
            files {
              totalCount
            }
          }
          totalCount
        }
      }
    }
  }
''';
}