import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://parseapi.back4app.com';
const Map<String, String> headers = {
  'X-Parse-Application-Id': 'GlyWoKua4trbmzj397NuyzTqiJ4mQOsIhEhM5CDQ', // Replace with your App ID
  'X-Parse-REST-API-Key': 'RUfPxYCAYO3mCCJfX1Z95vxwVLTY26U6Qithjkia', // Replace with your REST API Key
  'Content-Type': 'application/json',
};

class ApiService {
  
  // Sign Up a new user
  static Future<void> signUp(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: headers,
      body: jsonEncode({
        'username': email,  // Using email as username
        'password': password,
        'email': email,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to sign up user: ${response.body}');
    }
  }

  // Log In an existing user
  static Future<void> logIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: headers,
      body: jsonEncode({
        'username': email,  // Using email as username
        'password': password,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to log in user: ${response.body}');
    }
  }

  // Fetch tasks from Back4App
  static Future<List> getTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/classes/Task'), headers: headers);

    if (response.statusCode == 200) {
      final tasksData = jsonDecode(response.body)['results'];
      return tasksData;
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  // Add a new task to Back4App
static Future<void> addTask(String title, DateTime dueDate, bool status) async {
  final response = await http.post(
    Uri.parse('$baseUrl/classes/Task'),
    headers: headers,
    body: jsonEncode({
      'Title': title,
      'dueDate': {
        '__type': 'Date',
        'iso': dueDate.toIso8601String(), // Correct format for Back4App
      },
      'status': status, // Boolean value
    }),
  );

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode != 201) {
    throw Exception('Failed to add task');
  }
}


  // Delete a task from Back4App
  static Future<void> deleteTask(String taskId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/classes/Task/$taskId'),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }
}
