import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../components/dialog_box.dart';
import '../components/to_do_tile.dart';
import '../data/db.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final myBox = Hive.box('mybox');
  ToDoDB db = ToDoDB();

  @override
  void initState(){
    if(myBox.get('TODOLIST') == null){
      db.createInitalData();
    } else{
      db.loadData();
    }
    super.initState();
  }

  final controllerText = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDB();
  }

  void SaveNewTask() {
    setState(() {
      db.toDoList.add([controllerText.text, false]);
      controllerText.clear();
    });
    Navigator.of(context).pop();
    db.updateDB();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: controllerText,
          onSave: SaveNewTask,
          onCancell: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Center(
          child: Text(
            'Cool App v2',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: createNewTask,
        backgroundColor: Colors.yellow,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.toDoList[index][0],
            taskComplete: db.toDoList[index][1],
            oneChanged: (value) => checkBoxChanged(value, index),
            deleteFunc: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
