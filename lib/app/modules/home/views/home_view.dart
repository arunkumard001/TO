import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to/app/data/todo.dart';
import 'package:to/app/modules/home/views/todoadd.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeController todocontroller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Todo App'),
          centerTitle: true,
        ),
        body: GetBuilder<HomeController>(
            builder: (HomeController todoController) {
          return ListView.builder(
              itemCount: todoController.todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return TodoAdd(
                            todocontroller.todos[index],
                            type: "update",
                          );
                        },
                      );
                    },
                    leading: Checkbox(
                        value: todocontroller.todos[index].isCompleted,
                        onChanged: (value) {
                          todocontroller
                              .changestatus(todocontroller.todos[index]);
                        }),
                    title: Text(
                        todocontroller.todos[index].description.toString()),
                    trailing: IconButton(
                      onPressed: () {
                        todocontroller.deleteTodo(todocontroller.todos[index]);
                      },
                      icon: Icon(Icons.delete_rounded),
                    ));
              });
        }),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Future.delayed(Duration.zero, () async {
                showDetail(context, "new");
              });
            }));
  }

  Future<dynamic> showDetail(BuildContext context, _type) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return TodoAdd(
            Todo(description: TodoAdd.description),
            type: _type,
          );
        });
  }
}
