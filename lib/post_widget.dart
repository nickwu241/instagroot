import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:instagroot/models.dart';

class PostWidget extends StatefulWidget {
  final Post post;

  PostWidget(this.post);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool _isLiked = false;
  int _currentImageIndex = 0;

  void _likePhoto() {
    setState(() {
      _isLiked = true;
    });
  }

  void _toggleIsLiked() {
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  void _updateImageIndex(int index) {
    setState(() {
      _currentImageIndex = index;
    });
  }

  void _showAddCommentModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Row(
            children: <Widget>[
              _buildProfileAvatar(),
              Expanded(
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              FlatButton(
                child: Opacity(
                  opacity: 0.4,
                  child: Text(
                    'Post',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                onPressed: null,
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileAvatar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundImage: AssetImage(widget.post.user.imageUrl),
        radius: 16.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // User Details
        Row(
          children: <Widget>[
            _buildProfileAvatar(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.post.user.name,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(widget.post.location)
              ],
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            )
          ],
        ),
        // Photo Carosuel
        GestureDetector(
          child: CarouselSlider(
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
          onDoubleTap: _likePhoto,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: _isLiked
                  ? Icon(Icons.favorite, color: Colors.red)
                  : Icon(Icons.favorite_border),
              onPressed: _toggleIsLiked,
            ),
            IconButton(
              icon: Icon(Icons.chat_bubble_outline),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(OMIcons.share),
              onPressed: () {},
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
              icon: Icon(Icons.bookmark_border),
              onPressed: () {},
            )
          ],
        ),
        Row(
          children: <Widget>[],
        ),
        // Liked by
        Row(
          children: <Widget>[],
        ),
        // Comments
        Row(
          children: <Widget>[],
        ),
        // Add a comment...
        Row(
          children: <Widget>[
            _buildProfileAvatar(),
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
