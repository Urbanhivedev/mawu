import 'package:flutter/material.dart';
import 'package:mawu/Screens/play_screen.dart';
import 'package:mawu/Screens/register_screen.dart';
import '../Config/Blocs/login_bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final bool _loading = false;
  final bool _obscureText = true;
  var loginUser;
  LoginBloc? loginBloc;

  @override
  void initState() {
    super.initState();
    // _passwordController.text = "Password@1";
    // _emailController.text = "user@gmail.com";
  }

  @override
  Widget build(BuildContext context) {
    loginBloc = BlocProvider.of<LoginBloc>(context);
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
                        style: TextStyle(color: black),
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
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
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
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: orange)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: orange)),
                        ),
                      ),

                      const SizedBox(height: 40),
                      BlocListener<LoginBloc, LoginState>(
                        listener: ((context, state) {
                          if (state is LoginSuccessful) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PlayScreen()));
                          }
                        }),
                        child: BlocBuilder<LoginBloc, LoginState>(
                            builder: ((context, state) {
                          if (state is LoginInProgress) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60),
                                  decoration: BoxDecoration(
                                      color: black,
                                      border: Border.all(color: Colors.white)),
                                  child: TextButton(
                                      onPressed: () async {},
                                      child: loader(size: 25)),
                                ),
                              ),
                            );
                          } else if (state is LoginFailed) {
                            Future.delayed(Duration.zero, () {
                              // Navigator.of(context).pop();
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                  content: Text(state.message),
                                  backgroundColor: Colors.red,
                                ));
                            });
                          }

                          return GestureDetector(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60),
                                  decoration: BoxDecoration(
                                      color: black,
                                      border: Border.all(color: Colors.white)),
                                  child: TextButton(
                                      onPressed: () async {
                                        FocusScope.of(context).unfocus();
                                        if (_formKey.currentState!.validate()) {
                                          loginBloc?.add(
                                            LoginButtonPressed(
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text),
                                          );
                                        }
                                      },
                                      child: const Text("SIGN IN",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700))),
                                ),
                              ),
                            ),
                          );
                        })),
                      ),

                      // GestureDetector(
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 32),
                      //     child: Center(
                      //       child: Container(
                      //         padding:
                      //             const EdgeInsets.symmetric(horizontal: 60),
                      //         decoration: BoxDecoration(
                      //             color: black,
                      //             border: Border.all(color: Colors.white)),
                      //         child: TextButton(
                      //             onPressed: () async {
                      //               if (_formKey.currentState!.validate()) {
                      //                 setState(() {
                      //                   _loading = true;
                      //                 });
                      //                 await Future.delayed(
                      //                     const Duration(seconds: 2));
                      //                 _loading = false;
                      //                 Navigator.pushReplacement(
                      //                     context,
                      //                     MaterialPageRoute(
                      //                         builder: (context) =>
                      //                             const LibraryScreen()));
                      //               }
                      //             },
                      //             child: const Text("SIGN IN",
                      //                 style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontSize: 18,
                      //                     fontWeight: FontWeight.w700))),
                      //       ),
                      //     ),
                      //   ),
                      // ),

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
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Text(
                                'New User? ',
                                style: TextStyle(fontSize: 16, color: orange),
                              ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              child: Text(
                                'Create account',
                                style: TextStyle(color: white, fontSize: 16.0),
                              ),
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen()));
                              },
                            ),
                            const SizedBox(width: 10),
                          ],
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
