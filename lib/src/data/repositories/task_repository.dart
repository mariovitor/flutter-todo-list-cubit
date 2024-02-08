import 'package:todo_list_cubit/src/data/i_local_datasource.dart';
import 'package:todo_list_cubit/src/domain/models/task_model.dart';
import 'package:todo_list_cubit/src/domain/repositories/i_task_repository.dart';

class TaskRepository implements ITaskRepository {
  final ILocalDatasource _localDatasource;

  TaskRepository(this._localDatasource);
  @override
  Future<bool> createTask(TaskModel task) async {
    try {
      final allTasks = await _localDatasource.getTasksJson() ?? <String>[];
      allTasks.add(task.toJson());
      final saved = await _localDatasource.saveTasksJson(allTasks);
      return saved;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      final allTasks = await _localDatasource.getTasksJson() ?? <String>[];
      allTasks.removeWhere((element) => TaskModel.fromJson(element).id == id);
      await _localDatasource.saveTasksJson(allTasks);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TaskModel> getTask(String id) async {
    try {
      final tasks = await _localDatasource.getTasksJson();
      final task = tasks
          ?.map((e) => TaskModel.fromJson(e))
          .firstWhere((element) => element.id == id);
      if (task == null) {
        throw Exception('Tarefa não encontrada');
      }
      return task;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final tasks = await _localDatasource.getTasksJson();
      return tasks?.map((e) => TaskModel.fromJson(e)).toList() ?? <TaskModel>[];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> completeTask(String id) async {
    try {
      final tasks = await getTasks();
      final index = tasks.indexWhere((element) => element.id == id);
      if (index == -1) throw Exception('Tarefa não encontrada');
      tasks[index] = tasks[index].copyWith(isCompleted: true);
      return await _localDatasource
          .saveTasksJson(tasks.map((e) => e.toJson()).toList());
    } catch (e) {
      rethrow;
    }
  }
}
