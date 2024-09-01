import 'package:flutter/material.dart';
import 'package:pradyek101/data/model/add_data.dart';
import 'package:pradyek101/data/top.dart';
import 'package:pradyek101/data/utilities.dart';
import 'package:pradyek101/widgets/chart.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

ValueNotifier basta = ValueNotifier(0);

class _StatisticsState extends State<Statistics> {
  List day = ['Day', 'Year'];
  List chartFunction = [today(), year()];
  List<AddData> a = [];
  int indexColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: basta,
          builder: (BuildContext context, dynamic value, Widget? child) {
            a = chartFunction[value];
            return customScrollView();
          },
        ),
      ),
    );
  }

  CustomScrollView customScrollView() {
    // Filter out income entries, assuming expenses are those where incm is not 'Income'
    List<AddData> expenses = a.where((item) => item.incm != 'Income').toList();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Text(
                'Statistics',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...List.generate(day.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            indexColor = index;
                            basta.value = index;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: indexColor == index
                                ? Color.fromARGB(255, 194, 73, 115)
                                : Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            day[index],
                            style: TextStyle(
                                color: indexColor == index
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      );
                    },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Chart(index1: indexColor,),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top Spending',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Icon(
                      Icons.swap_vert,
                      size: 25,
                      color: Colors.grey,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset('images/${expenses[index].name}.png', height: 40),
                ),
                title: Text(
                  expenses[index].name,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  ' ${expenses[index].dateTime.month}-${expenses[index].dateTime.day}-${expenses[index].dateTime.year}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Text(
                  expenses[index].amount,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    color: Colors.red, // Assuming expenses are marked with red
                  ),
                ),
              );
            },
            childCount: expenses.length, // Use the length of the filtered expenses list
          ),
        )
      ],
    );
  }
}
