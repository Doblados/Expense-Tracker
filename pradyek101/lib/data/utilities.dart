import 'package:hive/hive.dart';
import 'package:pradyek101/data/model/add_data.dart';

int totals = 0;

final box = Hive.box<AddData>('data');

int total() {
  var history1 = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < history1.length; i++)
  {
    a.add(history1[i].incm == 'Income'
      ? int.parse(history1[i].amount)
      : int.parse(history1[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

int income() {
  var history1 = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < history1.length; i++)
  {
    a.add(history1[i].incm == 'Income' ? int.parse(history1[i].amount) : 0);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

int expenses() {
  var history1 = box.values.toList();
  List a = [0, 0];
  for (var i = 0; i < history1.length; i++)
  {
    a.add(history1[i].incm == 'Income' ? 0 : int.parse(history1[i].amount) * -1);
  }
  totals = a.reduce((value, element) => value + element);
  return totals;
}

List<AddData> today() {
  List<AddData> a = [];
  var history1 = box.values.toList();
  DateTime date = DateTime.now();
  for (var i = 0; i < history1.length; i++) {
    if (history1[i].dateTime.day == date.day && history1[i].incm != 'Income') {
      a.add(history1[i]);
    }
  }
  return a;
}

List<AddData> year() {
  List<AddData> a = [];
  var history1 = box.values.toList();
  DateTime date = DateTime.now();
  for (var i = 0; i < history1.length; i++) {
    if (history1[i].dateTime.year == date.year && history1[i].incm != 'Income') {
      a.add(history1[i]);
    }
  }
  return a;
}

int totalChart(List<AddData> history1) {
  // Filter only expenses
  List<int> expenses = history1
      .where((item) => item.incm != 'Income')
      .map((item) => int.parse(item.amount) * -1) // Expenses should be negative
      .toList();

  // If the list is empty, avoid reduction to prevent errors
  if (expenses.isEmpty) return 0;

  totals = expenses.reduce((value, element) => value + element);
  return totals;
}

List<int> time(List<AddData> history1, bool hour) {
  List<AddData> a = [];
  List<int> total = [];
  int counter = 0;

  // Group by hour or day, and ensure data includes only expenses
  for (var c = 0; c < history1.length; c++) {
    for (var i = c; i < history1.length; i++) {
      if (hour) {
        if (history1[i].dateTime.hour == history1[c].dateTime.hour && history1[i].incm != 'Income') {
          a.add(history1[i]);
          counter = i;
        }
      } else {
        if (history1[i].dateTime.day == history1[c].dateTime.day && history1[i].incm != 'Income') {
          a.add(history1[i]);
          counter = i;
        }
      }
    }

    // Only add to total if there are expenses
    if (a.isNotEmpty) {
      total.add(totalChart(a));
    }
    a.clear();
    c = counter;
  }

  return total;
}
