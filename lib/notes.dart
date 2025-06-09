import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final titlecontrolller = TextEditingController();
  final Contentcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text("MIS NOTAS"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "mis notas de mujer",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: titlecontrolller,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: 'Enter Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: Icon(Icons.title),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: Contentcontroller,
                    decoration: InputDecoration(
                      labelText: 'Content',
                      hintText: 'Enter Content',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: Icon(Icons.text_fields),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance.collection('notes').add({
                        'title': titlecontrolller.text.trim(),
                        'content': Contentcontroller.text.trim(),
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                      titlecontrolller.clear();
                      Contentcontroller.clear();
                    },
                    child: Text('Save Notas'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('notes')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (Context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    final docs = snapshot.data!.docs;
                    if (docs.isEmpty) {
                      return Text('No hay notas');
                    } else {
                      return ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final doc = docs[index];
                          final title = doc['title'];
                          final content = doc['content'];
                          return ListTile(
                            title: Text(title),
                            subtitle: Text(content),
                            trailing: IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('notes')
                                    .doc(doc.id)
                                    .delete();
                              },
                              icon: Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}