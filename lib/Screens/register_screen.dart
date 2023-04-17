import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawu/Screens/entry_screen.dart';
import 'package:mawu/Screens/play_screen.dart';
import '../Config/Blocs/signup_bloc/signup_bloc.dart';
import '../Helpers/constants.dart';
import '../Helpers/colors.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/entry_screen';
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //File? image;
  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String confirmPass = "";
  bool _obscureText = true;
  bool _obscure = true;
  bool _loading = false;
  SignupBloc? signupBloc;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      _obscure = !_obscure;
    });
  }

  // Future<String?> onPickImage() async {
  //   setState(() {
  //     _loading = true;
  //   });
  //   final imagePicked =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);

  //   if (imagePicked != null) {
  //     return imagePicked.path;
  //   } else {
  //     return null;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // _passwordController.text = "Password@1";
    // _emailController.text = "user@gmail.com";
  }

  @override
  Widget build(BuildContext context) {
    signupBloc = BlocProvider.of<SignupBloc>(context);
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: AutofillGroup(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  verticalSpacer(10),
                  const Image(
                      image: AssetImage(
                    'assets/icons/mawu_logo.png',
                  )),
                  // SvgPicture.asset(
                  //   'assets/icons/mawu_logo.svg',
                  //   fit: BoxFit.cover,
                  // ),
                  verticalSpacer(40),
                  // Center(
                  //   child: _loading
                  //       ? Container(
                  //           height: 100,
                  //           width: 100,
                  //           decoration: BoxDecoration(
                  //             border: Border.all(
                  //               color: Colors.grey,
                  //               width: 1,
                  //             ),
                  //           ),
                  //           child: const Center(
                  //             child: CircularProgressIndicator(),
                  //           ),
                  //         )
                  //       : image == null
                  //           ? Container(
                  //               height: 100,
                  //               width: 100,
                  //               decoration: BoxDecoration(
                  //                 border: Border.all(
                  //                   color: Colors.grey,
                  //                   width: 1,
                  //                 ),
                  //               ),
                  //               child: Center(
                  //                 child: IconButton(
                  //                     icon: Icon(
                  //                       Icons.image,
                  //                       color: white.withOpacity(0.7),
                  //                       size: 30,
                  //                     ),
                  //                     onPressed: () async {
                  //                       var imagePath = await onPickImage();
                  //                       setState(() {
                  //                         _loading = false;
                  //                       });
                  //                       if (imagePath == null) {
                  //                         Future.delayed(Duration.zero, () {
                  //                           ScaffoldMessenger.of(context)
                  //                             ..removeCurrentSnackBar()
                  //                             ..showSnackBar(const SnackBar(
                  //                               content: Text(
                  //                                   "Failed to pick an Image"),
                  //                               backgroundColor: Colors.black,
                  //                             ));
                  //                         });
                  //                       } else {
                  //                         final tempimage =
                  //                             File(imagePath.toString());
                  //                         setState(() {
                  //                           image = tempimage;
                  //                         });
                  //                       }
                  //                     }),
                  //               ),
                  //             )
                  //           : Container(
                  //               height: 100,
                  //               width: 100,
                  //               decoration: BoxDecoration(
                  //                 image: DecorationImage(
                  //                     image: FileImage(image!),
                  //                     fit: BoxFit.cover),
                  //                 border: Border.all(
                  //                   color: Colors.grey,
                  //                   width: 1,
                  //                 ),
                  //               ),
                  //             ),
                  // ),

                  verticalSpacer(15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("First Name",
                            style: TextStyle(
                                color: orange,
                                fontSize: 17,
                                fontWeight: FontWeight.w400)),
                        verticalSpacer(10),
                        TextFormField(
                          style: TextStyle(color: black),
                          controller: _firstNameController,
                          validator: (input) => input!.trim().isEmpty
                              ? 'Enter your FirstName'
                              : null,
                          onSaved: (input) => email = input!,
                          autofillHints: const [AutofillHints.email],
                          cursorColor: Colors.orange,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: orange)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: orange)),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text("Last Name",
                            style: TextStyle(
                                color: orange,
                                fontSize: 18,
                                fontWeight: FontWeight.w400)),
                        verticalSpacer(10),
                        TextFormField(
                          style: TextStyle(color: black),
                          controller: _lastNameController,
                          validator: (input) => input!.trim().isEmpty
                              ? 'Enter your LastName'
                              : null,
                          onSaved: (input) => email = input!,
                          autofillHints: const [AutofillHints.email],
                          cursorColor: Colors.orange,
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.grey),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: orange)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: orange)),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text("Email",
                            style: TextStyle(
                                color: orange,
                                fontSize: 18,
                                fontWeight: FontWeight.w400)),
                        verticalSpacer(10),
                        TextFormField(
                          style: TextStyle(color: black),
                          controller: _emailAddressController,
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
                        const SizedBox(height: 30),
                        Text("Password",
                            style: TextStyle(
                                color: orange,
                                fontSize: 18,
                                fontWeight: FontWeight.w400)),
                        verticalSpacer(10),
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
                        const SizedBox(height: 30),
                        BlocListener<SignupBloc, SignupState>(
                          listener: (context, state) {
                            if (state is SignupSuccessful) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PlayScreen()));
                            }
                          },
                          child: BlocBuilder<SignupBloc, SignupState>(
                            builder: (context, state) {
                              if (state is SignupInProgress) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32),
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 60),
                                      decoration: BoxDecoration(
                                          color: black,
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: TextButton(
                                          onPressed: () async {},
                                          child: loader(size: 25)),
                                    ),
                                  ),
                                );
                              } else if (state is SignupFailed) {
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32),
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 60),
                                      decoration: BoxDecoration(
                                          color: black,
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: TextButton(
                                          onPressed: () async {
                                            FocusScope.of(context).unfocus();
                                            var validate = _formKey.currentState
                                                ?.validate();
                                            // if (image == null) {
                                            //   validate = false;
                                            //   Future.delayed(Duration.zero, () {
                                            //     ScaffoldMessenger.of(context)
                                            //       ..removeCurrentSnackBar()
                                            //       ..showSnackBar(const SnackBar(
                                            //         content: Text(
                                            //             'Profile Image Field Cannot Be Empty'),
                                            //         backgroundColor: Colors.red,
                                            //       ));
                                            //   });
                                            // }
                                            if (_formKey.currentState!
                                                .validate()) {
                                              FocusScope.of(context).unfocus();
                                              signupBloc?.add(
                                                SignupButtonPressed(
                                                  // image: image!,
                                                  email: _emailAddressController
                                                      .text,
                                                  firstName:
                                                      _firstNameController.text,
                                                  lastName:
                                                      _lastNameController.text,
                                                  password:
                                                      _passwordController.text,
                                                ),
                                              );
                                            } else {
                                              setState(() {
                                                _loading = false;
                                              });
                                            }
                                          },
                                          child: const Text("Register",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.w700))),
                                    ),
                                  ),
                                ),
                              );
                              // }
                              // print('nothing $state');
                              // return Container();
                              // print('buildernothing $state');
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  'Already have an account?',
                                  style: TextStyle(fontSize: 16, color: orange),
                                ),
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                child: Text(
                                  'Login',
                                  style:
                                      TextStyle(color: white, fontSize: 16.0),
                                ),
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EntryScreen()));
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
      ),
    );
  }
}
