import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Todo {
  bool isDone = false;
  String title;

  Todo(this.title);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TodoListPage(title: 'TODO List'),
    );
  }
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key, required this.title});

  final String title;

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  var _items = <Todo>[
    Todo("Work #1"), Todo("Work #2")
  ];
  var _todoController = TextEditingController();

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row( // 신규 todo 추가
              children: <Widget>[
                Expanded( // 신규 todo 추가 입력창
                    child: TextField(
                      controller: _todoController,
                    )
                ),
                ElevatedButton( // 신규 todo 추가 버튼
                    onPressed: (){ _addTodo(Todo(_todoController.text)); },
                    child: Text("Add"),
                )
              ],
            ),
            Expanded( // TODO 목록
                child: ListView(
                  children: _items.map(_buildItemWidget).toList(),
                ),
            )
          ],
        )
      )
    );
  }

  // Todo 를 표시하는 widget 생성
  Widget _buildItemWidget(Todo todo) {
    return ListTile(
      onTap: () { toggleTodo(todo); }, // 클릭시 완료 상태 변경 (toggle)
      title: Text(
        todo.title, // todo 이름 출력, 완료된 todo는 취소선으로 표시
        style: todo.isDone ? TextStyle(decoration: TextDecoration.lineThrough, fontStyle: FontStyle.italic) : null),
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: () { _deleteTodo(todo); }, // 쓰레기통 클릭시 완전 삭제
      ),
    );
  }

  _addTodo(Todo todo) {
    if (todo.title != "") {
      setState(() {
        _items.add(todo);
        _todoController.text = "";
      });
    } else {
      print("Your todo's title was empty. Write down title please.");
    }
  }

  _deleteTodo(Todo todo) {
    setState(() {
      _items.remove(todo);
    });
  }

  toggleTodo(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }
}
