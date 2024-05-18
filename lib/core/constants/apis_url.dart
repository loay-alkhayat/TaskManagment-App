class ApiUrls {
  // TODO : CHANGE BASE URL TO YOUR BASE URL HERE
  static const String baseUrl = 'https://dummyjson.com';

  // TODO : ADD YOUR APIS ENDPOINTS HERE
  static const String login = '$baseUrl/auth/login';
  static const String getTodos = '$baseUrl/todos';
  static const String getTaskInformation = '$baseUrl/todos/';
  static const String createTodo = '$baseUrl/todos/add';
  static const String deleteTodo = '$baseUrl/todos/'; /*Delete*/
  static const String updateTodo = '$baseUrl/todos/'; /*put*/
}
