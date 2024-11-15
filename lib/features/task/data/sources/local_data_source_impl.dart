import 'package:hive/hive.dart';
import '../models/task_model.dart';
import 'local_data_source.dart';

class LocalDataSourceImpl implements LocalDataSource {
  final Box<TaskModel> taskBox;

  LocalDataSourceImpl(this.taskBox);

  @override
  Future<List<TaskModel>> getTasks() async {
    return taskBox.values.toList();
  }

  @override
  Future<void> addTask(TaskModel task) async {
    await taskBox.put(task.id, task);
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    await taskBox.put(task.id, task);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await taskBox.delete(taskId);
  }
}
