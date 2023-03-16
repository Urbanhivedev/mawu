import 'package:flutter/material.dart';
import '../Helpers/constants.dart';
import '../Helpers/colors.dart';
import '../Screens/library_screen.dart';

class EntryScreen extends StatefulWidget {
  static const routeName = '/entry_screen';
  const EntryScreen({super.key});

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String password = '';
  String email = '';
  bool _loading = false;
  final bool _obscureText = true;
  var loginUser;

  @override
  void initState() {
    super.initState();
    // _passwordController.text = "Password@1";
    // _emailController.text = "user@gmail.com";
  }

  @override
  Widget build(BuildContext context) {
    var loading = const CircularProgressIndicator(
      color: Colors.white,
    );
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: black,
        body: SingleChildScrollView(
          child: AutofillGroup(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                verticalSpacer(60),
                const Image(
                    image: AssetImage(
                  'assets/icons/mawu_logo.png',
                )),
                // SvgPicture.asset(
                //   'assets/icons/mawu_logo.svg',
                //   fit: BoxFit.cover,
                // ),
                verticalSpacer(60),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("EMAIL",
                          style: TextStyle(
                              color: orange,
                              fontSize: 18,
                              fontWeight: FontWeight.w400)),
                      verticalSpacer(15),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: _emailController,
                        validator: (input) => !input!.contains('@')
                            ? 'Enter correct email'
                            : null,
                        onSaved: (input) => email = input!,
                        autofillHints: const [AutofillHints.email],
                        cursorColor: Colors.orange,
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: orange)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: orange)),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text("PASSWORD",
                          style: TextStyle(
                              color: orange,
                              fontSize: 18,
                              fontWeight: FontWeight.w400)),
                      verticalSpacer(15),
                      TextFormField(
                        style: TextStyle(color: black),
                        controller: _passwordController,
                        validator: (input) => input!.length < 6
                            ? 'Password must be atleast 6 characters'
                            : null,
                        onSaved: (input) => password = input!,
                        autofillHints: const [AutofillHints.password],
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: orange)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: orange)),
                        ),
                      ),

                      const SizedBox(height: 40),

                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Center(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              decoration: BoxDecoration(
                                  color: black,
                                  border: Border.all(color: Colors.white)),
                              child: TextButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _loading = true;
                                      });
                                      await Future.delayed(
                                          const Duration(seconds: 2));
                                      _loading = false;
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LibraryScreen()));
                                    }
                                  },
                                  child: _loading == true
                                      ? Center(
                                          child: loading,
                                        )
                                      : const Text("SIGN IN",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700))),
                            ),
                          ),
                        ),
                      ),

                      // _loading
                      //     ?
                      //     :
                      const SizedBox(height: 30),
                      Center(
                        child: InkWell(
                          child: const Text(
                            'Forget Password',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ResetPassword()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
