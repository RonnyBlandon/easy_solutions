import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  final List<Widget> actions;

  const MainAppBar({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Row(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundImage:
                  AssetImage('assets/images/logo_easy_solutions.jpg'),
            ),
          ),
          Text(
            'Easy Solutions',
            style: TextStyle(
                color: Colors.yellowAccent,
                fontSize: 17.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: actions,
      backgroundColor: Colors.blue,
    );
  }
}
