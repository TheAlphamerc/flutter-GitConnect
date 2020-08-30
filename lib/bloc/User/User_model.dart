// To parse this JSON data, do
//
//     final userApiResponse = userApiResponseFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github_connect/model/page_info_model.dart';

class UserApiResponse {
  UserApiResponse({
    this.data,
  });

  final Data data;

  factory UserApiResponse.fromRawJson(String str) =>
      UserApiResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserApiResponse.fromJson(Map<String, dynamic> json) =>
      UserApiResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.user,
  });

  final UserModel user;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user == null ? null : user.toJson(),
      };
}

class UserModel extends Equatable {
  UserModel(
      {this.name,
      this.avatarUrl,
      this.company,
      this.location,
      this.bioHtml,
      this.companyHtml,
      this.createdAt,
      this.databaseId,
      this.email,
      this.id,
      this.isEmployee,
      this.isViewer,
      this.isBountyHunter,
      this.isCampusExpert,
      this.isDeveloperProgramMember,
      this.isHireable,
      this.isSiteAdmin,
      this.login,
      this.organizationVerifiedDomainEmails,
      this.pinnedItemsRemaining,
      this.projectsResourcePath,
      this.projectsUrl,
      this.resourcePath,
      this.twitterUsername,
      this.updatedAt,
      this.url,
      this.viewerCanChangePinnedItems,
      this.viewerCanCreateProjects,
      this.viewerCanFollow,
      this.viewerIsFollowing,
      this.websiteUrl,
      this.anyPinnableItems,
      this.bio,
      this.gists,
      this.followers,
      this.following,
      this.status,
      this.topRepositories,
      this.repositoriesContributedTo,
      this.pullRequests,
      this.issues,
      this.repositories,
      this.itemShowcase});

