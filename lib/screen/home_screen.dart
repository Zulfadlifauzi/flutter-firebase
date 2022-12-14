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
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  final validationKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: validationKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value != null) {
                      return null;
                    } else {
                      return 'Please enter name';
                    }
                  },
                  decoration: const InputDecoration(labelText: 'name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value != null) {
                      return null;
                    } else {
                      return 'Please enter age';
                    }
                  },
                  controller: ageController,
                  decoration: const InputDecoration(labelText: 'age'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value != null) {
                      return null;
                    } else {
                      return 'Please enter birthday';
                    }
                  },
                  controller: birthdayController,
                  decoration: const InputDecoration(labelText: 'birthday'),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                    onPressed: () {
                      if (validationKey.currentState!.validate()) {
                        final users = UserModel(
                            name: nameController.text,
                            age: int.parse(ageController.text),
                            birthday: DateTime.parse(birthdayController.text));
                        createUser(users);
                        nameController.clear();
                        ageController.clear();
                        birthdayController.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Please enter name')));
                      }
                    },
                    icon: const Icon(Icons.logout_outlined),
                    label: const Text('Sign Out'))
                // ElevatedButton.icon(
                //     style: ElevatedButton.styleFrom(
                //         minimumSize: const Size.fromHeight(50)),
                //     onPressed: () => FirebaseAuth.instance.signOut(),
                //     icon: const Icon(Icons.logout_outlined),
                //     label: const Text('Sign Out'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future createUser(UserModel user) async {
    var uuid = const Uuid();

    //Reference to the document
    final docUser =
        FirebaseFirestore.instance.collection('users').doc(uuid.v4());
    user.id = docUser.id;
    final jsonResponse = user.toJson();
    //create new document and write new data to firestore
    await docUser.set(jsonResponse);
  }
}
