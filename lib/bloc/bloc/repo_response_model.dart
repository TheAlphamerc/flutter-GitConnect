import 'dart:convert';

import 'package:flutter_github_connect/bloc/search/repo_model.dart';

class RepositoryResponse {
    RepositoryResponse({
        this.data,
    });

    final Data data;

    factory RepositoryResponse.fromRawJson(String str) => RepositoryResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RepositoryResponse.fromJson(Map<String, dynamic> json) => RepositoryResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
    };
}

class Data {
    Data({
        this.repository,
    });

    final RepositoryModel repository;

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        repository: json["repository"] == null ? null : RepositoryModel.fromJson(json["repository"]),
    );

    Map<String, dynamic> toJson() => {
        "repository": repository == null ? null : repository.toJson(),
    };
}

class RepositoryModel {
    RepositoryModel({
        this.owner,
        this.name,
        this.createdAt,
        this.description,
        this.forkCount,
        this.homepageUrl,
        this.isArchived,
        this.isDisabled,
        this.isEmpty,
        this.isFork,
        this.isLocked,
        this.isMirror,
        this.isPrivate,
        this.isTemplate,
        this.watchers,
        this.defaultBranchRef,
        this.pullRequests,
        this.issues,
        this.mirrorUrl,
        this.primaryLanguage,
        this.resourcePath,
        this.shortDescriptionHtml,
        this.stargazers,
    });

    final Owner owner;
    final String name;
    final DateTime createdAt;
    final String description;
    final int forkCount;
    final String homepageUrl;
    final bool isArchived;
    final bool isDisabled;
    final bool isEmpty;
    final bool isFork;
    final bool isLocked;
    final bool isMirror;
    final bool isPrivate;
    final bool isTemplate;
    final Issues watchers;
    final DefaultBranchRef defaultBranchRef;
    final Issues pullRequests;
    final Issues issues;
    final String mirrorUrl;
    final PrimaryLanguage primaryLanguage;
    final String resourcePath;
    final String shortDescriptionHtml;
    final Issues stargazers;

    factory RepositoryModel.fromRawJson(String str) => RepositoryModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RepositoryModel.fromJson(Map<String, dynamic> json) => RepositoryModel(
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
        name: json["name"] == null ? null : json["name"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        description: json["description"] == null ? null : json["description"],
        forkCount: json["forkCount"] == null ? null : json["forkCount"],
        homepageUrl: json["homepageUrl"] == null ? null : json["homepageUrl"],
        isArchived: json["isArchived"] == null ? null : json["isArchived"],
        isDisabled: json["isDisabled"] == null ? null : json["isDisabled"],
        isEmpty: json["isEmpty"] == null ? null : json["isEmpty"],
        isFork: json["isFork"] == null ? null : json["isFork"],
        isLocked: json["isLocked"] == null ? null : json["isLocked"],
        isMirror: json["isMirror"] == null ? null : json["isMirror"],
        isPrivate: json["isPrivate"] == null ? null : json["isPrivate"],
        isTemplate: json["isTemplate"] == null ? null : json["isTemplate"],
        watchers: json["watchers"] == null ? null : Issues.fromJson(json["watchers"]),
        defaultBranchRef: json["defaultBranchRef"] == null ? null : DefaultBranchRef.fromJson(json["defaultBranchRef"]),
        pullRequests: json["pullRequests"] == null ? null : Issues.fromJson(json["pullRequests"]),
        issues: json["issues"] == null ? null : Issues.fromJson(json["issues"]),
        mirrorUrl: json["mirrorUrl"],
        primaryLanguage: json["primaryLanguage"] == null ? null : PrimaryLanguage.fromJson(json["primaryLanguage"]),
        resourcePath: json["resourcePath"] == null ? null : json["resourcePath"],
        shortDescriptionHtml: json["shortDescriptionHTML"] == null ? null : json["shortDescriptionHTML"],
        stargazers: json["stargazers"] == null ? null : Issues.fromJson(json["stargazers"]),
    );

    Map<String, dynamic> toJson() => {
        "owner": owner == null ? null : owner.toJson(),
        "name": name == null ? null : name,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "description": description == null ? null : description,
        "forkCount": forkCount == null ? null : forkCount,
        "homepageUrl": homepageUrl == null ? null : homepageUrl,
        "isArchived": isArchived == null ? null : isArchived,
        "isDisabled": isDisabled == null ? null : isDisabled,
        "isEmpty": isEmpty == null ? null : isEmpty,
        "isFork": isFork == null ? null : isFork,
        "isLocked": isLocked == null ? null : isLocked,
        "isMirror": isMirror == null ? null : isMirror,
        "isPrivate": isPrivate == null ? null : isPrivate,
        "isTemplate": isTemplate == null ? null : isTemplate,
        "watchers": watchers == null ? null : watchers.toJson(),
        "defaultBranchRef": defaultBranchRef == null ? null : defaultBranchRef.toJson(),
        "pullRequests": pullRequests == null ? null : pullRequests.toJson(),
        "issues": issues == null ? null : issues.toJson(),
        "mirrorUrl": mirrorUrl,
        "primaryLanguage": primaryLanguage == null ? null : primaryLanguage.toJson(),
        "resourcePath": resourcePath == null ? null : resourcePath,
        "shortDescriptionHTML": shortDescriptionHtml == null ? null : shortDescriptionHtml,
        "stargazers": stargazers == null ? null : stargazers.toJson(),
    };
}

class DefaultBranchRef {
    DefaultBranchRef({
        this.name,
    });

    final String name;

    factory DefaultBranchRef.fromRawJson(String str) => DefaultBranchRef.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DefaultBranchRef.fromJson(Map<String, dynamic> json) => DefaultBranchRef(
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
    };
}

class Issues {
    Issues({
        this.totalCount,
    });

    final int totalCount;

    factory Issues.fromRawJson(String str) => Issues.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Issues.fromJson(Map<String, dynamic> json) => Issues(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount == null ? null : totalCount,
    };
}

class Owner {
    Owner({
        this.login,
        this.avatarUrl,
        this.url,
    });

    final String login;
    final String avatarUrl;
    final String url;

    factory Owner.fromRawJson(String str) => Owner.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        login: json["login"] == null ? null : json["login"],
        avatarUrl: json["avatarUrl"] == null ? null : json["avatarUrl"],
        url: json["url"] == null ? null : json["url"],
    );

    Map<String, dynamic> toJson() => {
        "login": login == null ? null : login,
        "avatarUrl": avatarUrl == null ? null : avatarUrl,
        "url": url == null ? null : url,
    };
}

class PrimaryLanguage {
    PrimaryLanguage({
        this.name,
        this.color,
    });

    final String name;
    final String color;

    factory PrimaryLanguage.fromRawJson(String str) => PrimaryLanguage.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PrimaryLanguage.fromJson(Map<String, dynamic> json) => PrimaryLanguage(
        name: json["name"] == null ? null : json["name"],
        color: json["color"] == null ? null : json["color"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "color": color == null ? null : color,
    };
}
