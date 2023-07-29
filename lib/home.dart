import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/todo_item.dart';
import 'package:to_do/todo.dart';

class Home extends StatefulWidget{
  Home ({Key? key}): super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todolist();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[200],
      appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50, bottom: 20),
                          child: Text('All ToDos',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        for (ToDo todoo in todosList)
                          ToDoItem(
                            todo: todoo,
                            onToDoChanged: _handleToDoChange,
                            onDeleteItem: _deleteToDoitem,
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(child: Container(
                    margin: EdgeInsets.only(bottom:20,
                        right: 20,
                        left: 20
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const[
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: 'add a new todo item',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 20.0,
                      top: 20.0,
                    ),
                    child: ElevatedButton(
                      child: Text('+', style: TextStyle(fontSize: 40,),),
                      onPressed: (){
                        _addToDoItem(_todoController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        elevation: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
  void _handleToDoChange(ToDo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

void _deleteToDoitem(String id){
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo){
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todotext: toDo,
        isDone: false,
      ));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword){
    List<ToDo> results = [];
    if(enteredKeyword.isEmpty) {
      results= todosList;
    }else{
      results = todosList.where((item) => item.todotext!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList as List<ToDo>;
    }

  }
  Widget searchBox(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
      child: TextField(
        decoration:   InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search,
              color: Colors.black87,
              size: 20),
          prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
        ),
      ),
    );
   }

  AppBar _buildAppBar(){
    return AppBar(
      backgroundColor: Colors.purple[200],
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              color: Colors.white,
              size: 30,
            ),
            Container(
              height: 30.0,
              width: 30.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/korea.png'),
              ),
            ),
          ]),
    );
  }
}

