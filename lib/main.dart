import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:luxury_council/screens/aboutus.dart';
import 'package:luxury_council/screens/articlevideoaudiodetails.dart';
import 'package:luxury_council/screens/articlevideoimagedetails.dart';
import 'package:luxury_council/screens/chatdetails.dart';
import 'package:luxury_council/screens/checkout.dart';
import 'package:luxury_council/screens/companylist.dart';
import 'package:luxury_council/screens/contactus.dart';
import 'package:luxury_council/screens/editprofile.dart';
import 'package:luxury_council/screens/eventdetails.dart';
import 'package:luxury_council/screens/events.dart';
import 'package:luxury_council/screens/homewithoutsignup.dart';
import 'package:luxury_council/screens/login.dart';
import 'package:luxury_council/screens/payment.dart';
import 'package:luxury_council/screens/profile.dart';
import 'package:luxury_council/screens/rating.dart';
import 'package:luxury_council/screens/register.dart';
import 'package:luxury_council/screens/searchpage.dart';
import 'package:luxury_council/screens/spotlightlisting.dart';
import 'package:luxury_council/screens/spotlightmember.dart';
import 'package:luxury_council/screens/subscription.dart';
import 'package:luxury_council/splash_screen.dart';

import 'constance/global_data.dart';
import 'notification/notification_handler.dart';
import 'screens/chats.dart';
import 'screens/digest.dart';
import 'screens/favouritepage.dart';
import 'screens/groupsubscription.dart';
import 'screens/homewithsignup.dart';
import 'screens/pay.dart';
import 'package:permission_handler/permission_handler.dart';
void main() async{
  // Initialize Firebase.
  
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then((value) {
        if (value) {
          Permission.notification.request();
        }
      });
  await Firebase.initializeApp();
  await GlobalData().retrieveLoggedInUserDetail();
  var pushNotificationsHandler = FirebasePushNotificationsHandler();
  pushNotificationsHandler.registerNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Luxury Council',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => SplashScreen()),
          GetPage(name: '/Login', page: () => Login()),
          GetPage(name: '/Register', page: () => Register()),
          GetPage(name: '/HomeWithoutSignUp', page: () => HomeWithoutSignUp()),
          GetPage(name: '/HomeWithSignUp', page: () => HomeWithSignUp()),
          GetPage(
              name: '/ArticleVideoAudioDetails',
              page: () => ArticleVideoAudioDetails()),
          GetPage(
              name: '/ArticleVideoImageDetails', 
              page: () => ArticleVideoImageDetails()),
          GetPage(name: '/Events', page: () => Events()),
          GetPage(name: '/EventDetails', page: () => EventDetails()),
          GetPage(name: '/Profile', page: () => Profile()),
          GetPage(name: '/Subscription', page: () => Subscription()),
          GetPage(name: '/CheckOut', page: () => CheckOut(
            content: Get.arguments[0],
            plan: Get.arguments[1],
            
          )),
          GetPage(name: '/Payment', page: () => Payment()),
          GetPage(name: '/AboutUs', page: () => AboutUs()),
          GetPage(name: '/ContactUs', page: () => ContactUs()),
          GetPage(name: '/GroupSubscription', page: () => GroupSubscription()),
          GetPage(name: '/SpotlightMember', page: () => SpotlightMember(
            memberId: Get.arguments[0],
          )),
          GetPage(name: '/SpotlightListing', page: () => SpotlightListing()),
           GetPage(name: '/Digest', page: () => Digest()),
           GetPage(name: '/Chats', page: () => Chats()),
           GetPage(name: '/SearchPage', page: () => SearchPage()),
           GetPage(name: '/ChatDetails', page: () => ChatDetails(
             peerId: Get.arguments[0],
             peerImage: Get.arguments[1],
             peerNickname: Get.arguments[2],
           )),
           GetPage(name: '/EditProfile', page: () => EditProfile()),
            GetPage(name: '/FavouritePage', page: () => FavouritePage()),
             GetPage(name: '/PayScreen', page: () => PayScreen(plan: Get.arguments[0],)),
    
    
          GetPage(
              name: '/RatingAndReviewScreen',
              page: () => RatingAndReviewScreen()),
              GetPage(name: '/CompanyList', page: () => CompanyList()),
        ],
        home: SplashScreen(),
      ),
    );
  }
}
