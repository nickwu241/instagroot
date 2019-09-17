import 'package:flutter/material.dart';
import 'package:instagroot/data.dart';
import 'package:instagroot/heart_icon_animator.dart';
import 'package:instagroot/models.dart';
import 'package:instagroot/ui_utils.dart';

class CommentWidget extends StatefulWidget {
  final Comment comment;

  CommentWidget(this.comment);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  void _toggleIsLiked() {
    setState(() => widget.comment.toggleLikeFor(Data.getCurrentUser()));
  }

  Text _buildRichText() {
    var currentTextData = StringBuffer();
    var textSpans = <TextSpan>[
      TextSpan(text: '${widget.comment.user.name} ', style: bold),
    ];
    this.widget.comment.text.split(' ').forEach((word) {
      if (word.startsWith('#') && word.length > 1) {
        if (currentTextData.isNotEmpty) {
          textSpans.add(TextSpan(text: currentTextData.toString()));
          currentTextData.clear();
        }
        textSpans.add(TextSpan(text: '$word ', style: link));
      } else {
        currentTextData.write('$word ');
      }
    });
    if (currentTextData.isNotEmpty) {
      textSpans.add(TextSpan(text: currentTextData.toString()));
      currentTextData.clear();
    }
    return Text.rich(TextSpan(children: textSpans));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        children: <Widget>[
          _buildRichText(),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: HeartIconAnimator(
              isLiked: widget.comment.isLikedBy(Data.getCurrentUser()),
              size: 14.0,
              onTap: _toggleIsLiked,
            ),
          ),
        ],
      ),
    );
  }
}
