class AddTodoParameters {
  final String todo;
  final int userID;

  AddTodoParameters({required this.todo, required this.userID});

  Map<String, dynamic> toJson() => {
        'todo': todo,
        'completed': false,
        'userId': userID,
      };
}
