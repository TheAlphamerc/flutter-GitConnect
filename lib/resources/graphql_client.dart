import 'package:flutter_github_connect/bloc/people/people_model.dart';
import 'package:flutter_github_connect/resources/grapgqlApi/graphql_query_api.dart';
import 'package:graphql/client.dart';

GraphQLClient _client(token) {
  final HttpLink _httpLink = HttpLink('https://api.github.com/graphql');

  final AuthLink _authLink = AuthLink(
    getToken: () => 'token $token',
  );

  final Link _link = _authLink.concat(_httpLink);

  return GraphQLClient(
    cache: GraphQLCache(
        // dataIdFromObject: typenameDataIdFromObject,
        ),
    link: _link,
  );
}

GraphQLClient _innerClient;

initClient(token) {
  _innerClient ??= _client(token);
}

releaseClient() {
  _innerClient = null;
}

Future<QueryResult> getRepositoryDetail({String owner, String name}) async {
  final QueryOptions _options = QueryOptions(
      document: gql(Apis.repositoryDetail),
      variables: <String, dynamic>{
        'owner': owner,
        'name': name,
      },
      fetchPolicy: FetchPolicy.noCache);
  return await _innerClient.query(_options);
}

Future<QueryResult> getNextRepositoriesList(
    {String login, String endCursor}) async {
  final QueryOptions _options = QueryOptions(
      document: gql(Apis.repository),
      variables: <String, dynamic>{
        'login': login,
        'endCursor': endCursor,
      },
      fetchPolicy: FetchPolicy.noCache);
  return await _innerClient.query(_options);
}

Future<QueryResult> getUser(
  String login,
) async {
  final QueryOptions _options = QueryOptions(
      document: gql(Apis.user),
      variables: <String, dynamic>{
        'login': login,
      },
      fetchPolicy: FetchPolicy.noCache);
  return await _innerClient.query(_options);
}

Future<QueryResult> searchQueryAsync(
    String query, String type, String endCursor) async {
  final QueryOptions _options = QueryOptions(
      document: gql(Apis.search),
      variables: <String, dynamic>{
        'query': query,
        "type": type,
        "endCursor": endCursor
      },
      fetchPolicy: FetchPolicy.noCache);
  return await _innerClient.query(_options);
}

Future<QueryResult> getIssues(String login, String endCursor) async {
  final QueryOptions _options = QueryOptions(
      document: gql(Apis.issues),
      variables: <String, dynamic>{'login': login, "endCursor": endCursor},
      fetchPolicy: FetchPolicy.noCache);
  return await _innerClient.query(_options);
}

Future<QueryResult> getRepoIssues(
    String owner, String name, String endCursor) async {
  final QueryOptions _options = QueryOptions(
      document: gql(Apis.repoIssues),
      variables: <String, dynamic>{
        'owner': owner,
        "name": name,
        "endCursor": endCursor
      },
      fetchPolicy: FetchPolicy.noCache);
  return await _innerClient.query(_options);
}

Future<QueryResult> getRepoWatchers(
    String owner, String name, String endCursor) async {
  final QueryOptions _options = QueryOptions(
      document: gql(Apis.repoWatchers),
      variables: <String, dynamic>{
        'owner': owner,
        "name": name,
        "endCursor": endCursor
      },
      fetchPolicy: FetchPolicy.noCache);
  return await _innerClient.query(_options);
}

Future<QueryResult> getRepoStargazres(
    String owner, String name, String endCursor) async {
  final QueryOptions _options = QueryOptions(
      document: gql(Apis.stargazers),
      variables: <String, dynamic>{
        'owner': owner,
        "name": name,
        "endCursor": endCursor
      },
      fetchPolicy: FetchPolicy.noCache);
  return await _innerClient.query(_options);
}

Future<QueryResult> getRepoForks(
    String owner, String name, String endCursor) async {
  final QueryOptions _options = QueryOptions(
      document: gql(Apis.forks),
      variables: <String, dynamic>{
        'owner': owner,
        "name": name,
        "endCursor": endCursor
      },
      fetchPolicy: FetchPolicy.noCache);
  return await _innerClient.query(_options);
}

Future<QueryResult> getAuthUserName() async {
  final QueryOptions _options = QueryOptions(
      document: gql(Apis.userName), fetchPolicy: FetchPolicy.cacheAndNetwork);
  return await _innerClient.query(_options);
}

Future<QueryResult> getUserPullRequest(String login, String endCursor) async {
  final QueryOptions _options = QueryOptions(
      document: gql(Apis.pullRequests),
      variables: <String, dynamic>{'login': login, "endCursor": endCursor},
      fetchPolicy: FetchPolicy.noCache);
  return await _innerClient.query(_options);
}

