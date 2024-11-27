import 'package:flutter/material.dart';
import 'package:quicktask/models/task.dart';
import 'package:quicktask/services/api_service.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  // Fetch tasks from the API
  Future<void> fetchTasks() async {
    try {
      final taskList = await ApiService.getTasks();
      _tasks = taskList.map((task) => Task.fromJson(task)).toList();
      notifyListeners();
    } catch (error) {
      print('Error fetching tasks: $error');
    }
  }

  // Add a new task
  Future<void> addTask(String title, DateTime dueDate, bool status) async {
    try {
      // Pass title, dueDate, and status to the API
      await ApiService.addTask(title, dueDate, status);

      // Refresh tasks after adding the new task
      await fetchTasks();
      notifyListeners();
    } catch (error) {
      print('Error adding task: $error');
    }
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    try {
      await ApiService.deleteTask(taskId);

      // Refresh tasks after deletion
      await fetchTasks();
      notifyListeners();
    } catch (error) {
      print('Error deleting task: $error');
    }
  }
}
