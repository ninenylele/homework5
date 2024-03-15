import 'package:flutter/material.dart';
import 'package:homework5/pages/home/widgets/attendance.dart';
import 'package:homework5/pages/home/widgets/time_table.dart';
import 'package:homework5/pages/home/widgets/notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _handleClickButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget buildPageBody() {
      switch (_selectedIndex) {
        case 0:
          return const TimeTable();
        case 1:
          return const Attendance();
        case 2:
          return const AppNotification();
        default:
          return const TimeTable();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border:
                Border.all(color: Color.fromARGB(255, 0, 0, 0)!), // สีเส้นขอบ
            borderRadius: BorderRadius.circular(10), // รูปร่างของกรอบ
          ),
          child: Text(
            'PRESIDENTS',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 221, 2), // สีข้อความ
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: buildPageBody(),
      backgroundColor: Color.fromARGB(255, 2, 2, 2),
    );
  }
}
