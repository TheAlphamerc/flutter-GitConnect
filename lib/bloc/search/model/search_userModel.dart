import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/issues/issues_model.dart';
import 'package:flutter_github_connect/bloc/search/repo_model.dart';
import 'package:flutter_github_connect/model/page_info_model.dart';

class SearchModel {
  Data data;
  GithubSearchType type;
  SearchModel({this.data, this.type});

  SearchModel.fromJson(Map<String, dynamic> json, {GithubSearchType type}) {
    data = json['data'] != null
        ? new Data.fromJson(json['data'], type: type)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  Search search;
  Data({
    this.search,
  });

  Data.fromJson(Map<String, dynamic> json, {GithubSearchType type}) {
    search = json['search'] != null
        ? new Search.fromJson(json['search'], type: type)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.search != null) {
      data['search'] = this.search.toJson();
    }
    return data;
  }
}

class Search {
  int userCount;
  List<dynamic> list;
  PageInfo pageInfo;
  Search({this.userCount, this.list, this.pageInfo});

  Search.fromJson(Map<String, dynamic> json, {GithubSearchType type}) {
    userCount = json['userCount'];
    if (json['nodes'] != null) {
      list = new List<dynamic>();
      pageInfo= json["pageInfo"] == null ? null : PageInfo.fromJson(json["pageInfo"]);
      json['nodes'].forEach((v) {
        switch (type) {
          case GithubSearchType.People:
            list.add(SearchUser.fromJson(v));
            break;
          case GithubSearchType.Repository:
            list.add(RepositoriesNode.fromJson(v));
            break;
           case GithubSearchType.Issue:
            list.add(IssuesModel.fromJson(v));
            break;
          default:
            list.add(SearchRepo.fromJson(v));
            break;
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userCount'] = this.userCount;
    if (this.list != null) {
      data['nodes'] = this.list.map((v) => v.toJson()).toList();
    }
    data["pageInfo"] = pageInfo == null ? null : pageInfo.toJson();
    return data;
  }
}

/// Search User list
class SearchUser {
  String id;
  String email;
  String name;
  String login;
  String avatarUrl;
  String type;

  SearchUser({this.id, this.email, this.name, this.login, this.avatarUrl});

  SearchUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    login = json['login'];
    avatarUrl = json['avatarUrl'];
    type = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['login'] = this.login;
    data['avatarUrl'] = this.avatarUrl;
    return data;
  }

  UserModel toUserModel(){
      return UserModel(
        avatarUrl: this.avatarUrl,
        login: this.login, 
        name: this.name,
       );
  }
}

/// Search Repository
class SearchRepo {
  String id;
  String name;
  String description;
  Stargazers stargazers;
  Languages languages;
  Owner owner;
  String type;

  SearchRepo(
      {this.id,
      this.name,
      this.description,
      this.stargazers,
      this.languages,
      this.owner});

  SearchRepo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    stargazers = json['stargazers'] != null
        ? new Stargazers.fromJson(json['stargazers'])
        : null;
    languages = json['languages'] != null
        ? new Languages.fromJson(json['languages'])
        : null;
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    type = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.stargazers != null) {
      data['stargazers'] = this.stargazers.toJson();
    }
    if (this.languages != null) {
      data['languages'] = this.languages.toJson();
    }
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    return data;
  }
}

class Stargazers {
  int totalCount;

  Stargazers({this.totalCount});

  Stargazers.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    return data;
  }
}

class Languages {
  int totalSize;
  List<ColorCode> nodes;

  Languages({this.totalSize, this.nodes});

  Languages.fromJson(Map<String, dynamic> json) {
    totalSize = json['totalSize'];
    if (json['nodes'] != null) {
      nodes = new List<ColorCode>();
      json['nodes'].forEach((v) {
        nodes.add(new ColorCode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalSize'] = this.totalSize;
    if (this.nodes != null) {
      data['nodes'] = this.nodes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ColorCode {
  String name;
  String color;

  ColorCode({this.name, this.color});

  ColorCode.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['color'] = this.color;
    return data;
  }
}

class Owner {
  String avatarUrl;
  String login;
  String url;

  Owner({this.avatarUrl, this.login, this.url});

  Owner.fromJson(Map<String, dynamic> json) {
    avatarUrl = json['avatarUrl'];
    login = json['login'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatarUrl'] = this.avatarUrl;
    data['login'] = this.login;
    data['url'] = this.url;
    return data;
  }
}

/// Search Issue model
// class IssueSearchModel {
//   String title;
//   int number;
//   bool closed;
//   String closedAt;
//   Labels labels;
//   IssueAuthor author;
//   String state;
//   String type;
//   Repository repository;
//   IssueSearchModel(
//       {this.title,
//       this.number,
//       this.closed,
//       this.closedAt,
//       this.labels,
//       this.author,
//       this.state,
//       this.type,
//       this.repository
//       });

//   IssueSearchModel.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     number = json['number'];
//     closed = json['closed'];
//     closedAt = json['closedAt'];
//     labels =
//         json['labels'] != null ? new Labels.fromJson(json['labels']) : null;
//     author = json['author'] != null
//         ? new IssueAuthor.fromJson(json['author'])
//         : null;
//     state = json['state'];
//     type = json['__typename'];
//     repository = json['repository'] != null
//         ? new Repository.fromJson(json['repository'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['title'] = this.title;
//     data['number'] = this.number;
//     data['closed'] = this.closed;
//     data['closedAt'] = this.closedAt;
//     if (this.labels != null) {
//       data['labels'] = this.labels.toJson();
//     }
//     if (this.author != null) {
//       data['author'] = this.author.toJson();
//     }
//     data['state'] = this.state;
//       if (this.repository != null) {
//       data['repository'] = this.repository.toJson();
//     }
//     return data;
//   }
// }

class Labels {
  List<ColorCode> nodes;

  Labels({this.nodes});

  Labels.fromJson(Map<String, dynamic> json) {
    if (json['nodes'] != null) {
      nodes = new List<ColorCode>();
      json['nodes'].forEach((v) {
        nodes.add(new ColorCode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nodes != null) {
      data['nodes'] = this.nodes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class IssueAuthor {
//   String login;
//   String avatarUrl;
//   String url;

//   IssueAuthor({this.login, this.avatarUrl, this.url});

//   IssueAuthor.fromJson(Map<String, dynamic> json) {
//     login = json['login'];
//     avatarUrl = json['avatarUrl'];
//     url = json['url'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['login'] = this.login;
//     data['avatarUrl'] = this.avatarUrl;
//     data['url'] = this.url;
//     return data;
//   }
// }
// class Repository {
//   String name;
//   Owner owner;

//   Repository({this.name, this.owner});

//   Repository.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     if (this.owner != null) {
//       data['owner'] = this.owner.toJson();
//     }
//     return data;
//   }
// }
