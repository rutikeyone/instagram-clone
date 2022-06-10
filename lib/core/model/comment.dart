import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String profilePicture;
  final String name;
  final String uid;
  final String comment;
  final String commentId;
  final DateTime datePublished;

  const Comment({
    required this.profilePicture,
    required this.name,
    required this.uid,
    required this.comment,
    required this.commentId,
    required this.datePublished,
  });

  Comment.pure()
      : profilePicture = "",
        name = "",
        uid = "",
        comment = "",
        commentId = "",
        datePublished = DateTime.now();

  @override
  List<Object?> get props =>
      [profilePicture, name, uid, comment, commentId, datePublished];

  static Comment fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Comment(
      profilePicture: snapshot["profilePicture"],
      uid: snapshot["uid"],
      name: snapshot["name"],
      datePublished: (snapshot["datePublished"] as Timestamp).toDate(),
      comment: snapshot["comment"],
      commentId: snapshot['commentId'],
    );
  }

  Map<String, dynamic> toJson() => {
        "profilePicture": profilePicture,
        "name": name,
        "uid": uid,
        "comment": comment,
        "commentId": commentId,
        "datePublished": datePublished.toString(),
      };
}
