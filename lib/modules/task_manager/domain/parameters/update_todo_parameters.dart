class UpdateTodoParameters {
  final int todoID;
  final bool completed;

  UpdateTodoParameters({required this.todoID, required this.completed});
  Map<String, dynamic> toJson() => {
        'completed': completed,
      };
}
