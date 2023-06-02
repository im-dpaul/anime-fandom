// To parse this JSON data, do
//
//     final allPostModel = allPostModelFromJson(jsonString);

import 'dart:convert';

AllPostModel allPostModelFromJson(String str) =>
    AllPostModel.fromJson(json.decode(str));

String allPostModelToJson(AllPostModel data) => json.encode(data.toJson());

class AllPostModel {
  bool? success;
  List<Post>? posts;

  AllPostModel({
    this.success,
    this.posts,
  });

  factory AllPostModel.fromJson(Map<String, dynamic> json) => AllPostModel(
        success: json["success"],
        posts: json["posts"] == null
            ? []
            : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "posts": posts == null
            ? []
            : List<dynamic>.from(posts!.map((x) => x.toJson())),
      };
}

class Post {
  String? id;
  String? userId;
  String? firstName;
  String? lastName;
  String? avatar;
  bool? isLiked;
  bool? isFavorites;
  String? description;
  int? numOfComments;
  int? numOfLikes;
  String? location;
  List<Like>? likes;
  List<Comment>? comments;
  List<Favorite>? favorites;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  Content? content;

  Post({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.avatar,
    this.isLiked,
    this.isFavorites,
    this.description,
    this.numOfComments,
    this.numOfLikes,
    this.location,
    this.likes,
    this.comments,
    this.favorites,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.content,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        avatar: json["avatar"],
        isLiked: json["isLiked"],
        isFavorites: json["isFavorites"],
        description: json["description"],
        numOfComments: json["numOfComments"],
        numOfLikes: json["numOfLikes"],
        location: json["location"],
        likes: json["likes"] == null
            ? []
            : List<Like>.from(json["likes"]!.map((x) => Like.fromJson(x))),
        comments: json["comments"] == null
            ? []
            : List<Comment>.from(
                json["comments"]!.map((x) => Comment.fromJson(x))),
        favorites: json["favorites"] == null
            ? []
            : List<Favorite>.from(
                json["favorites"]!.map((x) => Favorite.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        content:
            json["content"] == null ? null : Content.fromJson(json["content"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "avatar": avatar,
        "isLiked": isLiked,
        "isFavorites": isFavorites,
        "description": description,
        "numOfComments": numOfComments,
        "numOfLikes": numOfLikes,
        "location": location,
        "likes": likes == null
            ? []
            : List<dynamic>.from(likes!.map((x) => x.toJson())),
        "comments": comments == null
            ? []
            : List<dynamic>.from(comments!.map((x) => x.toJson())),
        "favorites": favorites == null
            ? []
            : List<dynamic>.from(favorites!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "content": content?.toJson(),
      };
}

class Comment {
  String? user;
  String? firstName;
  String? lastName;
  String? avatar;
  String? comment;
  bool? isCommented;
  String? id;

  Comment({
    this.user,
    this.firstName,
    this.lastName,
    this.avatar,
    this.comment,
    this.isCommented,
    this.id,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        user: json["user"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        avatar: json["avatar"],
        comment: json["comment"],
        isCommented: json["isCommented"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "firstName": firstName,
        "lastName": lastName,
        "avatar": avatar,
        "comment": comment,
        "isCommented": isCommented,
        "_id": id,
      };
}

class Content {
  String? publicId;
  String? url;

  Content({
    this.publicId,
    this.url,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        publicId: json["public_id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "public_id": publicId,
        "url": url,
      };
}

class Favorite {
  String? user;
  String? id;

  Favorite({
    this.user,
    this.id,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        user: json["user"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "_id": id,
      };
}

class Like {
  String? user;
  String? firstName;
  String? lastName;
  String? avatar;
  String? id;

  Like({
    this.user,
    this.firstName,
    this.lastName,
    this.avatar,
    this.id,
  });

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        user: json["user"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        avatar: json["avatar"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "firstName": firstName,
        "lastName": lastName,
        "avatar": avatar,
        "_id": id,
      };
}
