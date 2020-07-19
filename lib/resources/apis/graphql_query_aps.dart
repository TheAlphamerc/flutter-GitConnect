class Apis {
  static const String user = r'''
    query userInfo($login: String!) {
      user(login: $login) {
        name
        avatarUrl
        company
        location
        bioHTML
        company
        companyHTML
        createdAt
        databaseId
        id
        isEmployee
        isViewer
        isBountyHunter
        isCampusExpert
        isDeveloperProgramMember
        isEmployee
        isHireable
        isSiteAdmin
        isViewer
        location
        login
        organizationVerifiedDomainEmails(login: $login)
        pinnedItemsRemaining
        projectsResourcePath
        projectsUrl
        resourcePath
        twitterUsername
        updatedAt
        url
        viewerCanChangePinnedItems
        viewerCanCreateProjects
        viewerCanFollow
        viewerIsFollowing
        websiteUrl
        anyPinnableItems
        bio
        status {
          emoji
          message
        }
        gists {
          totalCount
        }
        followers {
          totalCount
        }
        following {
          totalCount
        }
        topRepositories(orderBy: {field: CREATED_AT, direction: ASC}, first: 10) {
          totalCount
          totalDiskUsage
          nodes {
            id
            name
            isFork
            isPrivate
            url
            forkCount
            stargazers {
              totalCount
            }
            owner {
              __typename
              ... on User {
                name
                avatarUrl
                login
              }
            }
            languages(first: 30, orderBy: {field: SIZE, direction: DESC}) {
              totalCount
              nodes {
                color
                id
                name
              }
              totalSize
            }
          }
        }
        repositoriesContributedTo(first: 100, contributionTypes: [COMMIT, ISSUE, PULL_REQUEST, REPOSITORY]) {
          totalCount
        }
        pullRequests(first: 100) {
          totalCount
        }
        issues(first: 100) {
          totalCount
        }
        repositories(first: 100, orderBy: {field: CREATED_AT, direction: DESC}) {
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
}
