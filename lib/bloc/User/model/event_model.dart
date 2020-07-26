import 'dart:convert';

class EventModel {
    EventModel({
        this.id,
        this.type,
        this.actor,
        this.repo,
        this.payload,
        this.public,
        this.createdAt,
    });

    final String id;
    final UserEventType type;
    final Actor actor;
    final Repo repo;
    final Payload payload;
    final bool public;
    final DateTime createdAt;

    factory EventModel.fromRawJson(String str) => EventModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : userEventTypeValues.map[json["type"]],
        actor: json["actor"] == null ? null : Actor.fromJson(json["actor"]),
        repo: json["repo"] == null ? null : Repo.fromJson(json["repo"]),
        payload: json["payload"] == null ? null : Payload.fromJson(json["payload"]),
        public: json["public"] == null ? null : json["public"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : userEventTypeValues.reverse[type],
        "actor": actor == null ? null : actor.toJson(),
        "repo": repo == null ? null : repo.toJson(),
        "payload": payload == null ? null : payload.toJson(),
        "public": public == null ? null : public,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    };
}

class Actor {
    Actor({
        this.id,
        this.login,
        this.displayLogin,
        this.gravatarId,
        this.url,
        this.avatarUrl,
    });

    final int id;
    final String login;
    final String displayLogin;
    final String gravatarId;
    final String url;
    final String avatarUrl;

    factory Actor.fromRawJson(String str) => Actor.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Actor.fromJson(Map<String, dynamic> json) => Actor(
        id: json["id"] == null ? null : json["id"],
        login: json["login"] == null ? null : json["login"],
        displayLogin: json["display_login"] == null ? null : json["display_login"],
        gravatarId: json["gravatar_id"] == null ? null : json["gravatar_id"],
        url: json["url"] == null ? null : json["url"],
        avatarUrl: json["avatar_url"] == null ? null : json["avatar_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "login": login == null ? null : login,
        "display_login": displayLogin == null ? null : displayLogin,
        "gravatar_id": gravatarId == null ? null : gravatarId,
        "url": url == null ? null : url,
        "avatar_url": avatarUrl == null ? null : avatarUrl,
    };
}


class Payload {
    Payload({
        this.action,
        this.issue,
        this.comment,
        this.pushId,
        this.size,
        this.distinctSize,
        this.ref,
        this.head,
        this.before,
        this.commits,
        this.refType,
        this.masterBranch,
        this.description,
        this.pusherType,
    });

    final String action;
    final Issue issue;
    final Comment comment;
    final int pushId;
    final int size;
    final int distinctSize;
    final String ref;
    final String head;
    final String before;
    final List<Commit> commits;
    final String refType;
    final String masterBranch;
    final String description;
    final String pusherType;

    factory Payload.fromRawJson(String str) => Payload.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        action: json["action"] == null ? null :json["action"],
        issue: json["issue"] == null ? null : Issue.fromJson(json["issue"]),
        comment: json["comment"] == null ? null : Comment.fromJson(json["comment"]),
        pushId: json["push_id"] == null ? null : json["push_id"],
        size: json["size"] == null ? null : json["size"],
        distinctSize: json["distinct_size"] == null ? null : json["distinct_size"],
        ref: json["ref"] == null ? null : json["ref"],
        head: json["head"] == null ? null : json["head"],
        before: json["before"] == null ? null : json["before"],
        commits: json["commits"] == null ? null : List<Commit>.from(json["commits"].map((x) => Commit.fromJson(x))),
        refType: json["ref_type"] == null ? null : json["ref_type"],
        masterBranch: json["master_branch"] == null ? null : json["master_branch"],
        description: json["description"] == null ? null : json["description"],
        pusherType: json["pusher_type"] == null ? null : json["pusher_type"],
    );

