import 'package:meta/meta.dart';
import 'package:timeago/timeago.dart' as timeago;

class Post {
  List<String> imageUrls;
  User user;
  DateTime postedAt;

  List<Comment> comments;
  String location;

  String timeAgo() {
    final now = DateTime.now();
    return timeago.format(now.subtract(now.difference(postedAt)));
  }

  Post({
    @required this.imageUrls,
    @required this.user,
    @required this.postedAt,
    this.comments = const <Comment>[],
    this.location,
  });
}

class User {
  String name;

  String imageUrl;

  User({
    @required this.name,
    this.imageUrl,
  });
}

class Comment {
  String text;
  User user;
  DateTime commentedAt;

  Comment({
    @required this.text,
    @required this.user,
    @required this.commentedAt,
  });
}
