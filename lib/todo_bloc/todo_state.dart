
part of 'todo_bloc.dart';

// Enum to represent different states of the todo list
enum TodoStatus { initial, loading, success, error }

class TodoState extends Equatable {
  final List<Todo> todos;
  final TodoStatus status;
  final String? errorMessage;

  // Constructor: initializes the state with default values
  const TodoState({
    this.todos = const [],
    this.status = TodoStatus.initial,
    this.errorMessage,
  });

  // Creates a copy of the current state with updated fields
  TodoState copyWith({
    List<Todo>? todos,
    TodoStatus? status,
    String? errorMessage,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  // Defines which properties are used to determine equality
  @override
  List<Object?> get props => [todos, status, errorMessage];

  // Creates a TodoState instance from a JSON map
  factory TodoState.fromJson(Map<String, dynamic> json) {
    return TodoState(
      todos: (json['todos'] as List).map((e) => Todo.fromJson(e)).toList(),
      status: TodoStatus.values[json['status'] as int],
      errorMessage: json['errorMessage'] as String?,
    );
  }

  // Converts the TodoState instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'todos': todos.map((e) => e.toJson()).toList(),
      'status': status.index,
      'errorMessage': errorMessage,
    };
  }
}