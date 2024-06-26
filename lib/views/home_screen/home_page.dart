import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaff_video_call/views/calling_interface/call_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _idFocusNode = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _nameFocusNode.dispose();
    _idFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() {
    _idFocusNode.unfocus();
    if (_formKey.currentState!.validate()) {
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
      appBar: AppBar(backgroundColor: const Color.fromRGBO(27, 29, 38, 1)),
      backgroundColor: const Color.fromRGBO(27, 29, 38, 1),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    child: Text(
                  "LETS\nTALK.",
                  style: GoogleFonts.play(color: Colors.white, fontSize: 50),
                )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Card(
                  elevation: 0,
                  color: const Color.fromRGBO(40, 74, 255, 1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(40, 74, 255, 1),
        onPressed: _submitForm,
        child: Text(
          'Connect',
          style: GoogleFonts.play(color: Colors.white),
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
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 0,
        color: const Color.fromRGBO(32, 59, 204, 1),
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
              hintStyle: GoogleFonts.play(color: Colors.white),
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
