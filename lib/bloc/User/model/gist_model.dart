import 'dart:convert';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/model/page_info_model.dart';

class GistResponse {
    GistResponse({
        this.user,
    });

    final User user;

    factory GistResponse.fromRawJson(String str) => GistResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GistResponse.fromJson(Map<String, dynamic> json) => GistResponse(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user == null ? null : user.toJson(),
    };
}

class User {
    User({
        this.gists,
    });

    final Gists gists;

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        gists: json["gists"] == null ? null : Gists.fromJson(json["gists"]),
    );

    Map<String, dynamic> toJson() => {
        "gists": gists == null ? null : gists.toJson(),
    };
}

class Gists {
    Gists({
        this.totalCount,
        this.nodes,
        this.pageInfo
    });

    final int totalCount;
    final List<Node> nodes;
    PageInfo pageInfo;
    factory Gists.fromRawJson(String str) => Gists.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Gists.fromJson(Map<String, dynamic> json) => Gists(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        nodes: json["nodes"] == null ? null : List<Node>.from(json["nodes"].map((x) => Node.fromJson(x))),
        pageInfo : json["pageInfo"] == null ? null : PageInfo.fromJson(json["pageInfo"]),
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount == null ? null : totalCount,
        "nodes": nodes == null ? null : List<dynamic>.from(nodes.map((x) => x.toJson())),
        "pageInfo": pageInfo == null ? null : pageInfo.toJson()
    };
}

class Node {
    Node({
        this.owner,
        this.files,
        this.description,
        this.createdAt,
        this.isFork,
        this.isPublic,
        this.name,
        this.stargazers,
        this.updatedAt,
        this.pushedAt,
    });

    final Owner owner;
    final List<FileElement> files;
    final String description;
    final DateTime createdAt;
    final bool isFork;
    final bool isPublic;
    final String name;
    final Stargazers stargazers;
    final DateTime updatedAt;
    final DateTime pushedAt;

