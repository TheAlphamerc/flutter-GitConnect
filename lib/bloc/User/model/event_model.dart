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
        this.pullRequest
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
    final PullRequest pullRequest;
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
        pullRequest: json["pull_request"] == null ? null : PullRequest.fromJson(json["pull_request"]),
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
        "pull_request": pullRequest == null ? null : pullRequest.toJson(),
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
    final EventState state;
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

enum EventState { CLOSED, OPEN,CREATED }

final stateValues = EnumValues({
    "closed": EventState.CLOSED,
    "open": EventState.OPEN,
    "created": EventState.CREATED,
});

class Repo {
    Repo({
        this.id,
        this.name,
        this.url,
    });

    final int id;
    final String  name;
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


class PullRequest {
    PullRequest({
        this.url,
        this.id,
        this.nodeId,
        this.htmlUrl,
        this.diffUrl,
        this.patchUrl,
        this.issueUrl,
        this.number,
        this.state,
        this.locked,
        this.title,
        this.user,
        this.body,
        this.createdAt,
        this.updatedAt,
        this.closedAt,
        this.mergedAt,
        this.mergeCommitSha,
        this.assignee,
        this.assignees,
        this.requestedReviewers,
        this.requestedTeams,
        this.labels,
        this.milestone,
        this.draft,
        this.commitsUrl,
        this.reviewCommentsUrl,
        this.reviewCommentUrl,
        this.commentsUrl,
        this.statusesUrl,
        this.head,
        this.base,
        this.links,
        this.authorAssociation,
        this.activeLockReason,
        this.merged,
        this.mergeable,
        this.rebaseable,
        this.mergeableState,
        this.mergedBy,
        this.comments,
        this.reviewComments,
        this.maintainerCanModify,
        this.commits,
        this.additions,
        this.deletions,
        this.changedFiles,
    });

    final String url;
    final int id;
    final String nodeId;
    final String htmlUrl;
    final String diffUrl;
    final String patchUrl;
    final String issueUrl;
    final int number;
    final EventState state;
    final bool locked;
    final String title;
    final User user;
    final String body;
    final DateTime createdAt;
    final DateTime updatedAt;
    final DateTime closedAt;
    final DateTime mergedAt;
    final String mergeCommitSha;
    final dynamic assignee;
    final List<dynamic> assignees;
    final List<dynamic> requestedReviewers;
    final List<dynamic> requestedTeams;
    final List<dynamic> labels;
    final dynamic milestone;
    final bool draft;
    final String commitsUrl;
    final String reviewCommentsUrl;
    final String reviewCommentUrl;
    final String commentsUrl;
    final String statusesUrl;
    final Base head;
    final Base base;
    final Links links;
    final String authorAssociation;
    final dynamic activeLockReason;
    final bool merged;
    final dynamic mergeable;
    final dynamic rebaseable;
    final String mergeableState;
    final User mergedBy;
    final int comments;
    final int reviewComments;
    final bool maintainerCanModify;
    final int commits;
    final int additions;
    final int deletions;
    final int changedFiles;

