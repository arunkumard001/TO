import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to/app/data/todo.dart';

class HomeController extends GetxController {
  Box todoBox = Hive.box<Todo>("todos");
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;
  addTodo(Todo todo) {
    _todos.add(todo);
    print(todo.description);
    todoBox.add(todo);
    update();
  }

  TodoController() {
    _todos = [];
    Box todoBox = Hive.box<Todo>("todos");
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
    todoBox.deleteAt(index);
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
    TodoController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
