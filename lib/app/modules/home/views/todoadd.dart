import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
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
    return Form(
        key: _formkey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: Get.height / 200,
            ),
            Text(
              "Add a Note",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: Get.height / 200,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                autofocus: true,
                maxLines: 2,
                maxLength: 100,
                initialValue:
                    widget.todo != null ? widget.todo.description : "",
                onSaved: (value) {
                  description = value.toString();
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Add Description"),
              ),
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
              child: Text(widget.type == "new" ? "New" : "UPDATE"),
            )
          ],
        ));
  }
}
