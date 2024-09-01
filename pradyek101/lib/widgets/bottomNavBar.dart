import 'package:flutter/material.dart';
import 'package:pradyek101/screens/add.dart';
import 'package:pradyek101/screens/home.dart';
import 'package:pradyek101/screens/statistics.dart';

class BotNavBar extends StatefulWidget {
  const BotNavBar({super.key,});

  @override
  State<BotNavBar> createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {

  int indexColor = 0;
  List Screen = [HomeScreen(), Statistics()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen[indexColor],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddExpense()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
        shape: CircleBorder(),
        elevation: 3,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.pinkAccent,
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    indexColor = 0;
                  });
                },
                child: Icon(
                  Icons.home,
                  size: 30,
                  color: indexColor == 0 ? Colors.white : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    indexColor = 1;
                  });
                },
                child: Icon(
                  Icons.bar_chart_sharp,
                  size: 30,
                  color: indexColor == 1 ? Colors.white : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
