import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final int initialLikes;

  const LikeButton({
    super.key,
    this.initialLikes = 0,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  int _likeCount = 0;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.initialLikes;
  }

  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        _likeCount--;
      } else {
        _likeCount++;
      }
      _isLiked = !_isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleLike,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _isLiked ? Icons.favorite : Icons.favorite_border,
            color: _isLiked ? Colors.red : Colors.grey,
            size: 30,
          ),
          const SizedBox(width: 8),
          Text(
            '$_likeCount likes',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}