    factory Node.fromRawJson(String str) => Node.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Node.fromJson(Map<String, dynamic> json) => Node(
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
        files: json["files"] == null ? null : List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
        description: json["description"] == null ? null : json["description"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        isFork: json["isFork"] == null ? null : json["isFork"],
        isPublic: json["isPublic"] == null ? null : json["isPublic"],
        name: json["name"] == null ? null : json["name"],
        stargazers: json["stargazers"] == null ? null : Stargazers.fromJson(json["stargazers"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        pushedAt: json["pushedAt"] == null ? null : DateTime.parse(json["pushedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "owner": owner == null ? null : owner.toJson(),
        "files": files == null ? null : List<dynamic>.from(files.map((x) => x.toJson())),
        "description": description == null ? null : description,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "isFork": isFork == null ? null : isFork,
        "isPublic": isPublic == null ? null : isPublic,
        "name": name == null ? null : name,
        "stargazers": stargazers == null ? null : stargazers.toJson(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "pushedAt": pushedAt == null ? null : pushedAt.toIso8601String(),
    };
}

class FileElement {
    FileElement({
        this.name,
        this.extension,
    });

    final String name;
    final String extension;

    factory FileElement.fromRawJson(String str) => FileElement.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        name: json["name"] == null ? null : json["name"],
        extension: json["extension"] == null ? null : json["extension"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "extension": extension == null ? null : extension,
    };
}

class Owner {
    Owner({
        this.login,
        this.avatarUrl,
    });

    final String login;
    final String avatarUrl;

    factory Owner.fromRawJson(String str) => Owner.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        login: json["login"] == null ? null : json["login"],
        avatarUrl: json["avatarUrl"] == null ? null : json["avatarUrl"],
    );

    Map<String, dynamic> toJson() => {
        "login": login == null ? null :login,
        "avatarUrl": avatarUrl == null ? null : avatarUrl,
    };
}


class Stargazers {
    Stargazers({
        this.totalCount,
        this.pageInfo,
        this.userList
    });

    final int totalCount;
     PageInfo pageInfo;
    final List<UserModel> userList;
    factory Stargazers.fromRawJson(String str) => Stargazers.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Stargazers.fromJson(Map<String, dynamic> json) => Stargazers(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        pageInfo: json["pageInfo"] == null ? null : PageInfo.fromJson(json["pageInfo"]),
        userList: json["nodes"] == null ? null : List<UserModel>.from(json["nodes"].map((x) => UserModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount == null ? null : totalCount,
        "pageInfo": pageInfo == null ? null : pageInfo.toJson(),
        "user": userList == null ? null : List<dynamic>.from(userList.map((x) => x.toJson())),
    };
}

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


class GistDetail {
    GistDetail({
        this.url,
        this.forksUrl,
        this.commitsUrl,
        this.id,
        this.nodeId,
        this.gitPullUrl,
        this.gitPushUrl,
        this.htmlUrl,
        this.files,
        this.public,
        this.createdAt,
        this.updatedAt,
        this.description,
        this.comments,
        this.user,
        this.commentsUrl,
        this.owner,
        this.forks,
        this.history,
        this.truncated,
    });

    final String url;
    final String forksUrl;
    final String commitsUrl;
    final String id;
    final String nodeId;
    final String gitPullUrl;
    final String gitPushUrl;
    final String htmlUrl;
    final Files files;
    final bool public;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String description;
    final int comments;
    final dynamic user;
    final String commentsUrl;
    final Owner owner;
    final List<dynamic> forks;
    final List<History> history;
    final bool truncated;

    factory GistDetail.fromRawJson(String str) => GistDetail.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GistDetail.fromJson(Map<String, dynamic> json) => GistDetail(
        url: json["url"] == null ? null : json["url"],
        forksUrl: json["forks_url"] == null ? null : json["forks_url"],
        commitsUrl: json["commits_url"] == null ? null : json["commits_url"],
        id: json["id"] == null ? null : json["id"],
        nodeId: json["node_id"] == null ? null : json["node_id"],
        gitPullUrl: json["git_pull_url"] == null ? null : json["git_pull_url"],
        gitPushUrl: json["git_push_url"] == null ? null : json["git_push_url"],
        htmlUrl: json["html_url"] == null ? null : json["html_url"],
        files: json["files"] == null ? null :  Files.fromJson(json["files"]),
        public: json["public"] == null ? null : json["public"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        description: json["description"] == null ? null : json["description"],
        comments: json["comments"] == null ? null : json["comments"],
        user: json["user"],
        commentsUrl: json["comments_url"] == null ? null : json["comments_url"],
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
        forks: json["forks"] == null ? null : List<dynamic>.from(json["forks"].map((x) => x)),
        history: json["history"] == null ? null : List<History>.from(json["history"].map((x) => History.fromJson(x))),
        truncated: json["truncated"] == null ? null : json["truncated"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "forks_url": forksUrl == null ? null : forksUrl,
        "commits_url": commitsUrl == null ? null : commitsUrl,
        "id": id == null ? null : id,
        "node_id": nodeId == null ? null : nodeId,
        "git_pull_url": gitPullUrl == null ? null : gitPullUrl,
        "git_push_url": gitPushUrl == null ? null : gitPushUrl,
        "html_url": htmlUrl == null ? null : htmlUrl,
        "files": files == null ? null : files.toJson(),
        "public": public == null ? null : public,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "description": description == null ? null : description,
        "comments": comments == null ? null : comments,
        "user": user,
        "comments_url": commentsUrl == null ? null : commentsUrl,
        "owner": owner == null ? null : owner.toJson(),
        "forks": forks == null ? null : List<dynamic>.from(forks.map((x) => x)),
        "history": history == null ? null : List<History>.from(history.map((x) => x.toJson())),
        "truncated": truncated == null ? null : truncated,
    };
}

class Files {
    Files({this.list});

    final List<FileModel> list;
    
    factory Files.fromRawJson(String str) => Files.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Files.fromJson(Map<String, dynamic> json) {
     List<FileModel> list = List<FileModel>();
      json.forEach((key, value) {
          list.add(FileModel.fromJson(value));
      });
     return Files(list: list);
    }

    Map<String, dynamic> toJson() => {
        "files": list == null ? null : List<FileModel>.from(list.map((x) => x.toJson()))
    };
}

class FileModel {
    FileModel({
        this.filename,
        this.type,
        this.language,
        this.rawUrl,
        this.size,
        this.truncated,
        this.content,
    });

    final String filename;
    final String type;
    final String language;
    final String rawUrl;
    final int size;
    final bool truncated;
    final String content;

    factory FileModel.fromRawJson(String str) => FileModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
        filename: json["filename"] == null ? null : json["filename"],
        type: json["type"] == null ? null : json["type"],
        language: json["language"] == null ? null : json["language"],
        rawUrl: json["raw_url"] == null ? null : json["raw_url"],
        size: json["size"] == null ? null : json["size"],
        truncated: json["truncated"] == null ? null : json["truncated"],
        content: json["content"] == null ? null : json["content"],
    );

    Map<String, dynamic> toJson() => {
        "filename": filename == null ? null : filename,
        "type": type == null ? null : type,
        "language": language == null ? null : language,
        "raw_url": rawUrl == null ? null : rawUrl,
        "size": size == null ? null : size,
        "truncated": truncated == null ? null : truncated,
        "content": content == null ? null : content,
    };
}

class History {
    History({
        this.user,
        this.version,
        this.committedAt,
        this.changeStatus,
        this.url,
    });

    final Owner user;
    final String version;
    final DateTime committedAt;
    final ChangeStatus changeStatus;
    final String url;

    factory History.fromRawJson(String str) => History.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory History.fromJson(Map<String, dynamic> json) => History(
        user: json["user"] == null ? null : Owner.fromJson(json["user"]),
        version: json["version"] == null ? null : json["version"],
        committedAt: json["committed_at"] == null ? null : DateTime.parse(json["committed_at"]),
        changeStatus: json["change_status"] == null ? null : ChangeStatus.fromJson(json["change_status"]),
        url: json["url"] == null ? null : json["url"],
    );

    Map<String, dynamic> toJson() => {
        "user": user == null ? null : user.toJson(),
        "version": version == null ? null : version,
        "committed_at": committedAt == null ? null : committedAt.toIso8601String(),
        "change_status": changeStatus == null ? null : changeStatus.toJson(),
        "url": url == null ? null : url,
    };
}

class ChangeStatus {
    ChangeStatus({
        this.total,
        this.additions,
        this.deletions,
    });

    final int total;
    final int additions;
    final int deletions;

    factory ChangeStatus.fromRawJson(String str) => ChangeStatus.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ChangeStatus.fromJson(Map<String, dynamic> json) => ChangeStatus(
        total: json["total"] == null ? null : json["total"],
        additions: json["additions"] == null ? null : json["additions"],
        deletions: json["deletions"] == null ? null : json["deletions"],
    );

    Map<String, dynamic> toJson() => {
        "total": total == null ? null : total,
        "additions": additions == null ? null : additions,
        "deletions": deletions == null ? null : deletions,
    };
}