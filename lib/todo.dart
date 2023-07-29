class ToDo{
  String? id;
  String? todotext;
  bool isDone;

  ToDo({
    required this.id,
    required this.todotext,
    required this.isDone,
});
  static List<ToDo> todolist(){
    return [
      ToDo(id: '01', todotext: 'Morning Exercise', isDone: true),
      ToDo(id: '02', todotext: 'Buy Groceries', isDone: true),
      ToDo(id: '03', todotext: 'Takıl', isDone: false),
      ToDo(id: '04', todotext: 'Hm', isDone: false),
      ToDo(id: '05', todotext: 'Hme', isDone: false),


    ];
  }
}