import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String description;
  final String uid;
  final String username;
  final List likes;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profileImage;

  @override
  List<Object?> get props => [
        description,
        uid,
        username,
        likes,
        postId,
        datePublished,
        postUrl,
        profileImage
      ];

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profileImage,
  });

  Post.empty()
      : description = "",
        uid = "",
        username = "",
        likes = const [],
        postId = "",
        datePublished = DateTime.now(),
        postUrl = "",
        profileImage = '';

  static Post fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        description: snapshot["description"],
        uid: snapshot["uid"],
        likes: snapshot["likes"],
        postId: snapshot["postId"],
        datePublished: (snapshot["datePublished"] as Timestamp).toDate(),
        username: snapshot["username"],
        postUrl: snapshot['postUrl'],
        profileImage: snapshot['profImage']);
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "likes": likes,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        'postUrl': postUrl,
        'profImage': profileImage
      };
}
