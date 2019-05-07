import 'package:meta/meta.dart';
import 'package:timeago/timeago.dart' as timeago;

const nickwu241 =
    User(name: 'nickwu241', imageUrl: 'assets/images/nickwu241.jpg');
const grootlover =
    User(name: 'grootlover', imageUrl: 'assets/images/grootlover.jpg');
const currentUser = nickwu241;

class Post {
  List<String> imageUrls;
  final User user;
  final DateTime postedAt;
 
  List<Like> likes;
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
    this.likes = const <Like>[],
    this.comments = const <Comment>[],
    this.location,
  });
}

class User {
  final String name;

  final String imageUrl;

  const User({
    @required this.name,
    this.imageUrl,
  });
}

class Comment {
  String text;
  final User user;
  final DateTime commentedAt;

  Comment({
    @required this.text,
    @required this.user,
    @required this.commentedAt,
  });
}

class Like {
  final User user;

  Like({@required this.user});
}