    factory PullRequest.fromRawJson(String str) => PullRequest.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PullRequest.fromJson(Map<String, dynamic> json) => PullRequest(
        url: json["url"] == null ? null : json["url"],
        id: json["id"] == null ? null : json["id"],
        nodeId: json["node_id"] == null ? null : json["node_id"],
        htmlUrl: json["html_url"] == null ? null : json["html_url"],
        diffUrl: json["diff_url"] == null ? null : json["diff_url"],
        patchUrl: json["patch_url"] == null ? null : json["patch_url"],
        issueUrl: json["issue_url"] == null ? null : json["issue_url"],
        number: json["number"] == null ? null : json["number"],
        state: json["state"] == null ? null : stateValues.map[json["state"]],
        locked: json["locked"] == null ? null : json["locked"],
        title: json["title"] == null ? null : json["title"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        body: json["body"] == null ? null : json["body"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        closedAt: json["closed_at"] == null ? null : DateTime.parse(json["closed_at"]),
        mergedAt: json["merged_at"] == null ? null : DateTime.parse(json["merged_at"]),
        mergeCommitSha: json["merge_commit_sha"] == null ? null : json["merge_commit_sha"],
        assignee: json["assignee"],
        assignees: json["assignees"] == null ? null : List<dynamic>.from(json["assignees"].map((x) => x)),
        requestedReviewers: json["requested_reviewers"] == null ? null : List<dynamic>.from(json["requested_reviewers"].map((x) => x)),
        requestedTeams: json["requested_teams"] == null ? null : List<dynamic>.from(json["requested_teams"].map((x) => x)),
        labels: json["labels"] == null ? null : List<dynamic>.from(json["labels"].map((x) => x)),
        milestone: json["milestone"],
        draft: json["draft"] == null ? null : json["draft"],
        commitsUrl: json["commits_url"] == null ? null : json["commits_url"],
        reviewCommentsUrl: json["review_comments_url"] == null ? null : json["review_comments_url"],
        reviewCommentUrl: json["review_comment_url"] == null ? null : json["review_comment_url"],
        commentsUrl: json["comments_url"] == null ? null : json["comments_url"],
        statusesUrl: json["statuses_url"] == null ? null : json["statuses_url"],
        head: json["head"] == null ? null : Base.fromJson(json["head"]),
        base: json["base"] == null ? null : Base.fromJson(json["base"]),
        links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
        authorAssociation: json["author_association"] == null ? null : json["author_association"],
        activeLockReason: json["active_lock_reason"],
        merged: json["merged"] == null ? null : json["merged"],
        mergeable: json["mergeable"],
        rebaseable: json["rebaseable"],
        mergeableState: json["mergeable_state"] == null ? null : json["mergeable_state"],
        mergedBy: json["merged_by"] == null ? null : User.fromJson(json["merged_by"]),
        comments: json["comments"] == null ? null : json["comments"],
        reviewComments: json["review_comments"] == null ? null : json["review_comments"],
        maintainerCanModify: json["maintainer_can_modify"] == null ? null : json["maintainer_can_modify"],
        commits: json["commits"] == null ? null : json["commits"],
        additions: json["additions"] == null ? null : json["additions"],
        deletions: json["deletions"] == null ? null : json["deletions"],
        changedFiles: json["changed_files"] == null ? null : json["changed_files"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "id": id == null ? null : id,
        "node_id": nodeId == null ? null : nodeId,
        "html_url": htmlUrl == null ? null : htmlUrl,
        "diff_url": diffUrl == null ? null : diffUrl,
        "patch_url": patchUrl == null ? null : patchUrl,
        "issue_url": issueUrl == null ? null : issueUrl,
        "number": number == null ? null : number,
        "state": state == null ? null : stateValues.reverse[state],
        "locked": locked == null ? null : locked,
        "title": title == null ? null : title,
        "user": user == null ? null : user.toJson(),
        "body": body == null ? null : body,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "closed_at": closedAt == null ? null : closedAt.toIso8601String(),
        "merged_at": mergedAt == null ? null : mergedAt.toIso8601String(),
        "merge_commit_sha": mergeCommitSha == null ? null : mergeCommitSha,
        "assignee": assignee,
        "assignees": assignees == null ? null : List<dynamic>.from(assignees.map((x) => x)),
        "requested_reviewers": requestedReviewers == null ? null : List<dynamic>.from(requestedReviewers.map((x) => x)),
        "requested_teams": requestedTeams == null ? null : List<dynamic>.from(requestedTeams.map((x) => x)),
        "labels": labels == null ? null : List<dynamic>.from(labels.map((x) => x)),
        "milestone": milestone,
        "draft": draft == null ? null : draft,
        "commits_url": commitsUrl == null ? null : commitsUrl,
        "review_comments_url": reviewCommentsUrl == null ? null : reviewCommentsUrl,
        "review_comment_url": reviewCommentUrl == null ? null : reviewCommentUrl,
        "comments_url": commentsUrl == null ? null : commentsUrl,
        "statuses_url": statusesUrl == null ? null : statusesUrl,
        "head": head == null ? null : head.toJson(),
        "base": base == null ? null : base.toJson(),
        "_links": links == null ? null : links.toJson(),
        "author_association": authorAssociation == null ? null : authorAssociation,
        "active_lock_reason": activeLockReason,
        "merged": merged == null ? null : merged,
        "mergeable": mergeable,
        "rebaseable": rebaseable,
        "mergeable_state": mergeableState == null ? null : mergeableState,
        "merged_by": mergedBy == null ? null : mergedBy.toJson(),
        "comments": comments == null ? null : comments,
        "review_comments": reviewComments == null ? null : reviewComments,
        "maintainer_can_modify": maintainerCanModify == null ? null : maintainerCanModify,
        "commits": commits == null ? null : commits,
        "additions": additions == null ? null : additions,
        "deletions": deletions == null ? null : deletions,
        "changed_files": changedFiles == null ? null : changedFiles,
    };
}

class Base {
    Base({
        this.label,
        this.ref,
        this.sha,
        this.user,
        this.repo,
    });

    final String label;
    final String ref;
    final String sha;
    final User user;
    final BaseRepo repo;

    factory Base.fromRawJson(String str) => Base.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Base.fromJson(Map<String, dynamic> json) => Base(
        label: json["label"] == null ? null : json["label"],
        ref: json["ref"] == null ? null : json["ref"],
        sha: json["sha"] == null ? null : json["sha"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        repo: json["repo"] == null ? null : BaseRepo.fromJson(json["repo"]),
    );

    Map<String, dynamic> toJson() => {
        "label": label == null ? null : label,
        "ref": ref == null ? null : ref,
        "sha": sha == null ? null : sha,
        "user": user == null ? null : user.toJson(),
        "repo": repo == null ? null : repo.toJson(),
    };
}

class BaseRepo {
    BaseRepo({
        this.id,
        this.nodeId,
        this.name,
        this.fullName,
        this.private,
        this.owner,
        this.htmlUrl,
        this.description,
        this.fork,
        this.url,
        this.forksUrl,
        this.keysUrl,
        this.collaboratorsUrl,
        this.teamsUrl,
        this.hooksUrl,
        this.issueEventsUrl,
        this.eventsUrl,
        this.assigneesUrl,
        this.branchesUrl,
        this.tagsUrl,
        this.blobsUrl,
        this.gitTagsUrl,
        this.gitRefsUrl,
        this.treesUrl,
        this.statusesUrl,
        this.languagesUrl,
        this.stargazersUrl,
        this.contributorsUrl,
        this.subscribersUrl,
        this.subscriptionUrl,
        this.commitsUrl,
        this.gitCommitsUrl,
        this.commentsUrl,
        this.issueCommentUrl,
        this.contentsUrl,
        this.compareUrl,
        this.mergesUrl,
        this.archiveUrl,
        this.downloadsUrl,
        this.issuesUrl,
        this.pullsUrl,
        this.milestonesUrl,
        this.notificationsUrl,
        this.labelsUrl,
        this.releasesUrl,
        this.deploymentsUrl,
        this.createdAt,
        this.updatedAt,
        this.pushedAt,
        this.gitUrl,
        this.sshUrl,
        this.cloneUrl,
        this.svnUrl,
        this.homepage,
        this.size,
        this.stargazersCount,
        this.watchersCount,
        this.language,
        this.hasIssues,
        this.hasProjects,
        this.hasDownloads,
        this.hasWiki,
        this.hasPages,
        this.forksCount,
        this.mirrorUrl,
        this.archived,
        this.disabled,
        this.openIssuesCount,
        this.license,
        this.forks,
        this.openIssues,
        this.watchers,
        this.defaultBranch,
    });

    final int id;
    final String nodeId;
    final String name;
    final String fullName;
    final bool private;
    final User owner;
    final String htmlUrl;
    final dynamic description;
    final bool fork;
    final String url;
    final String forksUrl;
    final String keysUrl;
    final String collaboratorsUrl;
    final String teamsUrl;
    final String hooksUrl;
    final String issueEventsUrl;
    final String eventsUrl;
    final String assigneesUrl;
    final String branchesUrl;
    final String tagsUrl;
    final String blobsUrl;
    final String gitTagsUrl;
    final String gitRefsUrl;
    final String treesUrl;
    final String statusesUrl;
    final String languagesUrl;
    final String stargazersUrl;
    final String contributorsUrl;
    final String subscribersUrl;
    final String subscriptionUrl;
    final String commitsUrl;
    final String gitCommitsUrl;
    final String commentsUrl;
    final String issueCommentUrl;
    final String contentsUrl;
    final String compareUrl;
    final String mergesUrl;
    final String archiveUrl;
    final String downloadsUrl;
    final String issuesUrl;
    final String pullsUrl;
    final String milestonesUrl;
    final String notificationsUrl;
    final String labelsUrl;
    final String releasesUrl;
    final String deploymentsUrl;
    final DateTime createdAt;
    final DateTime updatedAt;
    final DateTime pushedAt;
    final String gitUrl;
    final String sshUrl;
    final String cloneUrl;
    final String svnUrl;
    final dynamic homepage;
    final int size;
    final int stargazersCount;
    final int watchersCount;
    final dynamic language;
    final bool hasIssues;
    final bool hasProjects;
    final bool hasDownloads;
    final bool hasWiki;
    final bool hasPages;
    final int forksCount;
    final dynamic mirrorUrl;
    final bool archived;
    final bool disabled;
    final int openIssuesCount;
    final dynamic license;
    final int forks;
    final int openIssues;
    final int watchers;
    final String defaultBranch;

    factory BaseRepo.fromRawJson(String str) => BaseRepo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory BaseRepo.fromJson(Map<String, dynamic> json) => BaseRepo(
        id: json["id"] == null ? null : json["id"],
        nodeId: json["node_id"] == null ? null : json["node_id"],
        name: json["name"] == null ? null : json["name"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        private: json["private"] == null ? null : json["private"],
        owner: json["owner"] == null ? null : User.fromJson(json["owner"]),
        htmlUrl: json["html_url"] == null ? null : json["html_url"],
        description: json["description"],
        fork: json["fork"] == null ? null : json["fork"],
        url: json["url"] == null ? null : json["url"],
        forksUrl: json["forks_url"] == null ? null : json["forks_url"],
        keysUrl: json["keys_url"] == null ? null : json["keys_url"],
        collaboratorsUrl: json["collaborators_url"] == null ? null : json["collaborators_url"],
        teamsUrl: json["teams_url"] == null ? null : json["teams_url"],
        hooksUrl: json["hooks_url"] == null ? null : json["hooks_url"],
        issueEventsUrl: json["issue_events_url"] == null ? null : json["issue_events_url"],
        eventsUrl: json["events_url"] == null ? null : json["events_url"],
        assigneesUrl: json["assignees_url"] == null ? null : json["assignees_url"],
        branchesUrl: json["branches_url"] == null ? null : json["branches_url"],
        tagsUrl: json["tags_url"] == null ? null : json["tags_url"],
        blobsUrl: json["blobs_url"] == null ? null : json["blobs_url"],
        gitTagsUrl: json["git_tags_url"] == null ? null : json["git_tags_url"],
        gitRefsUrl: json["git_refs_url"] == null ? null : json["git_refs_url"],
        treesUrl: json["trees_url"] == null ? null : json["trees_url"],
        statusesUrl: json["statuses_url"] == null ? null : json["statuses_url"],
        languagesUrl: json["languages_url"] == null ? null : json["languages_url"],
        stargazersUrl: json["stargazers_url"] == null ? null : json["stargazers_url"],
        contributorsUrl: json["contributors_url"] == null ? null : json["contributors_url"],
        subscribersUrl: json["subscribers_url"] == null ? null : json["subscribers_url"],
        subscriptionUrl: json["subscription_url"] == null ? null : json["subscription_url"],
        commitsUrl: json["commits_url"] == null ? null : json["commits_url"],
        gitCommitsUrl: json["git_commits_url"] == null ? null : json["git_commits_url"],
        commentsUrl: json["comments_url"] == null ? null : json["comments_url"],
        issueCommentUrl: json["issue_comment_url"] == null ? null : json["issue_comment_url"],
        contentsUrl: json["contents_url"] == null ? null : json["contents_url"],
        compareUrl: json["compare_url"] == null ? null : json["compare_url"],
        mergesUrl: json["merges_url"] == null ? null : json["merges_url"],
        archiveUrl: json["archive_url"] == null ? null : json["archive_url"],
        downloadsUrl: json["downloads_url"] == null ? null : json["downloads_url"],
        issuesUrl: json["issues_url"] == null ? null : json["issues_url"],
        pullsUrl: json["pulls_url"] == null ? null : json["pulls_url"],
        milestonesUrl: json["milestones_url"] == null ? null : json["milestones_url"],
        notificationsUrl: json["notifications_url"] == null ? null : json["notifications_url"],
        labelsUrl: json["labels_url"] == null ? null : json["labels_url"],
        releasesUrl: json["releases_url"] == null ? null : json["releases_url"],
        deploymentsUrl: json["deployments_url"] == null ? null : json["deployments_url"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        pushedAt: json["pushed_at"] == null ? null : DateTime.parse(json["pushed_at"]),
        gitUrl: json["git_url"] == null ? null : json["git_url"],
        sshUrl: json["ssh_url"] == null ? null : json["ssh_url"],
        cloneUrl: json["clone_url"] == null ? null : json["clone_url"],
        svnUrl: json["svn_url"] == null ? null : json["svn_url"],
        homepage: json["homepage"],
        size: json["size"] == null ? null : json["size"],
        stargazersCount: json["stargazers_count"] == null ? null : json["stargazers_count"],
        watchersCount: json["watchers_count"] == null ? null : json["watchers_count"],
        language: json["language"],
        hasIssues: json["has_issues"] == null ? null : json["has_issues"],
        hasProjects: json["has_projects"] == null ? null : json["has_projects"],
        hasDownloads: json["has_downloads"] == null ? null : json["has_downloads"],
        hasWiki: json["has_wiki"] == null ? null : json["has_wiki"],
        hasPages: json["has_pages"] == null ? null : json["has_pages"],
        forksCount: json["forks_count"] == null ? null : json["forks_count"],
        mirrorUrl: json["mirror_url"],
        archived: json["archived"] == null ? null : json["archived"],
        disabled: json["disabled"] == null ? null : json["disabled"],
        openIssuesCount: json["open_issues_count"] == null ? null : json["open_issues_count"],
        license: json["license"],
        forks: json["forks"] == null ? null : json["forks"],
        openIssues: json["open_issues"] == null ? null : json["open_issues"],
        watchers: json["watchers"] == null ? null : json["watchers"],
        defaultBranch: json["default_branch"] == null ? null : json["default_branch"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "node_id": nodeId == null ? null : nodeId,
        "name": name == null ? null : name,
        "full_name": fullName == null ? null : fullName,
        "private": private == null ? null : private,
        "owner": owner == null ? null : owner.toJson(),
        "html_url": htmlUrl == null ? null : htmlUrl,
        "description": description,
        "fork": fork == null ? null : fork,
        "url": url == null ? null : url,
        "forks_url": forksUrl == null ? null : forksUrl,
        "keys_url": keysUrl == null ? null : keysUrl,
        "collaborators_url": collaboratorsUrl == null ? null : collaboratorsUrl,
        "teams_url": teamsUrl == null ? null : teamsUrl,
        "hooks_url": hooksUrl == null ? null : hooksUrl,
        "issue_events_url": issueEventsUrl == null ? null : issueEventsUrl,
        "events_url": eventsUrl == null ? null : eventsUrl,
        "assignees_url": assigneesUrl == null ? null : assigneesUrl,
        "branches_url": branchesUrl == null ? null : branchesUrl,
        "tags_url": tagsUrl == null ? null : tagsUrl,
        "blobs_url": blobsUrl == null ? null : blobsUrl,
        "git_tags_url": gitTagsUrl == null ? null : gitTagsUrl,
        "git_refs_url": gitRefsUrl == null ? null : gitRefsUrl,
        "trees_url": treesUrl == null ? null : treesUrl,
        "statuses_url": statusesUrl == null ? null : statusesUrl,
        "languages_url": languagesUrl == null ? null : languagesUrl,
        "stargazers_url": stargazersUrl == null ? null : stargazersUrl,
        "contributors_url": contributorsUrl == null ? null : contributorsUrl,
        "subscribers_url": subscribersUrl == null ? null : subscribersUrl,
        "subscription_url": subscriptionUrl == null ? null : subscriptionUrl,
        "commits_url": commitsUrl == null ? null : commitsUrl,
        "git_commits_url": gitCommitsUrl == null ? null : gitCommitsUrl,
        "comments_url": commentsUrl == null ? null : commentsUrl,
        "issue_comment_url": issueCommentUrl == null ? null : issueCommentUrl,
        "contents_url": contentsUrl == null ? null : contentsUrl,
        "compare_url": compareUrl == null ? null : compareUrl,
        "merges_url": mergesUrl == null ? null : mergesUrl,
        "archive_url": archiveUrl == null ? null : archiveUrl,
        "downloads_url": downloadsUrl == null ? null : downloadsUrl,
        "issues_url": issuesUrl == null ? null : issuesUrl,
        "pulls_url": pullsUrl == null ? null : pullsUrl,
        "milestones_url": milestonesUrl == null ? null : milestonesUrl,
        "notifications_url": notificationsUrl == null ? null : notificationsUrl,
        "labels_url": labelsUrl == null ? null : labelsUrl,
        "releases_url": releasesUrl == null ? null : releasesUrl,
        "deployments_url": deploymentsUrl == null ? null : deploymentsUrl,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "pushed_at": pushedAt == null ? null : pushedAt.toIso8601String(),
        "git_url": gitUrl == null ? null : gitUrl,
        "ssh_url": sshUrl == null ? null : sshUrl,
        "clone_url": cloneUrl == null ? null : cloneUrl,
        "svn_url": svnUrl == null ? null : svnUrl,
        "homepage": homepage,
        "size": size == null ? null : size,
        "stargazers_count": stargazersCount == null ? null : stargazersCount,
        "watchers_count": watchersCount == null ? null : watchersCount,
        "language": language,
        "has_issues": hasIssues == null ? null : hasIssues,
        "has_projects": hasProjects == null ? null : hasProjects,
        "has_downloads": hasDownloads == null ? null : hasDownloads,
        "has_wiki": hasWiki == null ? null : hasWiki,
        "has_pages": hasPages == null ? null : hasPages,
        "forks_count": forksCount == null ? null : forksCount,
        "mirror_url": mirrorUrl,
        "archived": archived == null ? null : archived,
        "disabled": disabled == null ? null : disabled,
        "open_issues_count": openIssuesCount == null ? null : openIssuesCount,
        "license": license,
        "forks": forks == null ? null : forks,
        "open_issues": openIssues == null ? null : openIssues,
        "watchers": watchers == null ? null : watchers,
        "default_branch": defaultBranch == null ? null : defaultBranch,
    };
}

class Links {
    Links({
        this.self,
        this.html,
        this.issue,
        this.comments,
        this.reviewComments,
        this.reviewComment,
        this.commits,
        this.statuses,
    });

    final Comments self;
    final Comments html;
    final Comments issue;
    final Comments comments;
    final Comments reviewComments;
    final Comments reviewComment;
    final Comments commits;
    final Comments statuses;

    factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"] == null ? null : Comments.fromJson(json["self"]),
        html: json["html"] == null ? null : Comments.fromJson(json["html"]),
        issue: json["issue"] == null ? null : Comments.fromJson(json["issue"]),
        comments: json["comments"] == null ? null : Comments.fromJson(json["comments"]),
        reviewComments: json["review_comments"] == null ? null : Comments.fromJson(json["review_comments"]),
        reviewComment: json["review_comment"] == null ? null : Comments.fromJson(json["review_comment"]),
        commits: json["commits"] == null ? null : Comments.fromJson(json["commits"]),
        statuses: json["statuses"] == null ? null : Comments.fromJson(json["statuses"]),
    );

    Map<String, dynamic> toJson() => {
        "self": self == null ? null : self.toJson(),
        "html": html == null ? null : html.toJson(),
        "issue": issue == null ? null : issue.toJson(),
        "comments": comments == null ? null : comments.toJson(),
        "review_comments": reviewComments == null ? null : reviewComments.toJson(),
        "review_comment": reviewComment == null ? null : reviewComment.toJson(),
        "commits": commits == null ? null : commits.toJson(),
        "statuses": statuses == null ? null : statuses.toJson(),
    };
}

class Comments {
    Comments({
        this.href,
    });

    final String href;

    factory Comments.fromRawJson(String str) => Comments.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        href: json["href"] == null ? null : json["href"],
    );

    Map<String, dynamic> toJson() => {
        "href": href == null ? null : href,
    };
}

enum Ref { THE_ALPHAMERC_PATCH_1, REFS_HEADS_MASTER }

final refValues = EnumValues({
    "refs/heads/master": Ref.REFS_HEADS_MASTER,
    "TheAlphamerc-patch-1": Ref.THE_ALPHAMERC_PATCH_1
});


enum UserEventType { ISSUE_COMMENT_EVENT, PUSH_EVENT, WATCH_EVENT, CREATE_EVENT, ISSUES_EVENT, DELETE_EVENT, PULL_REQUEST_EVENT }

final userEventTypeValues = EnumValues({
    "CreateEvent": UserEventType.CREATE_EVENT,
    "IssuesEvent": UserEventType.ISSUES_EVENT,
    "IssueCommentEvent": UserEventType.ISSUE_COMMENT_EVENT,
    "PushEvent": UserEventType.PUSH_EVENT,
    "WatchEvent": UserEventType.WATCH_EVENT,
    "DeleteEvent": UserEventType.DELETE_EVENT,
    "PullRequestEvent": UserEventType.PULL_REQUEST_EVENT,
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
