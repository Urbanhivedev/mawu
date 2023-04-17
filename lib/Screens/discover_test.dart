import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../Config/Repositories/firestore_repository.dart';
import '../Helpers/colors.dart';
import '../Helpers/constants.dart';
import '../Models/app_user_model.dart';
import 'chat_screen.dart';

class DiscoverTestScreen extends StatefulWidget {
  const DiscoverTestScreen({Key? key, required this.currentUser})
      : super(key: key);
  static const routeName = '/usermatches';

  final AppUser currentUser;

  @override
  State<DiscoverTestScreen> createState() => _DiscoverTestScreenState();
}

class _DiscoverTestScreenState extends State<DiscoverTestScreen> {
  Stream<QuerySnapshot>? chats;
  final _formKey = GlobalKey<FormBuilderState>();

  Widget friendsListPage() {
    return StreamBuilder(
      stream: chats,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print("waiting");
          return loader();
        }

        // ignore: prefer_is_empty
        if (snapshot.hasData && snapshot.data!.docs.length > 0) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            dragStartBehavior: DragStartBehavior.down,
            itemCount: snapshot.data?.docs.length ?? 6,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              AppUser buddyUser = AppUser(
                firstName: ds.get("firstName"),
                email: ds.get("email"),
                lastName: ds.get("lastName"),
                imageUrl: ds.get("imageUrl"),
                id: ds.get("id"),
              );
              print(snapshot.data?.docs.length);
              return GestureDetector(
                onTap: (() async {
                  String chatRoomId = await FirestoreRepository()
                      .createChatRoomId(widget.currentUser.id!, buddyUser.id!);

                  await FirestoreRepository()
                      .openChatroom(widget.currentUser.id!, buddyUser.id!);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatScreen(
                              currentUser: widget.currentUser,
                              invitedUser: buddyUser,
                              chatRoomId: chatRoomId,
                            )),
                  );
                }),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: orange, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 5, bottom: 5, right: 20),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            buddyUser.imageUrl,
                          ),
                        ),
                        title: Text(
                          '${buddyUser.firstName} ${buddyUser.lastName}',
                          style: TextStyle(color: orange),
                        ),
                        trailing: Icon(
                          Icons.message,
                          color: orange,
                        ),
                      ),
                    ),
                  ),
                ),
              );
              // return DiscoverScreenWidget(
              //   pageCount: snapshot.data?.docs.length,
              //   pageNumber: index,
              //   pageController: pageController,
              //   imageUrl: widget.currentUser.imageUrl,
              //   buddyUser: buddyUser,
              //   mainUser: widget.currentUser,
              // );
            },
          );
          // ignore: prefer_is_empty
        } else if (snapshot.data?.docs.length == 0) {
          return const NoUserWidget(
            mainText: "No User Available",
            subText: "Try Again Later",
          );
        }

        return loader();
      },
    );
  }

  @override
  void initState() {
    FirestoreRepository().getUsersCredentialsbyid(widget.currentUser.id!).then(
        (value) => FirestoreRepository()
                .getAllUsers(widget.currentUser.id!)
                .then((val) {
              setState(() {
                chats = val;
              });
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      right: false,
      left: false,
      bottom: false,
      child: Scaffold(
          backgroundColor: black,
          appBar: MessageAppar(context, 'Friends', widget.currentUser.imageUrl),
          body: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: friendsListPage(),
          )),
    );
  }
}

class NoUserWidget extends StatelessWidget {
  const NoUserWidget({
    Key? key,
    required this.mainText,
    required this.subText,
  }) : super(key: key);

  final String mainText, subText;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          mainText,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: Colors.black),
        ),
        verticalSpacer(10),
        Text(subText),
        verticalSpacer(10),
        Container(
          height: 80,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Error1.png'))),
        )
      ],
    ));
  }
}
