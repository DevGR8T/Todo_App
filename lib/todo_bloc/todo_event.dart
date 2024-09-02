part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];

}

//Event to initialize the todo list
class TodoStarted extends TodoEvent{}

//Event to add a new todo
class AddTodo extends TodoEvent{
   final Todo todo;

  const AddTodo({required this.todo});

   @override
  List<Object> get props => [];
}


//Event to delete a todo
class DeleteTodo extends TodoEvent{
  final Todo todo;

 const DeleteTodo({required this.todo});

   @override
  List<Object> get props => [];
}

//Event to toggle the completeion of a todo
class AlterTodo extends TodoEvent{
  final int index;

  const AlterTodo({required this.index});

  @override
  List<Object> get props => [];
}
