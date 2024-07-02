import 'package:flutter/material.dart';
import 'package:kaff_video_call/utils/shared/widgets/buttons.dart';
import 'package:kaff_video_call/views/screens/auth_screen/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [
                Color.fromARGB(255, 83, 0, 98),
                Color.fromARGB(255, 0, 0, 0)
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 32.0),
                child: Text(
                  "ZEGO",
                  style: TextStyle(
                      fontFamily: "karla",
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
              ),
              const Column(
                children: [
                  Text(
                    "Sign Up Account",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Text(
                    "Enter you personal data to create your account",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customFormField(
                          title: "Name",
                          controller: null,
                          hintText: "Enter your name",
                          errorText: "Please enter your name",
                          focusNode: null,
                          nextFocusNode: null,
                        ),
                        customFormField(
                          title: "Email",
                          controller: null,
                          hintText: "Enter your EmailId",
                          errorText: "Please enter the Room ID",
                          focusNode: null,
                          onSubmit: null,
                        ),
                        customFormField(
                          title: "Mobile No.",
                          controller: null,
                          hintText: "Enter your mobile no.",
                          errorText: "Please enter the Room ID",
                          focusNode: null,
                          onSubmit: null,
                        ),
                        customFormField(
                          title: "Password",
                          controller: null,
                          hintText: "Enter your password",
                          errorText: "Please enter the Room ID",
                          focusNode: null,
                          onSubmit: null,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Must be atleast 8 characters",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[700]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Center(
                            child: button(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ));
                              },
                              title: "Sign Up",
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 50,
                              color: Colors.white,
                              borderRadius: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[500]),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ));
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
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
      VoidCallback? onSubmit,
      required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ),
          Card(
            elevation: 0,
            color: Colors.grey[900],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
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
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[500]),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return errorText;
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