    Map<String, dynamic> toJson() => {
        "action": action == null ? null : action,
        "issue": issue == null ? null : issue.toJson(),
        "comment": comment == null ? null : comment.toJson(),
        "push_id": pushId == null ? null : pushId,
        "size": size == null ? null : size,
        "distinct_size": distinctSize == null ? null : distinctSize,
        "ref": ref == null ? null : ref,
        "head": head == null ? null : head,
        "before": before == null ? null : before,
        "commits": commits == null ? null : List<dynamic>.from(commits.map((x) => x.toJson())),
        "ref_type": refType == null ? null : refType,
        "master_branch": masterBranch == null ? null : masterBranch,
        "description": description == null ? null : description,
        "pusher_type": pusherType == null ? null : pusherType,
    };
}


class Comment {
    Comment({
        this.url,
        this.htmlUrl,
        this.issueUrl,
        this.id,
        this.nodeId,
        this.user,
        this.createdAt,
        this.updatedAt,
        this.authorAssociation,
        this.body,
        this.performedViaGithubApp,
    });

    final String url;
    final String htmlUrl;
    final String issueUrl;
    final int id;
    final String nodeId;
    final User user;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String authorAssociation;
    final String body;
    final dynamic performedViaGithubApp;

    factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        url: json["url"] == null ? null : json["url"],
        htmlUrl: json["html_url"] == null ? null : json["html_url"],
        issueUrl: json["issue_url"] == null ? null : json["issue_url"],
        id: json["id"] == null ? null : json["id"],
        nodeId: json["node_id"] == null ? null : json["node_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        authorAssociation: json["author_association"] == null ? null : json["author_association"],
        body: json["body"] == null ? null : json["body"],
        performedViaGithubApp: json["performed_via_github_app"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "html_url": htmlUrl == null ? null : htmlUrl,
        "issue_url": issueUrl == null ? null : issueUrl,
        "id": id == null ? null : id,
        "node_id": nodeId == null ? null : nodeId,
        "user": user == null ? null : user.toJson(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "author_association": authorAssociation == null ? null :authorAssociation,
        "body": body == null ? null : body,
        "performed_via_github_app": performedViaGithubApp,
    };
}


class User {
    User({
        this.login,
        this.id,
        this.nodeId,
        this.avatarUrl,
        this.gravatarId,
        this.url,
        this.htmlUrl,
        this.followersUrl,
        this.followingUrl,
        this.gistsUrl,
        this.starredUrl,
        this.subscriptionsUrl,
        this.organizationsUrl,
        this.reposUrl,
        this.eventsUrl,
        this.receivedEventsUrl,
        this.type,
        this.siteAdmin,
    });

    final String login;
    final int id;
    final String nodeId;
    final String avatarUrl;
    final String gravatarId;
    final String url;
    final String htmlUrl;
    final String followersUrl;
    final String followingUrl;
    final String gistsUrl;
    final String starredUrl;
    final String subscriptionsUrl;
    final String organizationsUrl;
    final String reposUrl;
    final String eventsUrl;
    final String receivedEventsUrl;
    final String type;
    final bool siteAdmin;

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        login: json["login"] == null ? null : json["login"],
        id: json["id"] == null ? null : json["id"],
        nodeId: json["node_id"] == null ? null : json["node_id"],
        avatarUrl: json["avatar_url"] == null ? null : json["avatar_url"],
        gravatarId: json["gravatar_id"] == null ? null : json["gravatar_id"],
        url: json["url"] == null ? null : json["url"],
        htmlUrl: json["html_url"] == null ? null : json["html_url"],
        followersUrl: json["followers_url"] == null ? null : json["followers_url"],
        followingUrl: json["following_url"] == null ? null : json["following_url"],
        gistsUrl: json["gists_url"] == null ? null : json["gists_url"],
        starredUrl: json["starred_url"] == null ? null : json["starred_url"],
        subscriptionsUrl: json["subscriptions_url"] == null ? null : json["subscriptions_url"],
        organizationsUrl: json["organizations_url"] == null ? null : json["organizations_url"],
        reposUrl: json["repos_url"] == null ? null : json["repos_url"],
        eventsUrl: json["events_url"] == null ? null : json["events_url"],
        receivedEventsUrl: json["received_events_url"] == null ? null : json["received_events_url"],
        type: json["type"] == null ? null : json["type"],
        siteAdmin: json["site_admin"] == null ? null : json["site_admin"],
    );

    Map<String, dynamic> toJson() => {
        "login": login == null ? null : login,
        "id": id == null ? null : id,
        "node_id": nodeId == null ? null : nodeId,
        "avatar_url": avatarUrl == null ? null : avatarUrl,
        "gravatar_id": gravatarId == null ? null : gravatarId,
        "url": url == null ? null : url,
        "html_url": htmlUrl == null ? null : htmlUrl,
        "followers_url": followersUrl == null ? null : followersUrl,
        "following_url": followingUrl == null ? null : followingUrl,
        "gists_url": gistsUrl == null ? null : gistsUrl,
        "starred_url": starredUrl == null ? null : starredUrl,
        "subscriptions_url": subscriptionsUrl == null ? null : subscriptionsUrl,
        "organizations_url": organizationsUrl == null ? null : organizationsUrl,
        "repos_url": reposUrl == null ? null : reposUrl,
        "events_url": eventsUrl == null ? null : eventsUrl,
        "received_events_url": receivedEventsUrl == null ? null : receivedEventsUrl,
        "type": type == null ? null : type,
        "site_admin": siteAdmin == null ? null : siteAdmin,
    };
}



class Commit {
    Commit({
        this.sha,
        this.author,
        this.message,
        this.distinct,
        this.url,
    });

