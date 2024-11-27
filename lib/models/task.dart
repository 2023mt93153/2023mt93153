class Task {
  final String objectId;
  final String title;
  final bool status;
  final DateTime dueDate;

  Task({
    required this.objectId,
    required this.title,
    required this.status,
    required this.dueDate,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      objectId: json['objectId'] ?? '',
      title: json['Title'] ?? '',
      status: json['status'] ?? false,
      dueDate: DateTime.parse(json['dueDate']['iso']), // Extract 'iso' field
    );
  }
}
