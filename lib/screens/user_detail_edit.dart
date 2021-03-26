import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailEdit extends StatefulWidget {
  @override
  _UserDetailEditState createState() => _UserDetailEditState();
}

class _UserDetailEditState extends State<UserDetailEdit> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit your details"),
      ),
      body: FutureBuilder(
        future:
            FirebaseFirestore.instance.collection('user').doc(user!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Form(
                  child: ListView(
                children: [
                  TextFormField(
                    initialValue: snapshot.data!.data()?['name'] ?? '',
                    decoration: InputDecoration(
                      hintText: "Name",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Please enter the Name";
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Email",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      initialValue: user.email,
                      validator: (value) {
                        if (value!.isEmpty) return "Please enter the Email";
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                      ),
                      initialValue: snapshot.data!.data()?['phonenumber'] ?? '',
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty)
                          return "Please enter the phoneNumber";
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Address",
                      ),
                      maxLines: 5,
                      initialValue: snapshot.data!.data()?['address'] ?? '',
                      validator: (value) {
                        if (value!.isEmpty) return "Please enter the Address";
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 16),
                    child: ElevatedButton(
                      child: Container(
                        alignment: Alignment.center,
                        width: 70,
                        child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              )),
            );
          }
          return Container();
        },
      ),
    );
  }
}
