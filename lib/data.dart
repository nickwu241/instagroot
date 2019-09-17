import 'package:instagroot/models.dart';

class Data {
  static User getCurrentUser() {
    return nickwu241;
  }

  static List<Post> getPostsForHomeFeed() {
    return <Post>[
      Post(
        user: grootlover,
        imageUrls: [
          'assets/images/groot1.jpg',
          'assets/images/groot4.jpg',
          'assets/images/groot5.jpg',
        ],
        likes: [
          Like(user: rocket),
          Like(user: starlord),
          Like(user: gamora),
          Like(user: nickwu241),
        ],
        comments: [
          Comment(
            text: 'So we’re saving the galaxy again? #gotg',
            user: rocket,
            commentedAt: DateTime(2019, 5, 23, 14, 35, 0),
            likes: [Like(user: nickwu241)],
          ),
        ],
        location: 'Earth',
        postedAt: DateTime(2019, 5, 23, 12, 35, 0),
      ),
      Post(
        user: nickwu241,
        imageUrls: ['assets/images/groot2.jpg'],
        likes: [],
        comments: [],
        location: 'Knowhere',
        postedAt: DateTime(2019, 5, 21, 6, 0, 0),
      ),
      Post(
        user: nebula,
        imageUrls: ['assets/images/groot6.jpg'],
        likes: [Like(user: nickwu241)],
        comments: [],
        location: 'Nine Realms',
        postedAt: DateTime(2019, 5, 2, 0, 0, 0),
      ),
    ];
  }
}

const placeholderStories = <Story>[Story()];

const nickwu241 = User(
  name: 'nickwu241',
  profileImageUrl: 'assets/images/nickwu241.jpg',
  stories: [],
  following: [grootlover, starlord, gamora, rocket, nebula],
);
const grootlover = User(
  name: 'grootlover',
  profileImageUrl: 'assets/images/grootlover.jpg',
  stories: placeholderStories,
  following: [],
);
const starlord = User(
  name: 'starlord',
  profileImageUrl: 'assets/images/starlord.jpg',
  stories: placeholderStories,
  following: [],
);
const gamora = User(
  name: 'gamora',
  profileImageUrl: 'assets/images/gamora.jpg',
  stories: placeholderStories,
  following: [],
);
const rocket = User(
  name: 'rocket',
  profileImageUrl: 'assets/images/rocket.jpg',
  stories: placeholderStories,
  following: [],
);
const nebula = User(
  name: 'nebula',
  profileImageUrl: 'assets/images/nebula.jpg',
  stories: placeholderStories,
  following: [],
);
