import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/todo.dart';
import 'package:todo_app/todo_bloc/todo_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // Adds a new todo to the list
  void _addTodo(BuildContext context, String? title, String? subtitle) {
    if (title != null && title.isNotEmpty) {
      context.read<TodoBloc>().add(AddTodo(
            todo: Todo(title: title, subtitle: subtitle),
          ));
      Navigator.pop(context);
    }
  }

  // Deletes a todo from the list
  void deleteTodo(BuildContext context, Todo todo) {
    context.read<TodoBloc>().add(DeleteTodo(todo: todo));
  }

  // alter the completion status of a todo
  void alterTodo(BuildContext context, int index) {
    context.read<TodoBloc>().add(AlterTodo(index: index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Todo App',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
        //showing loading indicator when status is loading
        if (state.status == TodoStatus.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == TodoStatus.success) {
          //Build a list view of todos when status is success
          return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return ListTile(
                  title: Text(todo.title ?? ''),
                  subtitle: Text(todo.subtitle ?? ''),
                  trailing: Checkbox(
                    value: todo.isDone,
                    onChanged: (_) {
                      alterTodo(context, index);
                    },
                  ),
                  onLongPress: () {
                    deleteTodo(context, todo);
                  },
                );
              });
        } else if (state.status == TodoStatus.error) {
          // Show error message when status is error
          return Center(child: Text(state.errorMessage ?? 'An error occurred'));
        }
        return SizedBox();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(),
                title: Text('Add a Task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      decoration: InputDecoration(
                          hintText: 'Task Title...',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide: BorderSide(color: Colors.grey))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: descriptionController,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      decoration: InputDecoration(
                          hintText: 'Task Description...',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                              borderSide: BorderSide(color: Colors.grey))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                            onPressed: () {
                              _addTodo(context, titleController.text,
                                  descriptionController.text);
                              titleController.clear();
                              descriptionController.clear();
                            },
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor: Colors.white),
                            child: Text('Add')),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
