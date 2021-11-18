import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:to/app/data/todo.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeController todocontroller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      showBottomSheet(
                        context: context,
                        builder: (context) {
                          return TodoAdd(
                            todo: todocontroller.todos[index],
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
        floatingActionButton: FloatingActionButton(onPressed: () {
          showBottomSheet(
            context: context,
            builder: (context) {
              return TodoAdd(
                type: "new",
              );
            },
          );
        }));
  }
}

class TodoAdd extends StatefulWidget {
  String type;
  Todo todo;
  TodoAdd({Key? key, required this.type, this.todo}) : super(key: key);
  @override
  State<TodoAdd> createState() => _TodoAddState();
}

class _TodoAddState extends State<TodoAdd> {
  final _formkey = GlobalKey<FormState>();
  String description = '';
  final todocontroller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
          key: _formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Add a Note"),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue:
                    widget.todo != null ? widget.todo.description : "",
                onSaved: (value) {
                  description = value.toString();
                },
                decoration: InputDecoration(hintText: "Add Description"),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  _formkey.currentState!.save();
                  if (widget.type == 'new') {
                    todocontroller.addTodo(Todo(description: description));
                  } else {
                    todocontroller.updateTodo(widget.todo, description);
                  }
                  Navigator.of(context).pop();
                },
                child: Text(widget.todo != null ? "update" : "Add a Note"),
              )
            ],
          )),
    );
  }
}
