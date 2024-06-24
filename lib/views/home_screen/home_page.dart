import 'package:flutter/material.dart';
import 'package:kaff_video_call/views/calling_interface/call_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Name');
  final _idController = TextEditingController(text: 'ID');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Video Call App'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextFormField(controller: _nameController),
              SizedBox(
                height: 20,
              ),
              TextFormField(controller: _idController),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Call'),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CallPage(
                callID: _idController.text.toString(),
                uName: _nameController.text.toString()),
          ));
        },
      ),
    );
  }
}
