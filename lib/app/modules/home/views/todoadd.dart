import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:to/app/data/todo.dart';
import 'package:to/app/modules/home/controllers/home_controller.dart';

class TodoAdd extends StatefulWidget {
  String type;
  Todo todo;
  static String description = "";
  TodoAdd(
    this.todo, {
    Key? key,
    required this.type,
  }) : super(key: key);
  @override
  State<TodoAdd> createState() => _TodoAddState();
}

class _TodoAddState extends State<TodoAdd> {
  final _formkey = GlobalKey<FormState>();
  String description = TodoAdd.description;
  final todocontroller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Form(
          key: _formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10,
              ),
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
                child: Text(widget.todo == "update" ? "update" : "new"),
              )
            ],
          )),
    );
  }
}
