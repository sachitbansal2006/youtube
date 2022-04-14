import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'add.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
        .collection(widget.id.toString()).snapshots();


    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Home Screen'),
            IconButton(
                onPressed: () async {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                },
                icon: const Icon(Icons.logout))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: dataStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                  //  TODO: add snackbar
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final List storedocs = [];
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map a = document.data() as Map<String, dynamic>;
                    storedocs.add(a);
                    a['id'] = document.id;
                  }).toList();

                  return Column(
                    children: List.generate(
                      storedocs.length,
                        (i) => Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(20),
                          color: Colors.red,
                          child: Column(
                            children: [
                              Text(
                                storedocs[i]['text']
                              ),
                              const SizedBox(height: 20,),
                              Text(
                                  storedocs[i]['trueOrFalse']
                              )
                            ],
                          ),
                        )
                    ),
                  );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Add(
                      id: widget.id
                  ),
            ),
          );
        },
      ),
    );
  }
}
