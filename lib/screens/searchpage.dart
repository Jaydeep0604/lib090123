import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luxury_council/colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Map<String, dynamic>> _allUsers = [
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
  ];

  List<Map<String, dynamic>> _foundUsers = [];

  @override
  initState() {
    _foundUsers = _allUsers;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()) || user["description"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appbar,
        bottomOpacity: 1.0,
        elevation: 4,
        leadingWidth: 30,
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
          Container(
            margin: EdgeInsets.only(right: 20, top: 3),
            width: 300,
            height: 40,
            child: Center(
              child: TextField(
                autofocus: true,
                style: TextStyle(color: AppColor.white),
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: AppColor.white),
                    border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
      body:_foundUsers.isNotEmpty? ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: _foundUsers.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(key: ValueKey(_foundUsers[index]["id"]),
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
                             _foundUsers[index]["profile"].toString(),
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              _foundUsers[index]["name"].toString(),
                              style: TextStyle(
                                  color: AppColor.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: 200,
                            child: Text(
                               _foundUsers[index]["description"].toString(),
                              style: TextStyle(
                                color: AppColor.lightgrey,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                              '5',
                              style: TextStyle(
                                  color: AppColor.white, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )
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
      ):Center(
        child: const Text(
                        'No results found',
                        style: TextStyle(fontSize: 24),
                      ),
      ),

    );
  }
}
