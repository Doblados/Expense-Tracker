import 'package:pradyek101/data/data.dart';

List<money> geter() {
  money food = money();
  food.name = 'Food';
  food.fee = '₱ 150';
  food.time = 'Today';
  food.image = 'Food.png';
  food.buy = true;

  money transpo = money();
  transpo.name = 'Transportation';
  transpo.fee = '₱ 120';
  transpo.time = 'Today';
  transpo.image = 'Transportation.png';
  transpo.buy = true;

  money bills = money();
  bills.name = 'Transportation';
  bills.fee = '₱ 120';
  bills.time = 'Today';
  bills.image = 'Bills.png';
  bills.buy = true;

  money transfer = money();
  transfer.name = 'Transfer';
  transfer.fee = '₱ 5,000';
  transfer.time = 'Today';
  transfer.image = 'Transfer.png';
  transfer.buy = false;
  return [food, transpo, transfer];
}