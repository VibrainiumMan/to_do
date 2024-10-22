import 'package:hive/hive.dart';

class ToDoDB {
  List toDoList = [];
  final myBox = Hive.box('mybox');

  void createInitalData() {
    toDoList = [
      ["Create a new Task by pressing \'+\'", false]
    ];
  }

  void loadData() {
    toDoList = myBox.get('TODOLIST');
  }

  void updateDB() {
    myBox.put('TODOLIST', toDoList);
  }
}
