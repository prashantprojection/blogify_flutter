class Comment {
  final String id;
  final String authorName;
  final String authorImageUrl;
  final String content;
  final DateTime createdAt;
  final int likesCount;
  final bool isLiked;
  final List<Comment>? replies;

  Comment({
    required this.id,
    required this.authorName,
    required this.authorImageUrl,
    required this.content,
    required this.createdAt,
    this.likesCount = 0,
    this.isLiked = false,
    this.replies,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String,
      authorName: json['authorName'] as String,
      authorImageUrl: json['authorImageUrl'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      likesCount: json['likesCount'] as int? ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
      replies: json['replies'] != null
          ? (json['replies'] as List)
              .map((reply) => Comment.fromJson(reply as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorName': authorName,
      'authorImageUrl': authorImageUrl,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'likesCount': likesCount,
      'isLiked': isLiked,
      'replies': replies?.map((reply) => reply.toJson()).toList(),
    };
  }
}
