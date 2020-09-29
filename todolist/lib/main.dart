import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'To Do List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<String> _todoList = <String>[];
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: ListView(children: _getItems()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(context),
        tooltip: 'Ajout d\'une tâche',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTodoItem(String title) {
    setState(() {
      _todoList.add(title);
    });
    _textEditingController.clear();
  }

  Widget _buildToDoItem(String title) {
    return ListTile(title: Text(title));
  }

  Future<AlertDialog> _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Ajout d\'une tâche à la liste'),
            content: TextField(
              controller: _textEditingController,
              decoration:
                  const InputDecoration(hintText: 'Entrée une tâche ici'),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('AJOUTER'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(_textEditingController.text);
                },
              ),
              FlatButton(
                child: const Text('RETOUR'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  List<Widget> _getItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    for (String title in _todoList) {
      _todoWidgets.add(_buildToDoItem(title));
    }
    return _todoWidgets;
  }
}