Future<QueryResult> getRepoPullRequest(
    String owner, String name, String endCursor) async {
  final QueryOptions _options = QueryOptions(
      document: gql(Apis.repoPullRequests),
      variables: <String, dynamic>{
        'owner': owner,
        "name": name,
        "endCursor": endCursor
      },
      fetchPolicy: FetchPolicy.noCache);
  return await _innerClient.query(_options);
}

Future<QueryResult> getRepoCommits(
    String owner, String name, String endCursor) async {
  final QueryOptions _options = QueryOptions(
      document: gql(Apis.commits),
      variables: <String, dynamic>{
        'owner': owner,
        "name": name,
        "endCursor": endCursor
      },
      fetchPolicy: FetchPolicy.noCache);
  return await _innerClient.query(_options);
}

Future<QueryResult> getUserGistList(String login, String endCursor) async {
  final QueryOptions _options = QueryOptions(
      document: gql(Apis.gist),
      variables: <String, dynamic>{'login': login, "endCursor": endCursor},
      fetchPolicy: FetchPolicy.noCache);
  return await _innerClient.query(_options);
}

Future<QueryResult> getFollowerList(String login,
    {PeopleType type, String endCursor}) async {
  final QueryOptions _options = QueryOptions(
      document:
          gql(type == PeopleType.Follower ? Apis.followers : Apis.following),
      variables: <String, dynamic>{'login': login, "endCursor": endCursor},
      fetchPolicy: FetchPolicy.noCache);
  return await _innerClient.query(_options);
}

// Future<QueryResult> getFollowingList(
//   String login,
// ) async {
//   final QueryOptions _options = QueryOptions(
//       document: gql(Apis.following),
//       variables: <String, dynamic>{
//         'login': login,
//       },
//       fetchPolicy: FetchPolicy.noCache);
//   return await _innerClient.query(_options);
// }

Future<QueryResult> getTrendUser(String location, {String cursor}) async {
  var variables = cursor == null
      ? <String, dynamic>{
          'location': "location:${location} sort:followers",
        }
      : <String, dynamic>{
          'location': "location:${location} sort:followers",
          'after': cursor,
        };
  final QueryOptions _options = QueryOptions(
      document: gql(cursor == null ? readTrendUser : readTrendUserByCursor),
      variables: variables,
      fetchPolicy: FetchPolicy.noCache);
  return await _innerClient.query(_options);
}

const String readRepository = r'''
query getRepositoryDetail($owner:String!, $name:String!){
  repository(name: $name, owner: $owner) {
    ...comparisonFields
    parent {
      ...comparisonFields
    }
  }
}
fragment comparisonFields on Repository {
     issuesClosed: issues(states : CLOSED) {
      totalCount
    }
    issuesOpen: issues(states : OPEN) {
      totalCount
    }
    issues {
      totalCount
    }
    nameWithOwner,
  	id,
    name,
    owner {
      login,
      url,
      avatarUrl,
    },
  	licenseInfo {
      name
    }
    forkCount,
  	stargazers{
      totalCount
    }
    hasIssuesEnabled,
    viewerHasStarred,
    viewerSubscription,
    hasIssuesEnabled,
    defaultBranchRef {
      name
    },
    watchers {
      totalCount,
    }
    isFork
    languages(first:100) {
      totalSize,
      nodes {
        name,
      }
    },
    createdAt,
    pushedAt,
    pushedAt,
		sshUrl,
    url,
  	shortDescriptionHTML,
    repositoryTopics(first: 100) {
      totalCount,
      nodes {
        topic {
          name,
        }
      }
    }
}
''';

const String readTrendUser = r'''
query getTrendUser($location: String!){
  search(type: USER, query: $location, first: 100) {
    pageInfo {
      endCursor
    }
    user: edges {
      user: node {
      		... on User {
            name,
            avatarUrl,
            followers {
              totalCount
            },
            bio,
            login,
            lang: repositories(orderBy: {field: STARGAZERS, direction: DESC}, first:1) {
              nodes{
                name
                languages(first:1)  {
                  nodes {
                    name
                  }
                }
              }
            }
          }
      }
    } 
  }
}
''';

const String readTrendUserByCursor = r'''
query getTrendUser($location: String!,  $after: String!){
  search(type: USER, query: $location, first: 100, after: $after) {
    pageInfo {
      endCursor
    }
    user: edges {
      user: node {
      		... on User {
            name,
            avatarUrl,
            followers {
              totalCount
            },
            bio,
            login,
            lang: repositories(orderBy: {field: STARGAZERS, direction: DESC}, first:1) {
              nodes{
                name
                languages(first:1)  {
                  nodes {
                    name
                  }
                }
              }
            }
          }
      }
    } 
  }
}
''';