  final String name;
  final String avatarUrl;
  final String company;
  final String location;
  final String bioHtml;
  final String companyHtml;
  final DateTime createdAt;
  final int databaseId;
  final String email;
  final String id;
  final bool isEmployee;
  final bool isViewer;
  final bool isBountyHunter;
  final bool isCampusExpert;
  final bool isDeveloperProgramMember;
  final bool isHireable;
  final bool isSiteAdmin;
  final String login;
  final List<dynamic> organizationVerifiedDomainEmails;
  final int pinnedItemsRemaining;
  final String projectsResourcePath;
  final String projectsUrl;
  final String resourcePath;
  final String twitterUsername;
  final DateTime updatedAt;
  final String url;
  final bool viewerCanChangePinnedItems;
  final bool viewerCanCreateProjects;
  final bool viewerCanFollow;
  final bool viewerIsFollowing;
  final String websiteUrl;
  final bool anyPinnableItems;
  final String bio;
  final Followers gists;
  final Followers followers;
  final Followers following;
  final Status status;
  final TopRepositories topRepositories;
  final Followers repositoriesContributedTo;
  final Followers pullRequests;
  final Followers issues;
  Repositories repositories;
  final ItemShowcaseClass itemShowcase;

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"] == null ? null : json["name"],
        avatarUrl: json["avatarUrl"] == null ? null : json["avatarUrl"],
        company: json["company"] == null ? null : json["company"],
        location: json["location"] == null ? null : json["location"],
        bioHtml: json["bioHTML"] == null ? null : json["bioHTML"],
        companyHtml: json["companyHTML"] == null ? null : json["companyHTML"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        databaseId: json["databaseId"] == null ? null : json["databaseId"],
        email: json["email"] == null ? null : json["email"],
        id: json["id"] == null ? null : json["id"],
        isEmployee: json["isEmployee"] == null ? null : json["isEmployee"],
        isViewer: json["isViewer"] == null ? null : json["isViewer"],
        isBountyHunter:
            json["isBountyHunter"] == null ? null : json["isBountyHunter"],
        isCampusExpert:
            json["isCampusExpert"] == null ? null : json["isCampusExpert"],
        isDeveloperProgramMember: json["isDeveloperProgramMember"] == null
            ? null
            : json["isDeveloperProgramMember"],
        isHireable: json["isHireable"] == null ? null : json["isHireable"],
        isSiteAdmin: json["isSiteAdmin"] == null ? null : json["isSiteAdmin"],
        login: json["login"] == null ? null : json["login"],
        organizationVerifiedDomainEmails:
            json["organizationVerifiedDomainEmails"] == null
                ? null
                : List<dynamic>.from(
                    json["organizationVerifiedDomainEmails"].map((x) => x)),
        pinnedItemsRemaining: json["pinnedItemsRemaining"] == null
            ? null
            : json["pinnedItemsRemaining"],
        projectsResourcePath: json["projectsResourcePath"] == null
            ? null
            : json["projectsResourcePath"],
        projectsUrl: json["projectsUrl"] == null ? null : json["projectsUrl"],
        resourcePath:
            json["resourcePath"] == null ? null : json["resourcePath"],
        twitterUsername:
            json["twitterUsername"] == null ? null : json["twitterUsername"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        url: json["url"] == null ? null : json["url"],
        viewerCanChangePinnedItems: json["viewerCanChangePinnedItems"] == null
            ? null
            : json["viewerCanChangePinnedItems"],
        viewerCanCreateProjects: json["viewerCanCreateProjects"] == null
            ? null
            : json["viewerCanCreateProjects"],
        viewerCanFollow:
            json["viewerCanFollow"] == null ? null : json["viewerCanFollow"],
        viewerIsFollowing: json["viewerIsFollowing"] == null
            ? null
            : json["viewerIsFollowing"],
        websiteUrl: json["websiteUrl"] == null ? null : json["websiteUrl"],
        anyPinnableItems:
            json["anyPinnableItems"] == null ? null : json["anyPinnableItems"],
        bio: json["bio"] == null ? null : json["bio"],
        gists: json["gists"] == null ? null : Followers.fromJson(json["gists"]),
        followers: json["followers"] == null
            ? null
            : Followers.fromJson(json["followers"]),
        following: json["following"] == null
            ? null
            : Followers.fromJson(json["following"]),
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        topRepositories: json["topRepositories"] == null
            ? null
            : TopRepositories.fromJson(json["topRepositories"]),
        repositoriesContributedTo: json["repositoriesContributedTo"] == null
            ? null
            : Followers.fromJson(json["repositoriesContributedTo"]),
        pullRequests: json["pullRequests"] == null
            ? null
            : Followers.fromJson(json["pullRequests"]),
        issues:
            json["issues"] == null ? null : Followers.fromJson(json["issues"]),
        repositories: json["repositories"] == null
            ? null
            : Repositories.fromJson(json["repositories"]),
        itemShowcase: json["itemShowcase"] == null
            ? null
            : ItemShowcaseClass.fromJson(json["itemShowcase"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "avatarUrl": avatarUrl == null ? null : avatarUrl,
        "company": company == null ? null : company,
        "location": location == null ? null : location,
        "bioHTML": bioHtml == null ? null : bioHtml,
        "companyHTML": companyHtml == null ? null : companyHtml,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "databaseId": databaseId == null ? null : databaseId,
        "email": email == null ? null : email,
        "id": id == null ? null : id,
        "isEmployee": isEmployee == null ? null : isEmployee,
        "isViewer": isViewer == null ? null : isViewer,
        "isBountyHunter": isBountyHunter == null ? null : isBountyHunter,
        "isCampusExpert": isCampusExpert == null ? null : isCampusExpert,
        "isDeveloperProgramMember":
            isDeveloperProgramMember == null ? null : isDeveloperProgramMember,
        "isHireable": isHireable == null ? null : isHireable,
        "isSiteAdmin": isSiteAdmin == null ? null : isSiteAdmin,
        "login": login == null ? null : login,
        "organizationVerifiedDomainEmails":
            organizationVerifiedDomainEmails == null
                ? null
                : List<dynamic>.from(
                    organizationVerifiedDomainEmails.map((x) => x)),
        "pinnedItemsRemaining":
            pinnedItemsRemaining == null ? null : pinnedItemsRemaining,
        "projectsResourcePath":
            projectsResourcePath == null ? null : projectsResourcePath,
        "projectsUrl": projectsUrl == null ? null : projectsUrl,
        "resourcePath": resourcePath == null ? null : resourcePath,
        "twitterUsername": twitterUsername == null ? null : twitterUsername,
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "url": url == null ? null : url,
        "viewerCanChangePinnedItems": viewerCanChangePinnedItems == null
            ? null
            : viewerCanChangePinnedItems,
        "viewerCanCreateProjects":
            viewerCanCreateProjects == null ? null : viewerCanCreateProjects,
        "viewerCanFollow": viewerCanFollow == null ? null : viewerCanFollow,
        "viewerIsFollowing":
            viewerIsFollowing == null ? null : viewerIsFollowing,
        "websiteUrl": websiteUrl == null ? null : websiteUrl,
        "anyPinnableItems": anyPinnableItems == null ? null : anyPinnableItems,
        "bio": bio == null ? null : bio,
        "gists": gists == null ? null : gists.toJson(),
        "followers": followers == null ? null : followers.toJson(),
        "following": following == null ? null : following.toJson(),
        "status": status == null ? null : status.toJson(),
        "topRepositories":
            topRepositories == null ? null : topRepositories.toJson(),
        "repositoriesContributedTo": repositoriesContributedTo == null
            ? null
            : repositoriesContributedTo.toJson(),
        "pullRequests": pullRequests == null ? null : pullRequests.toJson(),
        "issues": issues == null ? null : issues.toJson(),
        "repositories": repositories == null ? null : repositories.toJson(),
        "itemShowcase": itemShowcase == null ? null : itemShowcase.toJson(),
      };

  @override
  // TODO: implement props
  List<Object> get props => [name, url];
}

class Followers {
  Followers({
    this.totalCount,
  });

  final int totalCount;

  factory Followers.fromRawJson(String str) =>
      Followers.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Followers.fromJson(Map<String, dynamic> json) => Followers(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount == null ? null : totalCount,
      };
}

class Repositories {
  Repositories(
      {this.totalCount, this.totalDiskUsage, this.nodes, this.pageInfo});

  final int totalCount;
  final int totalDiskUsage;
  final List<RepositoriesNode> nodes;
  PageInfo pageInfo;
  factory Repositories.fromRawJson(String str) =>
      Repositories.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Repositories.fromJson(Map<String, dynamic> json) => Repositories(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        totalDiskUsage:
            json["totalDiskUsage"] == null ? null : json["totalDiskUsage"],
        pageInfo: json["pageInfo"] == null
            ? null
            : PageInfo.fromJson(json["pageInfo"]),
        nodes: json["nodes"] == null
            ? null
            : List<RepositoriesNode>.from(
                json["nodes"].map((x) => RepositoriesNode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount == null ? null : totalCount,
        "totalDiskUsage": totalDiskUsage == null ? null : totalDiskUsage,
        "nodes": nodes == null
            ? null
            : List<dynamic>.from(nodes.map((x) => x.toJson())),
        "pageInfo": pageInfo == null ? null : pageInfo.toJson()
      };
}

class RepositoriesNode extends Equatable {
  RepositoriesNode(
      {this.name,
      this.description,
      this.owner,
      this.languages,
      this.stargazers,
      this.type});

  final String name;
  final String description;
  final Owner owner;
  final Languages languages;
  final Followers stargazers;
  final String type;

  factory RepositoriesNode.fromRawJson(String str) =>
      RepositoriesNode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RepositoriesNode.fromJson(Map<String, dynamic> json) =>
      RepositoriesNode(
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
        type: json['__typename'],
        languages: json["languages"] == null
            ? null
            : Languages.fromJson(json["languages"]),
        stargazers: json["stargazers"] == null
            ? null
            : Followers.fromJson(json["stargazers"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "owner": owner == null ? null : owner.toJson(),
        "stargazers": stargazers == null ? null : stargazers.toJson(),
      };

  @override
  List<Object> get props => [name];
}

class Status {
  Status({
    this.emoji,
    this.message,
  });

  final String emoji;
  final String message;

  factory Status.fromRawJson(String str) => Status.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        emoji: json["emoji"] == null ? null : json["emoji"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "emoji": emoji == null ? null : emoji,
        "message": message == null ? null : message,
      };
}

class TopRepositories {
  TopRepositories({
    this.totalCount,
    this.totalDiskUsage,
    this.nodes,
  });

  final int totalCount;
  final int totalDiskUsage;
  final List<TopRepositoriesNode> nodes;

  factory TopRepositories.fromRawJson(String str) =>
      TopRepositories.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopRepositories.fromJson(Map<String, dynamic> json) =>
      TopRepositories(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        totalDiskUsage:
            json["totalDiskUsage"] == null ? null : json["totalDiskUsage"],
        nodes: json["nodes"] == null
            ? null
            : List<TopRepositoriesNode>.from(
                json["nodes"].map((x) => TopRepositoriesNode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount == null ? null : totalCount,
        "totalDiskUsage": totalDiskUsage == null ? null : totalDiskUsage,
        "nodes": nodes == null
            ? null
            : List<dynamic>.from(nodes.map((x) => x.toJson())),
      };
}

class TopRepositoriesNode {
  TopRepositoriesNode(
      {this.id,
      this.name,
      this.isFork,
      this.isPrivate,
      this.url,
      this.forkCount,
      this.owner,
      this.languages,
      this.stargazers});

  final String id;
  final String name;
  final bool isFork;
  final bool isPrivate;
  final String url;
  final int forkCount;
  final Owner owner;
  final Followers stargazers;
  final Languages languages;

  factory TopRepositoriesNode.fromRawJson(String str) =>
      TopRepositoriesNode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopRepositoriesNode.fromJson(Map<String, dynamic> json) =>
      TopRepositoriesNode(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        isFork: json["isFork"] == null ? null : json["isFork"],
        isPrivate: json["isPrivate"] == null ? null : json["isPrivate"],
        url: json["url"] == null ? null : json["url"],
        forkCount: json["forkCount"] == null ? null : json["forkCount"],
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
        languages: json["languages"] == null
            ? null
            : Languages.fromJson(json["languages"]),
        stargazers: json["stargazers"] == null
            ? null
            : Followers.fromJson(json["stargazers"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "isFork": isFork == null ? null : isFork,
        "isPrivate": isPrivate == null ? null : isPrivate,
        "url": url == null ? null : url,
        "forkCount": forkCount == null ? null : forkCount,
        "owner": owner == null ? null : owner.toJson(),
        "languages": languages == null ? null : languages.toJson(),
        "stargazers": stargazers == null ? null : stargazers.toJson(),
      };
}

class Languages {
  Languages({
    this.totalCount,
    this.nodes,
    this.totalSize,
  });

  final int totalCount;
  final List<LanguagesNode> nodes;
  final int totalSize;

  factory Languages.fromRawJson(String str) =>
      Languages.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Languages.fromJson(Map<String, dynamic> json) => Languages(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        nodes: json["nodes"] == null
            ? null
            : List<LanguagesNode>.from(
                json["nodes"].map((x) => LanguagesNode.fromJson(x))),
        totalSize: json["totalSize"] == null ? null : json["totalSize"],
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount == null ? null : totalCount,
        "nodes": nodes == null
            ? null
            : List<dynamic>.from(nodes.map((x) => x.toJson())),
        "totalSize": totalSize == null ? null : totalSize,
      };
}

class LanguagesNode {
  LanguagesNode({
    this.color,
    this.id,
    this.name,
  });

  final Color color;
  final String id;
  final String name;

  factory LanguagesNode.fromRawJson(String str) =>
      LanguagesNode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LanguagesNode.fromJson(Map<String, dynamic> json) => LanguagesNode(
        color: json["color"] == null
            ? null
            : Color(int.parse(json["color"].substring(1, 7), radix: 16) +
                0xFF000000),
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "color": color == null ? null : color.value,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}

class ItemShowcaseClass {
  ItemShowcaseClass({
    this.items,
    this.hasPinnedItems,
  });

  final Items items;
  final bool hasPinnedItems;

  factory ItemShowcaseClass.fromRawJson(String str) =>
      ItemShowcaseClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemShowcaseClass.fromJson(Map<String, dynamic> json) =>
      ItemShowcaseClass(
        items: json["items"] == null ? null : Items.fromJson(json["items"]),
        hasPinnedItems:
            json["hasPinnedItems"] == null ? null : json["hasPinnedItems"],
      );

  Map<String, dynamic> toJson() => {
        "items": items == null ? null : items.toJson(),
        "hasPinnedItems": hasPinnedItems == null ? null : hasPinnedItems,
      };
}

class Items {
  Items({
    this.nodes,
  });

  final List<Node> nodes;

  factory Items.fromRawJson(String str) => Items.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        nodes: json["nodes"] == null
            ? null
            : List<Node>.from(json["nodes"].map((x) => Node.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nodes": nodes == null
            ? null
            : List<dynamic>.from(nodes.map((x) => x.toJson())),
      };
}

class Node {
  Node(
      {this.id,
      this.name,
      this.url,
      this.owner,
      this.languages,
      this.stargazers});

  final String id;
  final String name;
  final String url;
  final Owner owner;
  final Languages languages;
  final Followers stargazers;

  factory Node.fromRawJson(String str) => Node.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Node.fromJson(Map<String, dynamic> json) => Node(
      id: json["id"] == null ? null : json["id"],
      name: json["name"] == null ? null : json["name"],
      url: json["url"] == null ? null : json["url"],
      owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
      languages: json["languages"] == null
          ? null
          : Languages.fromJson(json["languages"]),
      stargazers: json["stargazers"] == null
          ? null
          : Followers.fromJson(json["stargazers"]));

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "url": url == null ? null : url,
        "owner": owner == null ? null : owner.toJson(),
      };
}

class Owner {
  Owner({
    this.typename,
    this.name,
    this.avatarUrl,
    this.login,
  });

  final Typename typename;
  final String name;
  final String avatarUrl;
  final String login;

  factory Owner.fromRawJson(String str) => Owner.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        typename: json["__typename"] == null
            ? null
            : typenameValues.map[json["__typename"]],
        name: json["name"] == null ? null : json["name"],
        avatarUrl: json["avatarUrl"] == null ? null : json["avatarUrl"],
        login: json["login"] == null ? null : json["login"],
      );

  Map<String, dynamic> toJson() => {
        "__typename":
            typename == null ? null : typenameValues.reverse[typename],
        "name": name == null ? null : name,
        "avatarUrl": avatarUrl == null ? null : avatarUrl,
        "login": login == null ? null : login,
      };
}

enum Typename { USER }

final typenameValues = EnumValues({"User": Typename.USER});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
