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
          backgroundColor: Colors.teal,
          title: Text('Todo App'),
          centerTitle: true,
        ),
        body: GetBuilder<HomeController>(
            builder: (HomeController todoController) {
          return ListView.builder(
              itemCount: todoController.todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                    hoverColor: Colors.black54,
                    onTap: () {
                      showDetail(
                        context,
                        "Update",
                        todocontroller.todos[index],
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
                    trailing: !todocontroller.todos[index].isCompleted
                        ? null
                        : IconButton(
                            onPressed: () {
                              todocontroller
                                  .deleteTodo(todocontroller.todos[index]);
                            },
                            icon: Icon(Icons.delete_rounded),
                          ));
              });
        }),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showDetail(
                context,
                "new",
                Todo(description: TodoAdd.description),
              );
            }));
  }

  Future<dynamic> showDetail(BuildContext context, _type, todo) {
    return Get.bottomSheet(
      TodoAdd(
        todo,
        type: _type,
      ),
      backgroundColor: Colors.white,
      ignoreSafeArea: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
