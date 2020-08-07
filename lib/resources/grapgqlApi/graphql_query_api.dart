import 'package:flutter_github_connect/resources/grapgqlApi/gist_api.dart';
import 'package:flutter_github_connect/resources/grapgqlApi/issues_api.dart';
import 'package:flutter_github_connect/resources/grapgqlApi/pull_request_api.dart';

class Apis  {
  static  String get issues => IssuesApis.issues;
  static  String get pullRequests => PullRequestQraphQl.pullRequests;
  static String get gist => GistGraphQl.gist;
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
        itemShowcase {
          items(first: 10) {
            nodes {
              ... on Repository {
                id
                name
                url
                owner {
                  avatarUrl
                  login
                }
              }
            }
          }
          hasPinnedItems
        }
      }
    }
  ''';

  static String search = r'''query userInfo($query: String!, $type:SearchType!) {
    search(query: $query, first: 30, type: $type) {
      userCount
      nodes {
        ... on User {
          __typename
          id
          name
          avatarUrl
          bio
          login
        }
      #  ... on Organization {
      #   name
      #   avatarUrl
      #   login
      #  }
        ... on Issue {
          __typename
          title
          number
          closed
          closedAt
          repository {
            name
            owner{
			      login
            }
          }
           labels(first: 10) {
            __typename
            nodes {
               color
               name
             }
           }
          author {
            login
            avatarUrl
            url
          }
          state
          }
        ... on Repository {
          __typename
          id
          name
          description
          stargazers {
            totalCount
          }
          languages(first: 10, orderBy: {field: SIZE, direction: DESC}) {
            totalSize
            nodes {
              name
              color
            }
          }
          owner {
            avatarUrl
            login
            url
          }
        }
        ... on PullRequest {
          __typename
          id
          author {
            login
            avatarUrl
            url
          }
        }
      }
    }
  }''';

  static const String userName = r'''query  {
         viewer {
             login
         }
     }''';
}
