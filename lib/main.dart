import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/home.dart';
import 'package:todo_app/todo_bloc/todo_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize HydratedBloc
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getTemporaryDirectory());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //wrap with bloc provider to make todo bloc available
    return  BlocProvider(
      create: (context) => TodoBloc()..add(TodoStarted()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        theme: ThemeData(primarySwatch: Colors.teal,colorScheme: ColorScheme.light(
          surface: Colors.white,
          onSurface: Colors.black,
          primary: Colors.purple,
          onPrimary: Colors.black
      
        )),
        home: HomeScreen(),
      ),
    );
  }
}