    final String sha;
    final Author author;
    final String message;
    final bool distinct;
    final String url;

    factory Commit.fromRawJson(String str) => Commit.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Commit.fromJson(Map<String, dynamic> json) => Commit(
        sha: json["sha"] == null ? null : json["sha"],
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
        message: json["message"] == null ? null : json["message"],
        distinct: json["distinct"] == null ? null : json["distinct"],
        url: json["url"] == null ? null : json["url"],
    );

    Map<String, dynamic> toJson() => {
        "sha": sha == null ? null : sha,
        "author": author == null ? null : author.toJson(),
        "message": message == null ? null : message,
        "distinct": distinct == null ? null : distinct,
        "url": url == null ? null : url,
    };
}

class Author {
    Author({
        this.email,
        this.name,
    });

    final String email;
    final String name;

    factory Author.fromRawJson(String str) => Author.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        email: json["email"] == null ? null : json["email"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "name": name == null ? null : name,
    };
}

class Issue {
    Issue({
        this.url,
        this.repositoryUrl,
        this.labelsUrl,
        this.commentsUrl,
        this.eventsUrl,
        this.htmlUrl,
        this.id,
        this.nodeId,
        this.number,
        this.title,
        this.user,
        this.labels,
        this.state,
        this.locked,
        this.assignee,
        this.assignees,
        this.milestone,
        this.comments,
        this.createdAt,
        this.updatedAt,
        this.closedAt,
        this.authorAssociation,
        this.activeLockReason,
        this.body,
        this.performedViaGithubApp,
    });

    final String url;
    final String repositoryUrl;
    final String labelsUrl;
    final String commentsUrl;
    final String eventsUrl;
    final String htmlUrl;
    final int id;
    final String nodeId;
    final int number;
    final String title;
    final User user;
    final List<Label> labels;
    final IssueState state;
    final bool locked;
    final dynamic assignee;
    final List<dynamic> assignees;
    final dynamic milestone;
    final int comments;
    final DateTime createdAt;
    final DateTime updatedAt;
    final DateTime closedAt;
    final String authorAssociation;
    final dynamic activeLockReason;
    final String body;
    final dynamic performedViaGithubApp;

