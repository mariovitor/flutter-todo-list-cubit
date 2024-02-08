abstract interface class ILocalDatasource {
  static const String tasksKey = 'tasks';

  Future<List<String>?> getTasksJson();
  Future<bool> saveTasksJson(List<String> tasks);
}
