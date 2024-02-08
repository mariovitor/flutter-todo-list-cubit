abstract interface class ILocalDatasource {
  Future<List<String>> getTasksJson();
  Future<bool> saveTasksJson(List<String> tasks);
}
