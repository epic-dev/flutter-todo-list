import 'package:flutter/material.dart';
import 'package:todolist/todo_model.dart';

class TodosProvider with ChangeNotifier {
  final List<Todo> _todos = [];
  var i = 0; // temp

  List<Todo> get items {
    return [..._todos];
  }

  Future<void> getTodos() async {
    // TODO: request todos from server or db
    _todos.addAll([
      Todo('_id01', '_title', false),
      Todo('_id02', '_title', true),
    ]);
    notifyListeners();
  }

  Future<void> addTodo() async {
    // TODO: implement
    _todos.addAll([
      Todo('_id_$i', '_title_$i', false),
    ]);
    notifyListeners();
  }

  Future<void> editTodo(String id, Todo todo) async {
    print(id);
    print(todo.title);
    // TODO: implement
    final int index = _todos.indexWhere((element) => element.id == id);
    print(index);
    if (index >= 0) {
      _todos[index] = todo;
      notifyListeners();
    }
  }

  Future<void> removeTodo(String id) async {
    // TODO: implement
    final int indexOfExisting = _todos.indexWhere((element) => element.id == id);
    var existing = _todos[indexOfExisting];
    _todos.removeAt(indexOfExisting);
    notifyListeners();
    try {
      // TODO: http call
      existing = null;
    } catch (e) {
      _todos.insert(indexOfExisting, existing);
      notifyListeners();
    }
  }
}
