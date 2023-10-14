import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/services/firestore.dart';

class EditPageList extends StatefulWidget {
  final QueryDocumentSnapshot note;

  const EditPageList({Key? key, required this.note}) : super(key: key);

  @override
  State<EditPageList> createState() => _EditPageListState();
}

class _EditPageListState extends State<EditPageList> {
  final FirestoreServices firestoreServices = FirestoreServices();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.note['Title'];
    descriptionController.text = widget.note['Discription'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Edit Todo")),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: "Title"),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: "Description"),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Center(child: Text("Task Updated Successfully")),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Set the border radius
                ),
                backgroundColor: const Color.fromARGB(255, 27, 252, 184),
              ));

              updateNote(
                widget.note.id,
                titleController.text,
                descriptionController.text,
              );
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  Future<void> updateNote(
      String docID, String newTitle, String newDescription) {
    return firestoreServices.updateNote(docID, newTitle, newDescription);
  }
}
