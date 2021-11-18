import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to/app/data/todo.dart';

class HomeController extends GetxController {
  late Box<Todo> todoBox;
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;
  addTodo(Todo todo) {
    _todos.add(todo);
    todoBox.add(todo);
    update();
  }

  TodoController() {
    todoBox = Hive.box<Todo>("todos");
    _todos = [];
    for (int i = 0; i < todoBox.values.length; i++) {
      _todos.add(todoBox.getAt(i));
    }
  }

  updateTodo(Todo oldTodo, String newDescription) {
    int index = _todos.indexOf(oldTodo);
    _todos[index].description = newDescription;
    todoBox.putAt(index, _todos[index]);
    update();
  }

  deleteTodo(Todo todo) {
    int index = _todos.indexOf(todo);

    _todos.removeWhere((element) => element.id == todo.id);
    todoBox.delete(index);
    update();
  }

  changestatus(Todo todo) {
    int index = _todos.indexOf(todo);
    _todos[index].isCompleted = !_todos[index].isCompleted;
    todoBox.putAt(index, _todos[index]);
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
