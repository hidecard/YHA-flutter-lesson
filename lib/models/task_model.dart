class Task {
  int? id;
  String title;
  String description;
  int isCompleted; // 0 = pending, 1 = completed

  Task({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'],
    );
  }
}
