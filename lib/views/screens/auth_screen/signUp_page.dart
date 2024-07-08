import 'package:flutter/material.dart';
import 'package:kaff_video_call/models/create_user_model/create_req.dart';
import 'package:kaff_video_call/models/create_user_model/create_resp.dart';
import 'package:kaff_video_call/network/api_connection.dart';
import 'package:kaff_video_call/utils/shared/widgets/buttons.dart';
import 'package:kaff_video_call/utils/shared/widgets/snack_bar.dart';
import 'package:kaff_video_call/views/screens/auth_screen/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _mobileNumberFocusNode = FocusNode();
  bool _isLoading = false;

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

  String? validateMobile(String? input) {
    String pattern = r'^[0-9]{10}$';
    RegExp regex = RegExp(pattern);
    if (input == null || input.isEmpty || !regex.hasMatch(input)) {
      return 'Enter a valid mobile number';
    } else {
      return null;
    }
  }

  Future<void> createAccount() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      var req = CreateUserReq(
        name: _nameController.text,
        mobileNumber: _mobileNumberController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
      try {
        CreateUserResp? resp = await ApiService().createUser(req);
        setState(() {
          _isLoading = false;
        });
        if (resp.success == "Success") {
          CustomSnackBar.showSnackBar(
              context: context,
              message: "Account created Successfully",
              color: Colors.green,
              icons: Icons.unpublished_outlined);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
            (route) => false,
          );
        } else {
          CustomSnackBar.showSnackBar(
              context: context,
              message: "Failed to create account",
              color: Colors.red,
              icons: Icons.unpublished_outlined);
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        CustomSnackBar.showSnackBar(
            context: context,
            message: "Error while creating account",
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
                            controller: _nameController,
                            hintText: "Enter your name",
                            errorText: "Please enter your name",
                            focusNode: _nameFocusNode,
                            nextFocusNode: _emailFocusNode,
                          ),
                          customFormField(
                            title: "Email",
                            controller: _emailController,
                            hintText: "Enter your EmailId",
                            errorText: "Please enter your EmailId",
                            focusNode: _emailFocusNode,
                            nextFocusNode: _mobileNumberFocusNode,
                          ),
                          customFormField(
                            title: "Mobile No.",
                            controller: _mobileNumberController,
                            hintText: "Enter your mobile no.",
                            errorText: "Please enter your mobile no.",
                            focusNode: _mobileNumberFocusNode,
                            nextFocusNode: _passwordFocusNode,
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
                          ),
                          customFormField(
                            title: "Password",
                            controller: _passwordController,
                            hintText: "Enter your password",
                            errorText: "Please enter a password",
                            focusNode: _passwordFocusNode,
                            obscureText: true,
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
                              child: _isLoading
                                  ? const CircularProgressIndicator()
                                  : button(
                                      onPressed: () {
                                        createAccount();
                                      },
                                      title: "Sign Up",
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
    TextInputType? keyboardType,
    int? maxLength,
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
            elevation: 0,
            color: Colors.grey[900],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: keyboardType,
                    maxLength: maxLength,
                    buildCounter: (BuildContext context,
                            {int? currentLength,
                            int? maxLength,
                            bool? isFocused}) =>
                        null,
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
                      } else if (title == "Email") {
                        return validateEmail(value);
                      } else if (title == "Password") {
                        return validatePassword(value);
                      } else if (title == "Mobile No.") {
                        return validateMobile(value);
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
