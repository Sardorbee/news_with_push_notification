class FcmResponseModel {
  String? newsID;
  String author;
  String title;
  String description;
  String imageUrl;
  String publishedAt;
  String content;

  FcmResponseModel({
    required this.author,
    this.newsID,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.publishedAt,
    required this.content,
  });

  FcmResponseModel copyWith({
    String? newsID,
    String? author,
    String? title,
    String? description,
    String? imageUrl,
    String? publishedAt,
    String? content,
  }) {
    return FcmResponseModel(
      newsID: newsID ?? this.newsID,
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
    );
  }

  factory FcmResponseModel.fromJson(Map<String, dynamic> json) {
    return FcmResponseModel(
      author: json["author"],
      newsID: json["newsID"],
      title: json["title"],
      description: json["description"],
      imageUrl: json["imageUrl"],
      publishedAt: json["publishedAt"],
      content: json["content"],
    );
  }

  Map<String, dynamic> toJson() => {
    "author": author,
    "newsID": newsID,
    "title": title,
    "description": description,
    "imageUrl": imageUrl,
    "publishedAt": publishedAt,
    "content": content,
  };
}
