// To parse this JSON data, do
//
//     final allFavouriteModel = allFavouriteModelFromJson(jsonString);

import 'dart:convert';

AllFavouriteModel allFavouriteModelFromJson(String str) =>
    AllFavouriteModel.fromJson(json.decode(str));

String allFavouriteModelToJson(AllFavouriteModel data) =>
    json.encode(data.toJson());

class AllFavouriteModel {
  bool? success;
  List<Post>? data;

  AllFavouriteModel({
    this.success,
    this.data,
  });

  factory AllFavouriteModel.fromJson(Map<String, dynamic> json) =>
      AllFavouriteModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Post>.from(json["data"]!.map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Post {
  Content? content;
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
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<Favorite>? favorites;

  Post({
    this.content,
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
    this.createdAt,
    this.updatedAt,
    this.v,
    this.favorites,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        content:
            json["content"] == null ? null : Content.fromJson(json["content"]),
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
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        favorites: json["favorites"] == null
            ? []
            : List<Favorite>.from(
                json["favorites"]!.map((x) => Favorite.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "content": content?.toJson(),
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
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "favorites": favorites == null
            ? []
            : List<dynamic>.from(favorites!.map((x) => x.toJson())),
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
  DateTime? createdAt;

  Favorite({
    this.user,
    this.id,
    this.createdAt,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        user: json["user"],
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
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
