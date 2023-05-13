class ToDoModel {
  final int? id;
  final String title;
  final String description;
  final String date;

  ToDoModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  factory ToDoModel.fromMap(Map<String, dynamic> json) {
    return ToDoModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      date: json["date"],
    );
  }

  Map<String, dynamic> toMap() => {
    "id" :id,
    "title": title,
    "description": description,
    "date": date,
  };
}