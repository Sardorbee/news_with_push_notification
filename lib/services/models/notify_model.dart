class NotifyModel {
    String title;
    String body;

    NotifyModel({
        required this.title,
        required this.body,
    });

    NotifyModel copyWith({
        String? title,
        String? body,
    }) {
        return NotifyModel(
            title: title ?? this.title,
            body: body ?? this.body,
        );
    }

    factory NotifyModel.fromJson(Map<String, dynamic> json) => NotifyModel(
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
    };
}
