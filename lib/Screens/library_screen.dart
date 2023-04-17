import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mawu/Helpers/constants.dart';
import 'package:mawu/Helpers/colors.dart';
import 'package:mawu/Screens/play_screen.dart';

import '../Config/Repositories/user_repository.dart';
import '../Models/app_user_model.dart';
import 'discover_test.dart';

class LibraryScreen extends StatefulWidget {
  static const routeName = '/entry_screen';
  const LibraryScreen({super.key});

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String password = '';
  String email = '';
  final bool _loading = false;
  final bool _obscureText = true;
  var loginUser;
  AppUser? currentUser;

  @override
  void initState() {
    // TODO: implement initState
    UserRepository().fetchCurrentUser().then((value) {
      setState(() {
        currentUser = value;
      });
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var loading = const CircularProgressIndicator();
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 50,
                          width: 50,
                        ),
                        Column(
                          children: [
                            verticalSpacer(20),
                            const Text("Welcome To",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500)),
                            Text("MAWU",
                                style: TextStyle(
                                    color: orange,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: light_background,
                              border: Border.all(color: orange),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    currentUser == null
                                        ? ""
                                        : currentUser!.imageUrl,
                                  ),
                                  fit: BoxFit.cover)),
                        )
                      ],
                    ),
                  ),
                  verticalSpacer(70),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PlayScreen()));
                    },
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: light_background,
                          border: Border.all(color: orange)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("YOUR",
                              style: TextStyle(
                                  color: orange,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500)),
                          Text("LIBRARY",
                              style: TextStyle(
                                  color: orange,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PlayScreen()));
                        },
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: light_background,
                              border: Border.all(color: orange)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("VIRTUAL",
                                  style: TextStyle(
                                      color: orange,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500)),
                              Text("CINEMA",
                                  style: TextStyle(
                                      color: orange,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      ),
                      horizontalSpacer(10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PlayScreen()));
                        },
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: light_background,
                              border: Border.all(color: orange)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("FILM",
                                  style: TextStyle(
                                      color: orange,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500)),
                              Text("FESTIVAL",
                                  style: TextStyle(
                                      color: orange,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  verticalSpacer(90),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DiscoverTestScreen(
                                    currentUser: currentUser!,
                                  )));
                    },
                    child: Text("FRIENDS ONLINE",
                        style: TextStyle(
                            color: orange,
                            fontSize: 22,
                            fontWeight: FontWeight.w500)),
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
