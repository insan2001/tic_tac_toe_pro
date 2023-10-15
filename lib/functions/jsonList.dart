List<List<String>> jsonToList(Map<String, List<String>> jsonData) {
  List<List<String>> listData = [];
  for (int i = 0; i < 9; i++) {
    final jData = jsonData[i as String];
    listData.add(jData!);
  }
  return listData;
}

Map<String, List<String>> listToJson(List<List<String>> listData) {
  Map<String, List<String>> jsonData = {};
  for (int i = 0; i < 9; i++) {
    jsonData[i as String] = listData[i];
  }
  return jsonData;
}
