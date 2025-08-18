import 'package:flutter/material.dart';
import 'package:tip_employee/src/features/home/presentation/widgets/continer.dart';
import '../../../../core/assets/assets.dart';

class TodolistModel {
  final String title;
  final ImageProvider image;
  final Color backgroundColor;
  int count;
  final VoidCallback? onTap;

  TodolistModel({
    required this.title,
    required this.image,
    required this.backgroundColor,
    this.count = 0,
    this.onTap,
  });
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<TodolistModel> todolist = [
    TodolistModel(
      title: 'Today',
      image: AssetImage(Assets.dot),
      backgroundColor: Color.fromRGBO(181, 194, 251, 1.0),
    ),
    TodolistModel(
      title: 'in week',
      image: AssetImage(Assets.dot),
      backgroundColor: Color.fromRGBO(255, 245, 128, 1.0),
    ),
    TodolistModel(
      title: 'in month',
      image: AssetImage(Assets.dot),
      backgroundColor: Color.fromRGBO(208, 245, 235, 1.0),
    ),
    TodolistModel(
      title: 'in year',
      image: AssetImage(Assets.dot),
      backgroundColor: Color.fromRGBO(253, 192, 245, 1.0),
    ),
  ];

  List<Widget> buildTaskCards() {
    return todolist.map((task) {
      return TaskCard(
        title: task.title,
        image: task.image,
        backgroundColor: task.backgroundColor,
        count: task.count,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Hello Jack',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                   
                    ],
                  ),
                  const Icon(Icons.notifications),
                ],
              ),

              const SizedBox(height: 20),

              /// Grid of Task Cards
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: buildTaskCards(),
              ),

              const SizedBox(height: 20),

              /// Today’s Task Section
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  'recent tip',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
