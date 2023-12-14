import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_council/colors.dart';
import 'package:luxury_council/constance/global_data.dart';

import '../constance/firestore_constants.dart';
import '../models/chat/chatlist.dart';
import '../models/chat/message_chat.dart';
import 'package:http/http.dart' as http;

class ChatDetails extends StatefulWidget {
  final String peerId;
  final String peerImage;
  final String peerNickname;

  const ChatDetails(
      {super.key,
      required this.peerId,
      required this.peerImage,
      required this.peerNickname});

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  String? currentUserId;
  String? currentUserName;
  String groupChatId = "";
  FirebaseFirestore firebaseFirestore =FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> listMessage = [];

  Offset _tapPosition = Offset.infinite;

  void _showContextMenu(BuildContext context) async {
    final RenderObject? overlay =
        Overlay.of(context)?.context.findRenderObject();

    final result = await showMenu(
        context: context,
        position: RelativeRect.fromRect(
            Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 100, 100),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
                overlay!.paintBounds.size.height)),
        items: [
          const PopupMenuItem(
            child: Text('Delete'),
            value: "fav",
          ),
          const PopupMenuItem(
            child: Text('Copy'),
            value: "close",
          )
        ]);
    // perform action on selected menu item
    switch (result) {
      case 'fav':
        print("fav");
        break;
      case 'close':
        print('close');
        Navigator.pop(context);
        break;
    }
  }

  TextEditingController typeController = TextEditingController();

  @override
  void initState() {
    readLocal();
    _updateUnreadCount();
    super.initState();
  }

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
          widget.peerNickname,
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
              Container(
                margin: EdgeInsets.only(right: 8),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(
                    "assets/dotmenu.png",
                    scale: 2.9,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: buildListMessage()),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding:
                  EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 10),
              height: 80,
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      child: TextField(
                        controller: typeController,
                        style: TextStyle(color: AppColor.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColor.appbar,
                          hintText: "Type Something here...",
                          hintStyle: TextStyle(color: AppColor.darkgrey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: AppColor.primarycolor),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FloatingActionButton(
                    shape: CircleBorder(),
                    onPressed: () {
                      setState(() {
                        onSendMessage(typeController.text.toString());
                        typeController.clear();
                      });
                    },
                    child: Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.black,
                      size: 35,
                    ),
                    backgroundColor: AppColor.primarycolor,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void readLocal() {
    currentUserId = GlobalData().userId.toString();
    currentUserName = '${GlobalData().firstName} ${GlobalData().lastName}';

    int oppId = int.parse(widget.peerId);

    if (GlobalData().userId > oppId) {
      groupChatId = '$currentUserId-${widget.peerId}';
    } else {
      groupChatId = '${widget.peerId}-$currentUserId';
    }
    /* chatProvider?.updateDataFirestore(
      FirestoreConstants.pathUserCollection,
      currentUserId ?? '',
      {FirestoreConstants.chattingWith: peerId},
    );*/
  }
  Future<void> _checkNewMsg(int index) async {
    /*if (index == 0 && firstVisibleItemIndex < 1) {
      updateReadValue(false);
    }*/
    firebaseFirestore.collection(FirestoreConstants.chatList)
        .doc(currentUserId)
        .collection(currentUserId ??'')
        .doc(widget.peerId)
        .update({FirestoreConstants.unreadCount: 0});
  }
  void onSendMessage(String message) async {
    sendPush(message);
    DocumentSnapshot? snapChat = await firebaseFirestore
        .collection(FirestoreConstants.chatList)
        .doc(widget.peerId)
        .collection(widget.peerId)
        .doc(currentUserId ?? '')
        .get();
    int unreadCount = 0;
    if (snapChat.data() != null) {
      unreadCount = snapChat[FirestoreConstants.unreadCount];
    }
    unreadCount = unreadCount+1;
    String timeStamp=DateTime.now().millisecondsSinceEpoch.toString();

    DocumentReference documentReference = firebaseFirestore
    .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(timeStamp);

    MessageChat messageChat = MessageChat(
        idFrom: currentUserId,
        idTo: widget.peerId,
        timestamp:timeStamp,
        content: message,
        type: 0,
    );

    firebaseFirestore.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        messageChat.toJson(),
      );
    });

    ChatList sender = ChatList(
        id: currentUserId,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        message: message,
        name: currentUserName,
        groupId: groupChatId,
        myId: widget.peerId,
        photoUrl: '',
        unreadCount: unreadCount);

    firebaseFirestore
        .collection(FirestoreConstants.chatList)
        .doc(widget.peerId)
        .collection(widget.peerId)
        .doc(currentUserId)
        .set(sender.toJson());

    ChatList receiver = ChatList(
        id: widget.peerId,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        message: message,
        name: widget.peerNickname,
        groupId: groupChatId,
        myId: currentUserId,
        photoUrl: widget.peerImage,
        unreadCount: 0);

    firebaseFirestore
        .collection(FirestoreConstants.chatList)
        .doc(currentUserId)
        .collection(currentUserId.toString())
        .doc(widget.peerId)
        .set(receiver.toJson());
  }

  buildListMessage() {
    return groupChatId.isNotEmpty ?
    StreamBuilder<QuerySnapshot>(
      stream: getChatStream(20),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // print('Snapshot::$snapshot');
        if (snapshot.hasData) {
         /* if (firstVisibleItemIndex > 0 &&
              listMessage[0].get(FirestoreConstants.content) !=
                  snapshot.data?.docs[0]
                      .get(FirestoreConstants.content)) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {});
            });
          }*/
          listMessage = snapshot.data?.docs ?? [];
          if (listMessage.length > 0) {
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              reverse: true,
              physics: ClampingScrollPhysics(),
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, index) {
                return _buildItem(index, snapshot.data?.docs[index]);
              },
              separatorBuilder: (context, index) {
                return SizedBox();
              },
            );
          } else {
            return Center(child: Text("No message here yet..."));
          }
        } else {
          return Center(
              child: CircularProgressIndicator(
                color: AppColor.primarycolor,
              ));
        }
      },
    ) : Container();
  }

  Stream<QuerySnapshot>? getChatStream(int limit,) {
    // print('newGrpId::${groupChatId}');
    // if(groupChatId.isEmpty){
    //   groupChatId = currentUserId+'-'+peerid;
    // }
    print('newGrpId::${groupChatId}');
    return firebaseFirestore.collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }

  Widget _buildItem(int index, DocumentSnapshot? document) {
    if(document != null){
    MessageChat messageChat = MessageChat.fromDocument(document);
    _checkNewMsg(index);
      return GestureDetector(
        onLongPress: () {
          setState(() {
            _showContextMenu(context);
          });
        },
        child: Container(
            padding: EdgeInsets.only(
                left: messageChat.idTo == currentUserId
                    ? 14
                    : 50,
                right: messageChat.idTo == currentUserId
                    ? 50
                    : 14,
                top: 10,
                bottom: 10),
            child: Align(
              alignment: (messageChat.idTo == currentUserId
                  ? Alignment.topLeft
                  : Alignment.topRight),
              child: Row(
                crossAxisAlignment:
                messageChat.idTo == currentUserId
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                mainAxisAlignment:
                messageChat.idTo == currentUserId
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: [
                  messageChat.idTo == currentUserId
                      ? CircleAvatar(
                    radius: 17,
                    child: Image.asset(
                      'assets/chatimg.png',
                    ),
                  )
                      : SizedBox(),
                  SizedBox(
                    width: 7,
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7),
                      color:
                      (messageChat.idTo == currentUserId
                          ? AppColor.black
                          : AppColor.primarycolor),
                      child: Text(
                        messageChat.content ?? '',
                        style: TextStyle(
                            fontSize: 15, color: AppColor.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  messageChat.idFrom == currentUserId
                      ? CircleAvatar(
                    radius: 17,
                    child: Image.asset(
                      'assets/chatimg.png',
                    ),
                  )
                      : SizedBox(),
                ],
              ),
            )),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  void sendPush(String content, ) async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection(FirestoreConstants.pathUserCollection)
        .doc(widget.peerId)
        .get();
    String token = snap[FirestoreConstants.deviceToken];

    await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
          'key=AAAAstZB1mY:APA91bEd2LfKwZIJCsdJSdde7v_Sg-9bsakjqNaPaOW-TBEKSmzrS087x2B-Zhc4rndr8Ubu7mKUNOiKVe1VsvVkIEfpRpSKG5V9nS-a7wjzWQaCtX8RcuPRZhbpEmUAeOLN7z9MeCPx'
        },
        body: jsonEncode(<String, dynamic>{
          'priority': 'high',
          'data': <String, dynamic>{
            'status': 'done',
            'body': content,
            'title': currentUserName,
            'peerId': currentUserId,
            'peerAvatar': '',
            'peerNickname': currentUserName,
            'grpId': groupChatId,
          },
          'notification': <String, dynamic>{
            'body': content,
            'title': currentUserName,
            'android_channel_id': "high_importance_channel"
          },
          "to": token
        }));
  }

  void _updateUnreadCount() async{
    DocumentSnapshot? snapshot = await firebaseFirestore
        .collection(FirestoreConstants.chatList)
        .doc(currentUserId ?? '')
        .collection(currentUserId ?? '')
        .doc(widget.peerId)
        .get();
    if(snapshot.data()!= null){
      firebaseFirestore
          .collection(FirestoreConstants.chatList)
          .doc(currentUserId ?? '')
          .collection(currentUserId ?? '')
          .doc(widget.peerId)
          .update(
          {FirestoreConstants.unreadCount:0});
    }
  }

}
