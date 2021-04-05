class BaseQuoteModel {
  BaseQuoteModel({
    this.userId,
    this.id,
    this.title,
    this.body,
    this.isSelected=false
  });

  int userId;
  int id;
  String title;
  String body;
  bool isSelected;

  factory BaseQuoteModel.fromJson(Map<String, dynamic> json) => BaseQuoteModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}

