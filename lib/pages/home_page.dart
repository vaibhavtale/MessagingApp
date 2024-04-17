import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messenger_app/pages/chat_page.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

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
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.add_a_photo_rounded,
                size: 30,
                color: Colors.cyan[500],
              ),
              GradientText(
                "Messenger",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 25,
                ),
                colors: const [
                  Colors.pinkAccent,
                  Colors.redAccent,
                  Colors.orangeAccent
                ],
              ),
              Icon(
                Icons.search_rounded,
                color: Colors.cyan[500],
                size: 30,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 80,
          child: StreamBuilder<QuerySnapshot>(
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
                    scrollDirection: Axis.horizontal,
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      // var data = documents[index].data() as Map<String, dynamic>;
                      //print(documents[index].id);

                      if (index == 0) {
                        return Stack(
                          // alignment: Alignment.bottomRight,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 12,
                                  left:
                                      MediaQuery.of(context).size.width * 0.06,
                                  right: 10),
                              child: const CircleAvatar(
                                radius: 27,
                                backgroundColor: Colors.deepOrange,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/cuteboy.png"),
                                  backgroundColor: Colors.white,
                                  radius: 23,
                                ),
                              ),
                            ),
                            const Positioned(
                              bottom: 7,
                              right: 3,
                              child: Icon(
                                Icons.add_circle_outlined,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        );
                      }
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: CircleAvatar(
                          radius: 27,
                          backgroundColor: Colors.greenAccent,
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/cuteboy.png'),
                            radius: 23,
                          ),
                        ),
                      );
                    });
              }

              return const Text('No data found');
            },
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('User').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }

                if (snapshot.hasData) {
                  List<DocumentSnapshot> documents =
                      snapshot.data!.docs.toList();
                  return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data =
                            documents[index].data() as Map<String, dynamic>;
                        //print(documents[index].id);
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                  data: data,
                                  receiverId: documents[index].id.toString(),
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.03),
                            child: ListTile(
                              leading: const Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.amberAccent,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/cuteboy.png'),
                                    radius: 17,
                                  ),
                                ),
                              ),
                              title: Text(
                                data['name'].toString(),
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                data['email'].toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                              trailing: Text(
                                // "${Timestamp.now().toDate().hour} : ${Timestamp.now().toDate().minute}",
                                DateFormat.jm().format(DateTime.now()),
                                style: const TextStyle(
                                    fontSize: 9, fontWeight: FontWeight.w100),
                              ),
                            ),
                          ),
                        );
                      });
                }

                return const Text('No data found');
              },
            ),
          ),
        ),
      ],
    ));
  }
}
