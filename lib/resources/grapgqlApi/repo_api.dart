class RepoApi {
  static const String repository = r'''query userInfo($name: String!, $owner: String!) {
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
}