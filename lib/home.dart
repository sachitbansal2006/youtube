import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.email, required this.photo, required this.name, }) : super(key: key);
  final String email;
  final String photo;
  final String name;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Column(
        children: [
          Text(widget.email),
          Text(widget.name),
          Image.network(widget.photo)
        ],
      ),
    );
  }
}
