import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_council/colors.dart';
import 'package:luxury_council/controllers/chat_controller.dart';

import '../constance/firestore_constants.dart';
import '../constance/global_data.dart';
import '../models/chat/user_chat.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final ChatController chatController = Get.put(ChatController());
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final List<bool> _selectedButton = <bool>[true, false];
  /*final List<Map<String, dynamic>> _allUsers = [
    {
      "id": 1,
      "profile": "assets/chatimg.png",
      "name": "Allie Grater",
      "description": "Lorem ipsum bdolofr sit amet Lorem ipsum dolor sit"
    },
    {
      "id": 2,
      "profile": "assets/chatimg.png",
      "name": "Aragon Grater",
      "description": " ipsum dfolor sit amet Lorem ipsum dolor sit"
    },
    {
      "id": 3,
      "profile": "assets/chatimg.png",
      "name": "Bob Grater",
      "description": "jLorem ipsum  sitt amuyet Loorem ipsum dolor sit"
    },
    {
      "id": 5,
      "profile": "assets/chatimg.png",
      "name": "Candy Grater",
      "description": " ipsum doglort sitii ipusum dolor sit"
    },
    {
      "id": 6,
      "profile": "assets/chatimg.png",
      "name": "Colin Grater",
      "description": "eLorem ipsum  sit ameto Lorem  dolor sit"
    },
    {
      "id": 7,
      "profile": "assets/chatimg.png",
      "name": "Audra Grater",
      "description": "aLorem ipsum tdolor sit amet Lorem ipsum dcolor sit"
    },
    {
      "id": 8,
      "profile": "assets/chatimg.png",
      "name": "Banana Grater",
      "description": "qeLorem ipsum dolor sit  Losrjem ipsum dolor sit"
    },
    {
      "id": 9,
      "profile": "assets/chatimg.png",
      "name": "Caversky Grater",
      "description": "mLorem  dolor sit  Lorem ipsum dolor sit"
    },
    {
      "id": 10,
      "profile": "assets/chatimg.png",
      "name": "Becky Grater",
      "description": " tipsum dolor sit  Lorem ipsum dolor sit"
    },
  ];*/

  List<Map<String, dynamic>> _foundUsers = [];

  @override
  initState() {
    // _foundUsers = _allUsers;
    getCurrentId();
    chatController.getUserChatList(context, 1, 3);
    super.initState();
  }

 /* void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundUsers = results;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.loginappbar,
      appBar: AppBar(
        backgroundColor: AppColor.appbar,
        bottomOpacity: 1.0,
        elevation: 4,
        leadingWidth: 30,
        title: Text(
          "CHAT",
          style: TextStyle(
              color: AppColor.white, fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.left,
        ),
        leading: Container(
          margin: EdgeInsets.only(left: 18),
          child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColor.white,
                size: 20,
              )),
        ),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed("/SearchPage");
                },
                child: Container(
                  margin: EdgeInsets.only(right: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(
                      "assets/search.png",
                      color: AppColor.white,
                      scale: 2.3,
                    ),
                  ),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(right: 8),
              //   child: Padding(
              //     padding: const EdgeInsets.all(4.0),
              //     child: Image.asset(
              //       "assets/dotmenu.png",
              //       scale: 2.9,
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
      body:
    Obx(()=>
     chatController.chatListing.isNotEmpty?
     Column(
       children: [
         Container(
           color: AppColor.appbar.withOpacity(0.5),
           child: ToggleButtons(
               direction: Axis.horizontal,
               onPressed: (int index) {
                 setState(() {
                   for (int i = 0; i < _selectedButton.length; i++) {
                     _selectedButton[i] = i == index;
                   }
                 });
               },
               selectedBorderColor: AppColor.grey,
               selectedColor: Colors.white,
               fillColor: AppColor.primarycolor,
               color: Colors.white,
               constraints: const BoxConstraints(
                 minHeight: 50.0,
                 minWidth: 175.0,
               ),
               isSelected: _selectedButton,
               children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Text(
                     "All",
                     style: TextStyle(
                       fontSize: 14,
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Text(
                     "Chats",
                     style: TextStyle(
                       fontSize: 14,
                     ),
                   ),
                 ),
               ]),
         ),
         Expanded(
             child: _selectedButton[0] ? _setAllUseListing() : _setChatListing()
         )
       ],
     ): Container()
    )
    );
  }

  _setAllUseListing() {
    return chatController.chatListing.isNotEmpty
        ? ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: chatController.chatListing.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed("/ChatDetails", arguments: [
                    chatController.chatListing[index].appUserId.toString(),
                    '',
                    '${chatController.chatListing[index].firstName} ${chatController.chatListing[index].lastName}',
                  ]);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: AppColor.loginappbar,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              child: Image.asset(
                                'assets/chatimg.png',
                                //scale: 2.9,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 43, left: 45),
                              child: Image.asset(
                                'assets/active.png',
                                scale: 2.9,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${chatController.chatListing[index].firstName} ${chatController.chatListing[index].lastName}',
                                  style: TextStyle(
                                      color: AppColor.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                SizedBox(height: 5,),
                                _setLastMsg(chatController.chatListing[index].appUserId),
                              ],
                            ),
                          ),
                        ),
                        setUnreadCount(chatController.chatListing[index].appUserId)
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 10,
              );
            },
          )
        : Center(
            child: const Text(
              'No results found',
              style: TextStyle(fontSize: 24),
            ),
          );
  }

  _setChatListing() {
    return StreamBuilder<QuerySnapshot>(
      stream: getChatList(
          10),
        builder:(BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasData) {
            return ((snapshot.data?.docs.length ?? 0) > 0)
                ? ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, index) {
                return chatListingView(snapshot.data?.docs[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10,
                );
              },
            )
                : Center(
              child: const Text(
                'No results found',
                style: TextStyle(fontSize: 18, color: AppColor.white),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.primarycolor,
              ),
            );
          }
        });

  }

  Stream<QuerySnapshot>? getChatList(int limit) {

    return firebaseFirestore.collection(FirestoreConstants.chatList)
        .doc(GlobalData().userId.toString())
        .collection(GlobalData().userId.toString())
        .limit(limit)
        .orderBy(FirestoreConstants.timeStampChat, descending: true)
        .snapshots();

  }

  chatListingView( DocumentSnapshot? document) {
    if(document != null){
      UserChat userChat = UserChat.fromDocument(document);
      return GestureDetector(
        onTap: () {
          Get.toNamed("/ChatDetails", arguments: [
            userChat.id.toString(),
            '',
            userChat.name,
          ]
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: AppColor.loginappbar,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Image.asset(
                        'assets/chatimg.png',
                        //scale: 2.9,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 43, left: 45),
                      child: Image.asset(
                        'assets/active.png',
                        scale: 2.9,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    margin:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userChat.name ?? '',
                          style: TextStyle(
                              color: AppColor.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            userChat.message??'',
                            style: TextStyle(
                              color: AppColor.lightgrey,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: userChat.unreadCount != null &&
                      userChat.unreadCount.toString() != "0" &&
                      userChat.unreadCount.toString().isNotEmpty,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    padding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColor.lightgrey,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            userChat.unreadCount.toString() ?? '',
                            style: TextStyle(
                                color: AppColor.white, fontSize: 16),
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
    else{
      return Container();
    }
  }

  void getCurrentId() async {
    await GlobalData().retrieveLoggedInUserDetail();
  }

   _setLastMsg(int? appUserId)  {
    return FutureBuilder(
      future: getUserChat(appUserId),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> text) {
        if (text.data?.data() == null) {
          return SizedBox.shrink();
        } else {
          return Text(
            text.data?[FirestoreConstants.message],
            style: TextStyle(
              color: AppColor.lightgrey,
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
          );
        }
      },
    );
  }
  setUnreadCount(int? appUserId) {
    return FutureBuilder(
      future: getUserChat(appUserId),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> text) {
        if (text.data?.data() == null ||
            text.data?[FirestoreConstants.unreadCount] == 0) {
          return SizedBox.shrink();
        } else {
          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: 10, vertical: 10),
            padding:
            EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColor.lightgrey,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    text.data?[FirestoreConstants.unreadCount].toString() ??'',
                    style: TextStyle(
                        color: AppColor.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<DocumentSnapshot>? getUserChat(int? appUserId) {
    return firebaseFirestore
        .collection(FirestoreConstants.chatList)
        .doc(GlobalData().userId.toString())
        .collection(GlobalData().userId.toString())
        .doc(appUserId.toString())
        .get();
  }
}
