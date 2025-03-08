import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final forums = [
  {
    'title': 'Best practices for React hooks',
    'description':
        'Started a discussion about useEffect dependencies and cleanup',
    'replies': '32',
    'views': '128',
    'likes': '45',
    'timeAgo': '2h ago',
  },
  {
    'title': 'Next.js vs Remix - Pros and Cons',
    'description':
        'Comparing modern React frameworks for enterprise applications',
    'replies': '56',
    'views': '342',
    'likes': '89',
    'timeAgo': '1d ago',
  },
];

final notifications = [
  {
    'type': 'like',
    'user': 'John Doe',
    'action': 'liked your post',
    'target': 'Understanding React Hooks',
    'timeAgo': '2h ago',
  },
  {
    'type': 'comment',
    'user': 'Emma Wilson',
    'action': 'commented on your post',
    'target': 'TypeScript Best Practices',
    'timeAgo': '3h ago',
  },
  {
    'type': 'follow',
    'user': 'Alex Chen',
    'action': 'started following you',
    'target': '',
    'timeAgo': '5h ago',
  },
];

final latestComments = [
  {
    'author': 'Sarah Anderson',
    'content':
        'Great article! The React hooks explanation really helped me understand useEffect better.',
    'timeAgo': '2h ago',
    'postTitle': 'Understanding React Hooks',
    'postId': '1',
  },
  {
    'author': 'Sarah Anderson',
    'content':
        'The comparison between Next.js and Remix is very insightful. Would love to see more content like this.',
    'timeAgo': '1d ago',
    'postTitle': 'Next.js vs Remix Comparison',
    'postId': '2',
  },
];

final socialMedia = [
  {
    'platform': 'Twitter',
    'handle': '@sarahanderson',
    'icon': FontAwesomeIcons.twitter,
    'isActive': true,
  },
  {
    'platform': 'LinkedIn',
    'handle': 'Sarah Anderson',
    'icon': FontAwesomeIcons.linkedin,
    'isActive': true,
  },
  {
    'platform': 'GitHub',
    'handle': 'sarahanderson',
    'icon': FontAwesomeIcons.github,
    'isActive': false,
  },
];
final followers = [
  {
    'name': 'Alex Chen',
    'username': '@alexchen',
    'image': 'https://randomuser.me/api/portraits/men/1.jpg',
    'isFollowing': false,
  },
  {
    'name': 'Maria Garcia',
    'username': '@mariagarcia',
    'image': 'https://randomuser.me/api/portraits/women/2.jpg',
    'isFollowing': true,
  },
];

final following = [
  {
    'name': 'John Smith',
    'username': '@johnsmith',
    'image': 'https://randomuser.me/api/portraits/men/2.jpg',
    'isFollowing': true,
  },
  {
    'name': 'Emma Wilson',
    'username': '@emmawilson',
    'image': 'https://randomuser.me/api/portraits/women/3.jpg',
    'isFollowing': true,
  },
];
final posts = [
  {
    'title': 'Getting Started with React Hooks',
    'image': 'assets/react_hooks.png',
    'tags': ['React', 'Tutorial', 'Frontend'],
  },
  {
    'title': 'TypeScript Best Practices',
    'image': 'assets/typescript.png',
    'tags': ['TypeScript', 'Development'],
  },
];
