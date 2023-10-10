// game box references
List<List<String>> displayXOList =
    List.generate(9, (_) => List.generate(9, (_) => ""));

List<String> capturedBoxes = List.generate(9, (_) => "");
List<int> capturedBoxIndex = [];

resetDiaplayXOList() {
  displayXOList = List.generate(9, (_) => List.generate(9, (_) => ""));
}

int previousIndex = 0;
Function resetColor = () {};
