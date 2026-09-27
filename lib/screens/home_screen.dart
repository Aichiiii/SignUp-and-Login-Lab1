import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/app_logo.dart';

// A single feed entry: just an asset path + caption for now.
// Swap the paths below for your own photos whenever you're ready —
// drop the files into assets/images/ with matching names.
class _FeedPost {
  final String assetPath;
  final String caption;
  const _FeedPost(this.assetPath, this.caption);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ---------------------------------------------------------------
  // Placeholder feed content. Replace these three asset paths with
  // your own images (keep them in assets/images/ and register any
  // new filenames in pubspec.yaml under flutter > assets).
  // ---------------------------------------------------------------
  static const List<_FeedPost> _posts = [
    _FeedPost('assets/post1.jpg', 'Post 1'),
    _FeedPost('assets/post2.jpg', 'Post 2'),
    _FeedPost('assets/post3.jpg', 'Post 3'),
  ];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    final name = args?['name'] ?? 'Friend';

    final left = <_FeedPost>[];
    final right = <_FeedPost>[];
    for (var i = 0; i < _posts.length; i++) {
      (i.isEven ? left : right).add(_posts[i]);
    }

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 20,
        title: Row(
          children: const [
            AppLogo(size: 44),
            SizedBox(width: 10),
            Text(
              'Pinsy',
              style: TextStyle(
                color: AppColors.brownDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Log out',
            icon: const Icon(Icons.logout, color: AppColors.brownDark),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
                child: Text(
                  'Welcome, $name!',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.brownDark,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 2, 20, 12),
                child: Text(
                  "Here's what's new in your feed",
                  style: TextStyle(fontSize: 13, color: AppColors.hint),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Column(
                              children: left.map(_postCard).toList())),
                      const SizedBox(width: 12),
                      Expanded(
                          child: Column(
                              children: right.map(_postCard).toList())),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _postCard(_FeedPost post) {
    final height = 180.0 + (post.assetPath.hashCode % 100).abs();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.brownDark.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: height,
            child: Image.asset(post.assetPath, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    color: AppColors.brown,
                    shape: BoxShape.circle,
                  ),
                  child:
                      const Icon(Icons.person, color: Colors.white, size: 13),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    post.caption,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.brownDark,
                    ),
                  ),
                ),
                const Icon(Icons.favorite_border,
                    size: 16, color: AppColors.hint),
              ],
            ),
          ),
        ],
      ),
    );
  }
}