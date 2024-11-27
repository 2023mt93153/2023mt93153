import 'package:flutter/material.dart';

class AddEditTaskScreen extends StatefulWidget {
  @override
  _AddEditTaskScreenState createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _titleController = TextEditingController();
  DateTime? _selectedDate;

  void _saveTask() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a task title')),
      );
      return;
    }

    final task = {
      'title': _titleController.text,
      'dueDate': _selectedDate,
    };

    Navigator.pop(context, task); // Return task to the previous screen
  }

  void _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add/Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Task Title'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDate == null
                      ? 'No Date Chosen'
                      : 'Due Date: ${_selectedDate?.toLocal()?.toString().split(' ')[0] ?? ''}',
                ),
                TextButton(
                  onPressed: _pickDate,
                  child: Text('Choose Date'),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: _saveTask,
              child: Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
