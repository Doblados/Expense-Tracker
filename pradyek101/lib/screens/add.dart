import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:pradyek101/data/model/add_data.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {

  final box = Hive.box<AddData>('data');
  DateTime date = new DateTime.now();
  String ? selectedItem;
  String ? selectedItem1;
  final TextEditingController explain = TextEditingController();
  FocusNode ex = FocusNode();
  final TextEditingController amount = TextEditingController();
  FocusNode amnt = FocusNode();

  final List<String> item = ['Food', "Transfer", "Transportation", "Bills"];
  final List<String> item1 = ['Income', "Expense"];

  @override
  void iniState() {
    super.initState();
    ex.addListener(() {
      setState(() {

      });
    });
    amnt.addListener(() {
      setState(() {

      });
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              background_container(context),
              Positioned(
                top: 120,
                child: main_container(),
              )
            ],
          )
      ),
    );
  }

  Container main_container() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0XFFE3AADD)
      ),
      height: 450,
      width: 340,
      child: Column(
        children: [
          SizedBox(height: 50,),
          name(),
          SizedBox(height: 30,),
          amount1(),
          SizedBox(height: 30,),
          How(),
          SizedBox(height: 30),
          dateTime(),
          Spacer(),
          save1(),
          SizedBox(height: 20,)
        ],
      ),
    );
  }

  GestureDetector save1() {
    return GestureDetector(
      onTap: () {
        var add = AddData(selectedItem1!, amount.text, date, explain.text, selectedItem!);
        box.add(add);
        Navigator.of(context).pop();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 2, color: Colors.black),
          color: Color.fromARGB(255, 239, 154, 211),
        ),
        width: 120,
        height: 50,
        child: Text(
          'Save',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget dateTime() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: Colors.black)
      ),
      width: 300,
      child: TextButton(
        onPressed: ()async{
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2024),
              lastDate: DateTime(2100)
          );
          if (newDate == Null) return;
          setState(() {
            date = newDate!;
          });
        },
        child: Text(
          'Date : ${date.month} / ${date.day} / ${date.year}',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black
          ),
        ),
      ),
    );
  }

  Padding How() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Colors.black,
          ),
        ),
        child: DropdownButton<String>(
          value: selectedItem1,
          onChanged: ((value) {
            setState(() {
              selectedItem1 = value!;
            });
          }),
          items: item1
              .map((e) => DropdownMenuItem(
            child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Text(
                    e,
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            value: e,
          ))
              .toList(),
          selectedItemBuilder: (BuildContext context) => item1
              .map((e) => Row(
            children: [Text(e)],
          ))
              .toList(),
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'How',
              style: TextStyle(color: Colors.black),
            ),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
        ),
      ),
    );
  }

  Padding amount1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: 300,
        child: TextField(
          keyboardType: TextInputType.number,
          focusNode: amnt,
          controller: amount,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15,),
            labelText: 'Amount',
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.black,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Colors.black)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 2, color: Colors.black)
            ),
          ),
        ),
      ),
    );
  }

  Padding name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Colors.black
          )
        ),
        child: DropdownButton<String>(
            value: selectedItem,
            onChanged: ((value) {
              setState(() {
                selectedItem = value!;
              });
            }),
            items: item.map((e) => DropdownMenuItem(
              child: Container(
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      child: Image.asset('images/${e}.png'),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      e,
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              value: e,
            )).toList(),
            selectedItemBuilder: (BuildContext context) => item
              .map((e) => Row(
                children: [
                  Container(
                    width: 42,
                    child: Image.asset('images/${e}.png'),
                  ),
                  SizedBox(width: 5,),
                  Text(e),
                ],
              )).toList(),
            hint: Text(
              'Category',
              style: TextStyle(
                color: Colors.black
              ),
            ),
            dropdownColor: Colors.grey,
            isExpanded: true,
            underline: Container(),
        ),
      ),
    );
  }

  Column background_container(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20)
            )
          ),
          child: Column(
            children: [
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Adding',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.circle, color: Colors.pink,)
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
