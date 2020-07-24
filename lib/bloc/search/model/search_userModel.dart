import 'package:flutter_github_connect/bloc/search/repo_model.dart';

class SearchModel {
  Data data;
  GithubSearchType type;
  SearchModel({this.data, this.type});

  SearchModel.fromJson(Map<String, dynamic> json,{GithubSearchType type}) {
    data = json['data'] != null ? new Data.fromJson(json['data'],type:type) : null;
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
  Data({this.search,});

  Data.fromJson(Map<String, dynamic> json, {GithubSearchType type}) {
    search =
        json['search'] != null ? new Search.fromJson(json['search'],type:type) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.search != null) {
      data['search'] = this.search.toJson();
    }
    return data;
  }
}

class Search{
  int userCount;
  List<dynamic> list;

  Search({this.userCount, this.list});

  Search.fromJson(Map<String, dynamic> json, {GithubSearchType type}) {
    userCount = json['userCount'];
    if (json['nodes'] != null) {
      list = new List<dynamic>();
      json['nodes'].forEach((v) {
        switch (type) {
          case GithubSearchType.People: list.add( SearchUser.fromJson(v));break;
          case GithubSearchType.Repository: list.add( SearchRepo.fromJson(v));break;
          default: list.add( SearchRepo.fromJson(v));break;
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
    return data;
  }
}

class SearchUser {
  String id;
  String email;
  String name;
  String login;
  String avatarUrl;

  SearchUser({this.id, this.email, this.name, this.login, this.avatarUrl});

  SearchUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    login = json['login'];
    avatarUrl = json['avatarUrl'];
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
}

/// Search Repository
class SearchRepo {
  String id;
  String name;
  Null description;
  Stargazers stargazers;
  Languages languages;
  Owner owner;

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
  List<Nodes> nodes;

  Languages({this.totalSize, this.nodes});

  Languages.fromJson(Map<String, dynamic> json) {
    totalSize = json['totalSize'];
    if (json['nodes'] != null) {
      nodes = new List<Nodes>();
      json['nodes'].forEach((v) {
        nodes.add(new Nodes.fromJson(v));
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

class Nodes {
  String name;
  String color;

  Nodes({this.name, this.color});

  Nodes.fromJson(Map<String, dynamic> json) {
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
