import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo = []; //for the search bar

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
              // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
            children: [
              //Search field
              Container(
                //color: tdBGColor,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.5, 1.0],
                    colors: [tdBGColor, tdAlpha],
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  children: [
                    searchBox(),
                    Container(
                        margin: EdgeInsets.only(top: 30, bottom: 0),
                        child: Text("ToDos:",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: tdBlack,
                                fontSize: 20,
                                fontWeight: FontWeight.w500))),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (ToDo todoo in _foundToDo.reversed) //iterate thro da list
                    //todosList changed to _foundToDo. Reverse to have new item at top
                      ToDoItem(
                        todo: todoo,
                        onToDoChanged: _handleToDoChange,
                        onDeleteItem: _deleteToDoItem,
                      ),
                  ],
                ),
              ),
            ],
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.2],
                  colors: [tdAlpha, tdBGColor],
                ),
              ),
              //color: tdBGColor,
              padding: EdgeInsets.only(top: 30),
              child: Row(children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 197, 202, 208),
                            offset: Offset(0.0, 5.0),
                            blurRadius: 5.0,
                            spreadRadius: 0.0),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                          hintText: 'Add a new Todo', border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    child: Text('+', style: TextStyle(fontSize: 40)),
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      minimumSize: Size(60, 58),
                      elevation: 4,
                      shadowColor: Color.fromARGB(255, 197, 202, 208),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _runFilter(value),//runs da func for every keystroke
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: tdBlack, size: 20),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search a task here',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      //setState to see da change we made below
      todo.isDone = !todo.isDone; //if T => F nd so on
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }


  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        //id = time to keep them unique
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear(); //clear text field
  }


  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList; //when nth entire, show full list
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList(); //find da ones dat has the word, put it in list
    }
    setState(() {
      _foundToDo = results;
    });
  }


  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBlue,
      elevation: 0, //no shadow underneath
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(Icons.menu, color: Colors.white, size: 30),
        Text('Masu\'s To Do List'),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/avatar.jpeg'),
          ),
        ),
      ]),
    );
  }
}
