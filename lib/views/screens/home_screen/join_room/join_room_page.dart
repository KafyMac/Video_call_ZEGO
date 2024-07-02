import 'package:flutter/material.dart';
import 'package:kaff_video_call/utils/shared/widgets/buttons.dart';
import 'package:kaff_video_call/views/screens/calling_interface/call_page.dart';

class JoinRoom extends StatefulWidget {
  const JoinRoom({super.key});

  @override
  State<JoinRoom> createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _idFocusNode = FocusNode();

  void _submitForm() {
    _idFocusNode.unfocus();
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      Navigator.of(context)
          .push(MaterialPageRoute(
            builder: (context) => CallPage(
                callID: _idController.text.toString(),
                uName: _nameController.text.toString()),
          ))
          .then((value) => setState(() {
                _nameController.clear();
                _idController.clear();
              }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill in the form correctly")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
        title: const Text(
          "Join Room",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            children: [
              const Text(
                'Enter Name and Room ID',
                style: TextStyle(color: Colors.white),
              ),
              customFormField(
                controller: _nameController,
                hintText: "Enter your name",
                errorText: "Please enter your name",
                focusNode: _nameFocusNode,
                nextFocusNode: _idFocusNode,
              ),
              customFormField(
                controller: _idController,
                hintText: "Enter the Room ID",
                errorText: "Please enter the Room ID",
                focusNode: _idFocusNode,
                onSubmit: _submitForm,
              ),
              button(
                color: Colors.white,
                borderRadius: 50,
                onPressed: () {
                  _submitForm();
                  Navigator.of(context).pop();
                },
                title: "Join Room",
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customFormField(
      {TextEditingController? controller,
      String? hintText,
      String? errorText,
      FocusNode? focusNode,
      FocusNode? nextFocusNode,
      VoidCallback? onSubmit}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        elevation: 0,
        color: Colors.grey[800],
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            textInputAction: nextFocusNode != null
                ? TextInputAction.next
                : TextInputAction.done,
            onFieldSubmitted: (value) {
              if (nextFocusNode != null) {
                FocusScope.of(context).requestFocus(nextFocusNode);
              } else if (onSubmit != null) {
                onSubmit();
              }
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w100,
                  color: Colors.grey[700]),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return errorText;
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
