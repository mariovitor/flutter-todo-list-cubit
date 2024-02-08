import 'package:todo_list_cubit/src/domain/models/task_model.dart';

abstract interface class ITaskRepository {
  Future<List<TaskModel>> getTasks();
  Future<TaskModel> getTask(String id);
  Future<TaskModel> createTask(TaskModel task);
  Future<TaskModel> updateTask(TaskModel task);
  Future<void> deleteTask(String id);
}
