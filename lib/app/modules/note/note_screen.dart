import 'package:flutter/material.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('یادداشت'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Text('بر اساس کتاب'),
              Text('بر اساس تاریخ'),
            ],
            indicatorColor: Colors.transparent,
            labelPadding: EdgeInsets.symmetric(vertical: 10),

          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: Text('هیچ یادداشتی وجود ندارد'),
            ),
            Center(
              child: Text('هیچ یادداشتی وجود ندارد'),
            ),
          ],
        ),
      ),
    );
  }
}
