import 'package:pradyek101/data/data.dart';

List<money> geter_top() {
  money transpo = money();
  transpo.name = 'Transpo';
  transpo.fee = '- ₱ 150';
  transpo.time = 'Today';
  transpo.image = 'Transportation.png';
  transpo.buy = true;

  return [transpo];
}