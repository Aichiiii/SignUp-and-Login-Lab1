import 'dart:io';

// A single feed post: the picked image plus an optional caption.
// Kept in memory for this demo (no backend / persistence yet).
class Post {
  final File image;
  final String caption;
  final DateTime createdAt;

  Post({
    required this.image,
    this.caption = '',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}