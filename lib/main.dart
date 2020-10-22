import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/todo_item.dart';
import 'package:todolist/todo_model.dart';
import 'package:todolist/todos_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodosProvider>(create: (_) => TodosProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('widget.title'),
      ),
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () async {
            await Provider.of<TodosProvider>(context, listen: false).getTodos();
          },
          child: Container(
            height: 400,
            child: Consumer<TodosProvider>(
              builder: (ctx, todos, child) => ListView.builder(
                itemCount: todos.items.length,
                itemBuilder: (ctx, index) {
                  var todo = todos.items[index];
                  return TodoItem(
                    id: todo.id,
                    title: todo.title,
                    state: todo.isComplited,
                    onTap: (value) {
                      print('Tapped! ${todo.id}');
                    },
                  );
                },
              ),
              // child: ,
            ),
          ),
        ),
      ),
    );
  }
}
