class Author {
  final String id;
  final String name;
  final String username;
  final String profileImage;
  final String bio;

  const Author({
    required this.id,
    required this.name,
    required this.username,
    required this.profileImage,
    required this.bio,
  });
}

class TableOfContentsItem {
  final String id;
  final String title;
  final int level;
  final int position;

  const TableOfContentsItem({
    required this.id,
    required this.title,
    required this.level,
    required this.position,
  });
}

class Article {
  final String id;
  final String title;
  final String subtitle;
  final String content;
  final String coverImage;
  final Author author;
  final DateTime publishedAt;
  final List<String> tags;
  final List<TableOfContentsItem> tableOfContents;

  const Article({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.coverImage,
    required this.author,
    required this.publishedAt,
    required this.tags,
    this.tableOfContents = const [],
  });
}
