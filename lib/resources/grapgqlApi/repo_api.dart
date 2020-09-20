class RepoApi {
  static const String repositoryDetail =
      r'''query userInfo($name: String!, $owner: String!) {
    repository(name: $name, owner: $owner) {
      owner {
        login
        avatarUrl
        url
      }
      name
      createdAt
      description
      forkCount
      homepageUrl
      isArchived
      isDisabled
      isEmpty
      isFork
      isLocked
      isMirror
      isPrivate
      isTemplate
      watchers {
        totalCount
      }
      defaultBranchRef {
        name
      }
      pullRequests {
        totalCount
      }
      issues {
        totalCount
      }
      primaryLanguage {
        name
        color
      }
      resourcePath
      shortDescriptionHTML
      stargazers {
        totalCount
      }
    }
  }
''';

  static const String repository = r'''
  query userInfo($login: String!, $endCursor: String) {
    user(login: $login) {
      repositories(first: 10, orderBy: {field: CREATED_AT, direction: DESC}, after: $endCursor) {
        pageInfo {
          endCursor
          hasNextPage
        }
        totalCount
        totalDiskUsage
        nodes {
          name
          description
          owner {
            avatarUrl
            login
          }
          languages(first: 10, orderBy: {field: SIZE, direction: DESC}) {
            totalSize
            nodes {
              name
              color
            }
          }
          stargazers {
            totalCount
          }
        }
      }
    }
  }
  ''';
  static const String watchers = r'''query repo($name: String!, $owner: String!, $endCursor: String) {
    repository(name: $name, owner: $owner) {
      ... on Repository {
        watchers(after: $endCursor, first: 10) {
          totalCount
          pageInfo {
            endCursor
            hasNextPage
          }
          nodes {
            avatarUrl
            bio
            login
            name
          }
        }
      }
    }
  }
  ''';
}
