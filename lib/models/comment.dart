class Comment {
  final int id;
  final String? text;
  final String? by;
  final int? time;
  final List<int>? kids;

  Comment({
    required this.id,
    this.text,
    this.by,
    this.time,
    this.kids,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      text: json['text'],
      by: json['by'],
      time: json['time'],
      kids: json['kids'] != null ? List<int>.from(json['kids']) : null,
    );
  }
}
