import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Config/Blocs/auth_bloc/auth_bloc.dart';
import 'Config/Blocs/login_bloc/login_bloc.dart';
import 'Config/Blocs/signup_bloc/signup_bloc.dart';
import 'Config/Repositories/firebase_storage_repository.dart';
import 'Config/Repositories/firestore_repository.dart';
import 'Config/Repositories/user_repository.dart';
import 'Screens/welcome_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();
    final firestoreRepository = FirestoreRepository();
    final firebaseStorageRepository = FirebaseStorageRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(userRepository, firestoreRepository),
        ),
        BlocProvider(
          create: (context) => SignupBloc(
              userRepository, firestoreRepository, firebaseStorageRepository),
        ),
        BlocProvider(
          create: (context) => AuthBloc(userRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.orange,
        ),
        home: const WelcomeScreen(),

        // StreamBuilder<User?>(
        //     stream: FirebaseAuth.instance.authStateChanges(),
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const SplashScreen();
        //       } else if (snapshot.hasData) {
        //         return const WelcomeScreen();
        //       } else {
        //         return const WelcomeScreen();
        //       }
        //     }),
      ),
    );
  }
}
