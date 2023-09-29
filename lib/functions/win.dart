// [1,2,3]
bool allSame(List<String> items) {
  if (items[0] == items[1] && items[1] == items[2] && items[0] != "") {
    return true;
  } else {
    return false;
  }
}

// horizondal box
// [
// [1,2,3],
// [4,5,6],
// [7,8,9]
// ]

// vertical box generator

List<List<String>> verticalBox(List<List<String>> horizondalBox) {
  List<List<String>> verticalBox = [];
  List<String> tempList = [];

  int i, j;

  // Vertical box value assigner
  for (i = 0; i < 3; i++) {
    for (j = 0; j < 3; j++) {
      tempList.add(horizondalBox[j][i]);
    }
    verticalBox.add(tempList);
    tempList = [];
  }
  return verticalBox;
}

// Diagnol box genrator

List<List<String>> diagnolBox(List<List<String>> horizondalBox) {
  List<List<String>> diagnolBox = [];
  List<String> tempList1 = [];
  List<String> tempList2 = [];

  int i;

  // Diagnol box value assigner
  for (i = 0; i < 3; i++) {
    tempList1.add(horizondalBox[i][i]);
    tempList2.add(horizondalBox[i][2 - i]);
  }
  diagnolBox.add(tempList1);
  diagnolBox.add(tempList2);

  return diagnolBox;
}

List<List<String>> normalToHorizondal(List<String> normal) {
  List<String> tempList1 = [];
  List<List<String>> tempList = [];

  for (int i = 0; i < 9; i++) {
    if (tempList1.length == 3) {
      tempList.add(tempList1);
      tempList1 = [];
      tempList1.add(normal[i]);
    } else {
      tempList1.add(normal[i]);
    }
  }
  tempList.add(tempList1);
  return tempList;
}

/*
[
  i = 0
  ["X0", "O1", "O2"] 0 j*3 : j*3 +2
  ["X3", "O4", "X5"] 1  j*3 +2
  ["X6", "X7", "O8"] 2  j*3 +2
]
*/
bool winChecker(List<String> tempList) {
  bool win = false;
  int i, j;
  List<List> possibilities = [];
  List<List<String>> verticalbox, diagnolbox;
  List<List<String>> horizondalBox = normalToHorizondal(tempList);

  /* 
  i = 1
  [
    ["X0", "X3", "X6"] j = 0
    ["O1", "O4", "X7"] j = 1
    ["O2", "X5", "O8"] j = 2
    ]
  */
  verticalbox = verticalBox(horizondalBox);
  /* it has only 2 list 
  [
    ["X0", "O4", "X8"]
    ["O2", "O4", "X6"]
  ]
  */
  diagnolbox = diagnolBox(horizondalBox);
  // by make it 3 below for loop will run properly
  diagnolbox.add(["", "", ""]);

  possibilities.add(horizondalBox);
  possibilities.add(verticalbox);
  possibilities.add(diagnolbox);

  for (i = 0; i < 3; i++) {
    if (!win) {
      for (j = 0; j < 3; j++) {
        if (allSame(possibilities[i][j])) {
          win = true;
          break;
        }
      }
    } else {
      break;
    }
  }
  return win;
}
