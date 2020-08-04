class PullRequestQraphQl {
  static const String pullRequests = r'''query user($login: String!){
    user(login: $login) {
      login
      pullRequests(first: 30, orderBy: {field: CREATED_AT, direction: DESC}) {
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
}