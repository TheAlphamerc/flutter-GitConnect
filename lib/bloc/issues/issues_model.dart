import 'package:flutter_github_connect/bloc/notification/notification_model.dart';
import 'package:flutter_github_connect/bloc/search/model/search_userModel.dart';
import 'package:flutter_github_connect/model/page_info_model.dart';

class IssuesReponseModel {
  IssuesData data;

  IssuesReponseModel({this.data});

  IssuesReponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new IssuesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class IssuesData {
  Viewer viewer;

  IssuesData({this.viewer});

  IssuesData.fromJson(Map<String, dynamic> json) {
    viewer =
        json['issues'] != null ? new Viewer.fromJson(json['issues']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.viewer != null) {
      data['issues'] = this.viewer.toJson();
    }
    return data;
  }
}

class Viewer {
  Issues issues;

  Viewer({this.issues});

  Viewer.fromJson(Map<String, dynamic> json) {
    issues =
        json['issues'] != null ? new Issues.fromJson(json['issues']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.issues != null) {
      data['issues'] = this.issues.toJson();
    }
    return data;
  }
}

class Issues {
  int totalCount;
  List<IssuesModel> list;
  PageInfo pageInfo;
  Issues({this.totalCount, this.list,this.pageInfo});

  Issues.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    pageInfo = PageInfo.fromJson(json["pageInfo"]);
    if (json['nodes'] != null) {
      list = new List<IssuesModel>();
      json['nodes'].forEach((v) {
        list.add(new IssuesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['pageInfo'] = this.pageInfo.toJson();
    if (this.list != null) {
      data['nodes'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IssuesModel {
  String title;
  String createdAt;
  String state;
  int number;
  bool viewerDidAuthor;
  bool closed;
  String authorAssociation;
  Author author;
  Repository repository;
  Labels labels;
  String closedAt;
  String type;
  IssuesModel(
      {this.title,
      this.createdAt,
      this.state,
      this.number,
      this.viewerDidAuthor,
      this.closed,
      this.authorAssociation,
      this.author,
      this.repository,
      this.labels,
      this.closedAt,
      this.type});

  IssuesModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    createdAt = json['createdAt'];
    state = json['state'];
    number = json['number'];
    viewerDidAuthor = json['viewerDidAuthor'];
    closed = json['closed'];
    closedAt = json['closedAt'];
    authorAssociation = json['authorAssociation'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    repository = json['repository'] != null
        ? new Repository.fromJson(json['repository'])
        : null;
    labels =
        json['labels'] != null ? new Labels.fromJson(json['labels']) : null;
    type = json['__typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['createdAt'] = this.createdAt;
    data['state'] = this.state;
    data['number'] = this.number;
    data['viewerDidAuthor'] = this.viewerDidAuthor;
    data['closed'] = this.closed;
    data['authorAssociation'] = this.authorAssociation;
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    if (this.repository != null) {
      data['repository'] = this.repository.toJson();
    }
    if (this.labels != null) {
      data['labels'] = this.labels.toJson();
    }
    return data;
  }
}

class Author {
  String login;
  String avatarUrl;
  String url;

  Author({this.login, this.avatarUrl, this.url});

  Author.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    avatarUrl = json['avatarUrl'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['avatarUrl'] = this.avatarUrl;
    data['url'] = this.url;
    return data;
  }
}