    factory Issue.fromRawJson(String str) => Issue.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Issue.fromJson(Map<String, dynamic> json) => Issue(
        url: json["url"] == null ? null : json["url"],
        repositoryUrl: json["repository_url"] == null ? null : json["repository_url"],
        labelsUrl: json["labels_url"] == null ? null : json["labels_url"],
        commentsUrl: json["comments_url"] == null ? null : json["comments_url"],
        eventsUrl: json["events_url"] == null ? null : json["events_url"],
        htmlUrl: json["html_url"] == null ? null : json["html_url"],
        id: json["id"] == null ? null : json["id"],
        nodeId: json["node_id"] == null ? null : json["node_id"],
        number: json["number"] == null ? null : json["number"],
        title: json["title"] == null ? null : json["title"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        labels: json["labels"] == null ? null : List<Label>.from(json["labels"].map((x) => Label.fromJson(x))),
        state: json["state"] == null ? null : stateValues.map[json["state"]],
        locked: json["locked"] == null ? null : json["locked"],
        assignee: json["assignee"],
        assignees: json["assignees"] == null ? null : List<dynamic>.from(json["assignees"].map((x) => x)),
        milestone: json["milestone"],
        comments: json["comments"] == null ? null : json["comments"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        closedAt: json["closed_at"] == null ? null : DateTime.parse(json["closed_at"]),
        authorAssociation: json["author_association"] == null ? null : json["author_association"],
        activeLockReason: json["active_lock_reason"],
        body: json["body"] == null ? null : json["body"],
        performedViaGithubApp: json["performed_via_github_app"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "repository_url": repositoryUrl == null ? null : repositoryUrl,
        "labels_url": labelsUrl == null ? null : labelsUrl,
        "comments_url": commentsUrl == null ? null : commentsUrl,
        "events_url": eventsUrl == null ? null : eventsUrl,
        "html_url": htmlUrl == null ? null : htmlUrl,
        "id": id == null ? null : id,
        "node_id": nodeId == null ? null : nodeId,
        "number": number == null ? null : number,
        "title": title == null ? null : title,
        "user": user == null ? null : user.toJson(),
        "labels": labels == null ? null : List<dynamic>.from(labels.map((x) => x.toJson())),
        "state": state == null ? null : stateValues.reverse[state],
        "locked": locked == null ? null : locked,
        "assignee": assignee,
        "assignees": assignees == null ? null : List<dynamic>.from(assignees.map((x) => x)),
        "milestone": milestone,
        "comments": comments == null ? null : comments,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "closed_at": closedAt == null ? null : closedAt.toIso8601String(),
        "author_association": authorAssociation == null ? null : authorAssociation,
        "active_lock_reason": activeLockReason,
        "body": body == null ? null : body,
        "performed_via_github_app": performedViaGithubApp,
    };
}

class Label {
    Label({
        this.id,
        this.nodeId,
        this.url,
        this.name,
        this.color,
        this.labelDefault,
        this.description,
    });

    final int id;
    final String nodeId;
    final String url;
    final String name;
    final String color;
    final bool labelDefault;
    final String description;

    factory Label.fromRawJson(String str) => Label.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Label.fromJson(Map<String, dynamic> json) => Label(
        id: json["id"] == null ? null : json["id"],
        nodeId: json["node_id"] == null ? null : json["node_id"],
        url: json["url"] == null ? null : json["url"],
        name: json["name"] == null ? null : json["name"],
        color: json["color"] == null ? null : json["color"],
        labelDefault: json["default"] == null ? null : json["default"],
        description: json["description"] == null ? null : json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "node_id": nodeId == null ? null : nodeId,
        "url": url == null ? null : url,
        "name": name == null ? null : name,
        "color": color == null ? null : color,
        "default": labelDefault == null ? null : labelDefault,
        "description": description == null ? null : description,
    };
}

enum IssueState { CLOSED, OPEN }

final stateValues = EnumValues({
    "closed": IssueState.CLOSED,
    "open": IssueState.OPEN
});

class Repo {
    Repo({
        this.id,
        this.name,
        this.url,
    });

    final int id;
    final String name;
    final String url;

    factory Repo.fromRawJson(String str) => Repo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Repo.fromJson(Map<String, dynamic> json) => Repo(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        url: json["url"] == null ? null : json["url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "url": url == null ? null : url,
    };
}



enum UserEventType { ISSUE_COMMENT_EVENT, PUSH_EVENT, WATCH_EVENT, CREATE_EVENT, ISSUES_EVENT }

final userEventTypeValues = EnumValues({
    "CreateEvent": UserEventType.CREATE_EVENT,
    "IssuesEvent": UserEventType.ISSUES_EVENT,
    "IssueCommentEvent": UserEventType.ISSUE_COMMENT_EVENT,
    "PushEvent": UserEventType.PUSH_EVENT,
    "WatchEvent": UserEventType.WATCH_EVENT
});

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
