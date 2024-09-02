class Todo {
  final String title;
  final String? subtitle;
  final bool isDone;

  // Constructor: initializes a Todo instance
  Todo({required this.title, this.subtitle, this.isDone = false});

  // Creates a copy of the current Todo with updated fields
  Todo copyWith({String? title, String? subtitle, bool? isDone}) {
    return Todo(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isDone: isDone ?? this.isDone,
    );
  }

  // Creates a Todo instance from a JSON map
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      isDone: json['isDone'] as bool,
    );
  }

  // Converts the Todo instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'isDone': isDone,
    };
  }
}