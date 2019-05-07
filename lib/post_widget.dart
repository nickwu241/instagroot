import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:instagroot/models.dart';
import 'package:instagroot/ui_utils.dart';

class PostWidget extends StatefulWidget {
  final Post post;

  PostWidget(this.post);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> with TickerProviderStateMixin {
  AnimationController _likeController;
  AnimationController _likeOnImageController;
  Animation<double> _likeAnimation;
  Animation<double> _likeOnImageAnimation;
  bool _isLiked = false;
  bool _isSaved = false;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    final quick = const Duration(milliseconds: 500);
    final scaleTween = Tween(begin: 0.0, end: 1.0);
    _likeController = AnimationController(duration: quick, vsync: this);
    _likeOnImageController = AnimationController(duration: quick, vsync: this);
    _likeAnimation = scaleTween.animate(
      CurvedAnimation(
        parent: _likeController,
        curve: Curves.elasticOut,
      ),
    );
    _likeOnImageAnimation = scaleTween.animate(
      CurvedAnimation(
        parent: _likeOnImageController,
        curve: Curves.elasticOut,
      ),
    );
    _likeOnImageController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _likeOnImageController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.decelerate,
        );
      }
    });

    // Ensure a full scale like button on init.
    _likeController.animateTo(1.0, duration: Duration.zero);
  }

  @override
  void dispose() {
    _likeController.dispose();
    _likeOnImageController.dispose();
    super.dispose();
  }

  void _updateImageIndex(int index) {
    setState(() => _currentImageIndex = index);
  }

  void _onDoubleTapLikePhoto() {
    setState(() => _isLiked = true);
    _likeController
      ..reset()
      ..forward();
    _likeOnImageController
      ..reset()
      ..forward();
  }

  void _toggleIsLiked() {
    setState(() => _isLiked = !_isLiked);
    _likeController
      ..reset()
      ..forward();
  }

  void _toggleIsSaved() {
    setState(() => _isSaved = !_isSaved);
  }

  void _showAddCommentModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddCommentWidget(
            user: currentUser,
            onPost: () => Navigator.pop(context),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // User Details
        Row(
          children: <Widget>[
            AvatarWidget(imageUrl: widget.post.user.imageUrl),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.post.user.name,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                widget.post.location != null
                    ? Text(widget.post.location)
                    : Container(),
              ],
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () => showSnackbar(context, 'More'),
            )
          ],
        ),
        // Photo Carosuel
        GestureDetector(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              CarouselSlider(
                items: widget.post.imageUrls.map((url) {
                  return Image.asset(
                    url,
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width,
                  );
                }).toList(),
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                onPageChanged: _updateImageIndex,
              ),
              AnimatedBigHeart(animation: _likeOnImageAnimation),
            ],
          ),
          onDoubleTap: _onDoubleTapLikePhoto,
        ),
        // Action Bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ScaleTransition(
              scale: _likeAnimation,
              child: IconButton(
                icon: _isLiked
                    ? Icon(Icons.favorite, color: Colors.red)
                    : Icon(Icons.favorite_border),
                onPressed: _toggleIsLiked,
              ),
            ),
            IconButton(
              icon: Icon(Icons.chat_bubble_outline),
              onPressed: _showAddCommentModal,
            ),
            IconButton(
              icon: Icon(OMIcons.share),
              onPressed: () => showSnackbar(context, 'Share'),
            ),
            Spacer(),
            widget.post.imageUrls.length <= 1
                ? Container()
                : PhotoCarouselIndicator(
                    photoCount: widget.post.imageUrls.length,
                    activePhotoIndex: _currentImageIndex,
                  ),
            Spacer(),
            Spacer(),
            IconButton(
              icon:
                  _isSaved ? Icon(Icons.bookmark) : Icon(Icons.bookmark_border),
              onPressed: _toggleIsSaved,
            )
          ],
        ),
        Row(
          children: <Widget>[],
        ),
        // Liked by
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: _isLiked
              ? Row(
                  children: <Widget>[
                    Text('Liked by '),
                    Text(
                      currentUser.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                )
              : Container(),
        ),
        // Comments
        Row(
          children: <Widget>[],
        ),
        // Add a comment...
        Row(
          children: <Widget>[
            AvatarWidget(imageUrl: currentUser.imageUrl),
            GestureDetector(
              child: Text(
                'Add a comment...',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: _showAddCommentModal,
            ),
          ],
        ),
        // Posted Timestamp
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, left: 8.0),
              child: Text(
                widget.post.timeAgo(),
                style: TextStyle(color: Colors.grey, fontSize: 11.0),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class PhotoCarouselIndicator extends StatelessWidget {
  final int photoCount;
  final int activePhotoIndex;

  PhotoCarouselIndicator({
    @required this.photoCount,
    @required this.activePhotoIndex,
  });

  Widget _buildDot({bool isActive}) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: isActive ? 7.5 : 6.0,
          width: isActive ? 7.5 : 6.0,
          decoration: BoxDecoration(
            color: isActive ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(photoCount, (i) => i)
          .map((i) => _buildDot(isActive: i == activePhotoIndex))
          .toList(),
    );
  }
}

class AnimatedBigHeart extends AnimatedWidget {
  AnimatedBigHeart({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: listenable,
      child: Icon(
        Icons.favorite,
        size: 80.0,
        color: Colors.white70,
      ),
    );
  }
}

class AvatarWidget extends StatelessWidget {
  String imageUrl;

  AvatarWidget({@required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundImage: AssetImage(imageUrl),
        radius: 16.0,
      ),
    );
  }
}

class AddCommentWidget extends StatefulWidget {
  final User user;
  final VoidCallback onPost;

  AddCommentWidget({@required this.user, @required this.onPost});

  @override
  _AddCommentWidgetState createState() => _AddCommentWidgetState();
}

class _AddCommentWidgetState extends State<AddCommentWidget> {
  final _textController = TextEditingController();
  bool _canPost = false;

  @override
  void initState() {
    _textController.addListener(() {
      setState(() => _canPost = _textController.text.isNotEmpty);
    });
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        AvatarWidget(imageUrl: widget.user.imageUrl),
        Expanded(
          child: TextField(
            controller: _textController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Add a comment...',
              border: InputBorder.none,
            ),
          ),
        ),
        FlatButton(
          child: Opacity(
            opacity: _canPost ? 1.0 : 0.4,
            child: Text('Post', style: TextStyle(color: Colors.blue)),
          ),
          onPressed: _canPost ? widget.onPost : null,
        )
      ],
    );
  }
}
