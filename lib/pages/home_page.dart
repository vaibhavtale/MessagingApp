import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger_app/pages/chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            'HomePage',
            style: TextStyle(fontSize: 16),
          )),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('User').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            if (snapshot.hasData) {
              List<DocumentSnapshot> documents = snapshot.data!.docs.toList();
              return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = documents[index].data() as Map<String, dynamic>;
                    //print(documents[index].id);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              receiverId: documents[index].id.toString(),
                              receiverEmail: data['email'],
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage('assets/cuteboy.png'),
                        ),
                        title: Text(data['name'].toString()),
                        subtitle: Text(
                          data['email'].toString(),
                        ),
                        trailing: Text(
                          data['username'].toString(),
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w100),
                        ),
                      ),
                    );
                  });
            }

            return const Text('No data found');
          },
        ));
  }
}
