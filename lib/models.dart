import 'package:meta/meta.dart';
import 'package:timeago/timeago.dart' as timeago;

const placeholderStories = <Story>[Story()];

const nickwu241 =
    User(name: 'nickwu241', imageUrl: 'assets/images/nickwu241.jpg');
const grootlover = User(
    name: 'grootlover',
    imageUrl: 'assets/images/grootlover.jpg',
    stories: placeholderStories);
const starlord = User(
    name: 'starlord',
    imageUrl: 'assets/images/starlord.jpg',
    stories: placeholderStories);
const gamora = User(
    name: 'gamora',
    imageUrl: 'assets/images/gamora.jpg',
    stories: placeholderStories);
const rocket = User(
    name: 'rocket',
    imageUrl: 'assets/images/rocket.jpg',
    stories: placeholderStories);
const nebula = User(
    name: 'nebula',
    imageUrl: 'assets/images/nebula.jpg',
    stories: placeholderStories);

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

  bool isLikedBy(User user) {
    return likes.any((like) => like.user.name == user.name);
  }

  void addLikeIfUnlikedFor(User user) {
    if (!isLikedBy(user)) {
      likes.add(Like(user: user));
    }
  }

  void toggleLikeFor(User user) {
    if (isLikedBy(user)) {
      likes.removeWhere((like) => like.user.name == user.name);
    } else {
      addLikeIfUnlikedFor(user);
    }
  }

  Post({
    @required this.imageUrls,
    @required this.user,
    @required this.postedAt,
    @required this.likes,
    @required this.comments,
    this.location,
  });
}

class User {
  final String name;

  final String imageUrl;
  final List<Story> stories;

  const User({
    @required this.name,
    this.imageUrl,
    this.stories = const <Story>[],
  });
}

class Comment {
  String text;
  final User user;
  final DateTime commentedAt;
  List<Like> likes;

  bool isLikedBy(User user) {
    return likes.any((like) => like.user.name == user.name);
  }

  void toggleLikeFor(User user) {
    if (isLikedBy(user)) {
      likes.removeWhere((like) => like.user.name == user.name);
    } else {
      likes.add(Like(user: user));
    }
  }

  Comment({
    @required this.text,
    @required this.user,
    @required this.commentedAt,
    @required this.likes,
  });
}

class Like {
  final User user;

  Like({@required this.user});
}

class Story {
  const Story();
}
