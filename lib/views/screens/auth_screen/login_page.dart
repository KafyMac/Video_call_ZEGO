import 'package:flutter/material.dart';
import 'package:kaff_video_call/models/login_model/login_req.dart';
import 'package:kaff_video_call/models/login_model/login_resp.dart';
import 'package:kaff_video_call/network/api_connection.dart';
import 'package:kaff_video_call/utils/shared/widgets/buttons.dart';
import 'package:kaff_video_call/utils/shared/widgets/snack_bar.dart';
import 'package:kaff_video_call/utils/shared_preference/pref_utils.dart';
import 'package:kaff_video_call/views/screens/auth_screen/signUp_page.dart';
import 'package:kaff_video_call/views/screens/bottomNavbar/bottomnavbar_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _nameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    String pattern = r'^(?=.*?[a-z])(?=.*?\d)(?=.*?[!@#\$&*~])';
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid password';
    } else {
      return null;
    }
  }

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      var req = LoginReq(
        email: _nameController.text,
        password: _passwordController.text,
      );
      try {
        LoginResp? resp = await ApiService().loginWithEmail(req);
        setState(() {
          _isLoading = false;
        });
        if (resp.status == "Success") {
          String token = resp.data!.token!;
          PrefUtils().saveUserToken(token);
          CustomSnackBar.showSnackBar(
              context: context,
              message: "Logged in Successfully",
              color: Colors.green,
              icons: Icons.unpublished_outlined);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreens(),
              ));
        } else {
          CustomSnackBar.showSnackBar(
              context: context,
              message: "Failed to Login",
              color: Colors.red,
              icons: Icons.unpublished_outlined);
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        CustomSnackBar.showSnackBar(
            context: context,
            message: "Error while Login",
            color: Colors.red,
            icons: Icons.unpublished_outlined);
      }
    }
  }

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
          child: Form(
            key: _formKey,
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
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customFormField(
                            title: "Username",
                            controller: _nameController,
                            hintText: "Enter your username",
                            errorText: "Please enter your username",
                            focusNode: _nameFocusNode,
                            nextFocusNode: _passwordFocusNode,
                          ),
                          customFormField(
                            title: "Password",
                            controller: _passwordController,
                            hintText: "Enter your password",
                            errorText: "Please enter the password",
                            focusNode: _passwordFocusNode,
                            obscureText: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Must be at least 8 characters",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[700]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Center(
                              child: _isLoading
                                  ? const CircularProgressIndicator()
                                  : button(
                                      onPressed: login,
                                      title: "Log in",
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
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
                          "Don't have an account? ",
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
                                  builder: (context) => const SignUpPage(),
                                ));
                          },
                          child: const Text(
                            "Sign Up",
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
      ),
    );
  }

  Widget customFormField({
    TextEditingController? controller,
    String? hintText,
    String? errorText,
    FocusNode? focusNode,
    FocusNode? nextFocusNode,
    VoidCallback? onSubmit,
    required String title,
    bool obscureText = false,
  }) {
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
            color: Colors.grey[900],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    obscureText: obscureText,
                    style: const TextStyle(color: Colors.white),
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
                      } else if (title == "Username") {
                        return validateEmail(value);
                      } else if (title == "Password") {
                        return validatePassword(value);
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
