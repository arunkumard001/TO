import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to/app/data/todo.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  Hive.registerAdapter<Todo>(TodoAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox<Todo>("todos");
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ToDo App",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
