import 'package:flutter/material.dart';

void main() {
  runApp(const InstagramLayoutRecreationApp());
}

class InstagramLayoutRecreationApp extends StatelessWidget {
  const InstagramLayoutRecreationApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Layout Recreation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0.5,
        ),
      ),
      home: const InstagramHomePage(),
    );
  }
}

class InstagramHomePage extends StatelessWidget {
  const InstagramHomePage({super.key});
  static const posterText =
      'The newest photo update on a bright weekend exploring downtown vibes.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const _InstagramAppBar(),
            const SizedBox(height: 12),
            const _StoriesRow(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  _PostCard(),
                  SizedBox(height: 16),
                  _PostCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InstagramAppBar extends StatelessWidget {
  const _InstagramAppBar();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: const [
          Text(
            'Instagram',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 28,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          Spacer(),
          Icon(Icons.favorite_border, size: 28),
          SizedBox(width: 18),
          Icon(Icons.send, size: 28),
        ],
      ),
    );
  }
}

class _StoriesRow extends StatelessWidget {
  const _StoriesRow();
  @override
  Widget build(BuildContext context) {
    final stories = ['Your Story', 'davao', 'kani', 'rowan', 'temp'];
    return SizedBox(
      height: 120,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return _StoryBubble(label: stories[index]);
        },
      ),
    );
  }
}

class _StoryBubble extends StatelessWidget {
  const _StoryBubble({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFFDE0046), Color(0xFFF7A34B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(4),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.black54, size: 34),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 72,
          child: Text(
            label,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFFEFEFEF),
              child: Icon(Icons.person, color: Colors.black54),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'sibyl_davao',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Makati, Philippines',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.more_horiz),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 320,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.image, size: 80, color: Colors.white70),
        ),
        const SizedBox(height: 12),
        Row(
          children: const [
            Icon(Icons.favorite_border, size: 28),
            SizedBox(width: 18),
            Icon(Icons.mode_comment_outlined, size: 28),
            SizedBox(width: 18),
            Icon(Icons.send_outlined, size: 28),
            Spacer(),
            Icon(Icons.bookmark_border, size: 28),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          '1,280 likes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        RichText(
          text: const TextSpan(
            style: TextStyle(color: Colors.black87),
            children: [
              TextSpan(
                text: 'sibyl_davao ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'Enjoying the weekend around the city. Sunshine and weekend plans with the best crew!',
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'View all 42 comments',
          style: TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 8),
        const Text(
          '2 hours ago',
          style: TextStyle(color: Colors.black54, fontSize: 12),
        ),
      ],
    );
  }
}
