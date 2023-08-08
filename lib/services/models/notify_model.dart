
class NotifyModel {
    String title;
    String body;

    NotifyModel({
        required this.title,
        required this.body,
    });

    factory NotifyModel.fromJson(Map<String, dynamic> json) => NotifyModel(
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
    };
}