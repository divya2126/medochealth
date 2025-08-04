import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task_model.dart';
import '../utils/hive_boxes.dart';


class ToDoListPage extends StatefulWidget {
  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final TextEditingController _taskController = TextEditingController();
  DateTime? _selectedDate;

  void _addTask() {
    final title = _taskController.text.trim();
    if (title.isNotEmpty) {
      final task = Task(title: title, dueDate: _selectedDate);
      Boxes.getTasks().add(task);
      _taskController.clear();
      _selectedDate = null;
    }
  }

  void _deleteTask(int index) {
    Boxes.getTasks().deleteAt(index);
  }

  void _toggleDone(Task task) {
    task.isDone = !task.isDone;
    task.save();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 1)),
      lastDate: DateTime(2100),
    );
    if (date != null) setState(() => _selectedDate = date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(title: Text('To-Do-List')),
      
      body: ValueListenableBuilder(
        valueListenable: Boxes.getTasks().listenable(),
        builder: (context, Box<Task> box, _) {
          final tasks = box.values.toList();
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: _taskController,
                      decoration: InputDecoration(
                        labelText: 'Enter task',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.date_range),
                          onPressed: _pickDate,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton.icon(
                      icon: Icon(Icons.add),
                      label: Text("Add Task"),
                      onPressed: _addTask,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (_, index) {
                    final task = tasks[index];
                    return ListTile(
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: task.isDone
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      subtitle: task.dueDate != null
                          ? Text("Due: ${task.dueDate!.toLocal()}".split(' ')[0])
                          : null,
                      leading: Checkbox(
                        value: task.isDone,
                        onChanged: (_) => _toggleDone(task),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteTask(index),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
