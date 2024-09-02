import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:todo_app/data/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends HydratedBloc<TodoEvent, TodoState> {
  //Constructor: intializes the bloc with empty state and registers event handlers
  TodoBloc() : super(TodoState()) {
      on<TodoStarted>(_onTodoStarted);
    on<AddTodo>(_onAddTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<AlterTodo>(_onAlterTodo);
    
  }

//Handle the TodoStarted event
 void _onTodoStarted(TodoStarted event, Emitter<TodoState> emit) {
    emit(state.copyWith(status: TodoStatus.loading));
    // For now, we're just setting it to success with the current list of todos
    emit(state.copyWith(status: TodoStatus.success));
  }

//Handle the AddTodo Event
 // Adds a new todo to the list
  void _onAddTodo(AddTodo event, Emitter<TodoState> emit) {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      final newTodos = List<Todo>.from(state.todos)..add(event.todo);
      emit(state.copyWith(todos: newTodos, status: TodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error, errorMessage: e.toString()));
    }
  }

// Handle the DeleteTodo event
// Removes a todo from the list
  void _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      final newTodos = List<Todo>.from(state.todos)..remove(event.todo);
      emit(state.copyWith(todos: newTodos, status: TodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error, errorMessage: e.toString()));
    }
  }

 // Handle the AlterTodo event
   // Toggles the isDone status of a todo at a specific index
  void _onAlterTodo(AlterTodo event, Emitter<TodoState> emit) {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      final newTodos = List<Todo>.from(state.todos);
      newTodos[event.index] = newTodos[event.index].copyWith(
        isDone: !newTodos[event.index].isDone,
      );
      emit(state.copyWith(todos: newTodos, status: TodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TodoStatus.error, errorMessage: e.toString()));
    }
  }

  // Implements fromJson method to restore state from JSON
  @override
  TodoState? fromJson(Map<String, dynamic> json) {
    return TodoState.fromJson(json);
  }
  
    // Implements toJson method to persist state to JSON
  @override
  Map<String, dynamic>? toJson(TodoState state) {
    return state.toJson();
  }
}
