import 'package:todo_list_cubit/src/domain/models/task_model.dart';

abstract interface class ITaskRepository {
  Future<List<TaskModel>> getTasks();
  Future<TaskModel> getTask(String id);
  Future<bool> createTask(TaskModel task);
  Future<void> deleteTask(String id);
  Future<bool> completeTask(String id);
}
