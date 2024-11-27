import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quicktask/providers/task_provider.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchTasksPeriodically();
  }

  void _fetchTasksPeriodically() {
    Provider.of<TaskProvider>(context, listen: false).fetchTasks();

    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      Provider.of<TaskProvider>(context, listen: false).fetchTasks();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
				print('Add Task button pressed');
				_showAddTaskDialog(context);
			},
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          final tasks = taskProvider.tasks;

          if (tasks.isEmpty) {
            return const Center(child: Text('No tasks available.'));
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return ListTile(
                title: Text(task.title),
                subtitle: task.dueDate != null
                    ? Text('Due: ${_formatDueDate(task.dueDate!)}')
                    : const Text('No Due Date'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteTask(task.objectId),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatDueDate(DateTime dueDate) {
    try {
      return '${dueDate.toLocal().toString().split(' ')[0]} ${dueDate.hour}:${dueDate.minute}';
    } catch (e) {
      return 'Invalid date';
    }
  }

  // Method to show a dialog to add a new task
void _showAddTaskDialog(BuildContext context) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  bool status = false; // Default status value

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Add Task"),
        content: StatefulBuilder(
          builder: (BuildContext dialogContext, StateSetter setDialogState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                TextField(
                  controller: dueDateController,
                  decoration: const InputDecoration(labelText: "Due Date (YYYY-MM-DD)"),
                  keyboardType: TextInputType.datetime,
                ),
                Row(
                  children: [
                    const Text('Completed:'),
                    Switch(
                      value: status,
                      onChanged: (value) {
                        setDialogState(() {
                          status = value; // Update dialog's local state
                        });
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final title = titleController.text;
              final dueDate = DateTime.tryParse(dueDateController.text);

              if (title.isNotEmpty && dueDate != null) {
                Provider.of<TaskProvider>(context, listen: false)
                    .addTask(title, dueDate, status);
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please provide a valid title and due date!'),
                  ),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}


  // Method to delete a task
  void _deleteTask(String taskId) {
    Provider.of<TaskProvider>(context, listen: false).deleteTask(taskId);
  }
}
