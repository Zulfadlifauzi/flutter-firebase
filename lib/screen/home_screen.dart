import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donationapp/models/add_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final userInfo = FirebaseAuth.instance.currentUser!;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: controller,
        ),
        actions: [
          IconButton(
              onPressed: () {
                final name = controller.text;

                if (name.isNotEmpty) {
                  createUser(name: name);
                  controller.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Please enter name')));
                }
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Signed In as'),
              Text(
                userInfo.email!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  icon: const Icon(Icons.logout_outlined),
                  label: const Text('Sign Out'))
            ],
          ),
        ),
      ),
    );
  }

  Future createUser({required String name}) async {
    var uuid = const Uuid();

    //Reference to the document
    final docUser =
        FirebaseFirestore.instance.collection('users').doc(uuid.v4());
    final json = UserModel(
        id: docUser.id, name: name, age: 21, birthday: DateTime.now());
    final jsonResponse = json.toJson();
    //create new document and write new data to firestore
    await docUser.set(jsonResponse);
  }
}
