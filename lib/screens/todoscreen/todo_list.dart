// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/addScreen/add_page.dart';
import 'package:todo_app/screens/editScreen/edit_page.dart';
import 'package:todo_app/screens/services/firestore.dart';

class TodoListPagState extends StatefulWidget {
  const TodoListPagState({Key? key}) : super(key: key);

  @override
  State<TodoListPagState> createState() => _TodoListPagStateState();
}

class _TodoListPagStateState extends State<TodoListPagState> {
  final FirestoreServices firestoreServices = FirestoreServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Todo List")),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreServices.getNoteStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Add Your Notes'));
          }

          List notesList = snapshot.data!.docs;
          return ListView.builder(
            itemCount: notesList.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = notesList[index];
              String docID = document.id;
              final note = notesList[index];
              final title = note['Title'];
              final description = note['Discription'];

              return ListTile(
                leading: CircleAvatar(child: Text("${index + 1}")),
                title: Text(title),
                subtitle: Text(description),
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    if (value == "Edit") {
                      navigateToEditPage(context, note);
                    } else {
                      firestoreServices.deleteNote(docID);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                         const     Center(child: Text("Task Deleted Successfully")),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor:const Color.fromARGB(255, 247, 77, 65)));
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(value: "Edit", child: Text("Edit")),
                      const PopupMenuItem(
                          value: "Delete", child: Text("Delete")),
                    ];
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: const Center(child: Text("Add todo")),
      ),
    );
  }

  void navigateToAddPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddPageList(),
      ),
    );
  }

  void navigateToEditPage(
      BuildContext context, QueryDocumentSnapshot notesList) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPageList(note: notesList),
      ),
    );
  }
}
