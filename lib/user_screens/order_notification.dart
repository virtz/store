import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';



class OrderNotification extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderNotificationState();
  }
}

class _OrderNotificationState extends State<OrderNotification> {
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  String textValue = 'Notification';
  // FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    // flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    // var android =  new AndroidInitializationSettings('@mipmap/ic_launcher');
    // var ios = new IOSInitializationSettings();
    // var initSettings = new InitializationSettings(android, ios);
    // Future onSelectNotification(String payload) async {
    //       debugPrint("payload :$payload");
    //       showDialog(context:context,builder: (_)=> AlertDialog(
    //         title: Text('Notification'),
    //         content: Text('$payload'),
    //       ));
    //     }
    //     flutterLocalNotificationsPlugin.initialize(initSettings,onSelectNotification:onSelectNotification);
    //  firebaseMessaging.configure(
    //    onLaunch:(Map<String,dynamic> msg){
    //      print(" Onlaunch called : You have a new notification");

    //    },
    //    onResume: (Map<String,dynamic> msg){
    //      print("OnResume called : You have a new notification");
    //    },
    //    onMessage: (Map<String,dynamic> msg){
    //      print("onMessage called: You have a new notification");
    //    },
       
       
    //  );
    //  firebaseMessaging.requestNotificationPermissions(
    //    const IosNotificationSettings(
    //      sound:true,
    //      alert:true,
    //      badge:true,
    //    )
    //  );
    // firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings){
    //   print('IOS Settings Registered');
    // });
    // firebaseMessaging.getToken().then((token){
    //   update(token);
    // });
  }
  update(String token){
    print(token);
    textValue =token;
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
        ),
        body: Center(
        child: Text(
          //   onPressed: (){
          //     showNotification();
          //   },
            textValue,
            style: TextStyle(fontSize: 20.0),
          ),
        ));
  }
  showNotification()async{
    // var android = new AndroidNotificationDetails('channelId', 'channelName', 'channelDescription');
    // var ios = new IOSNotificationDetails();
    // var platform = new NotificationDetails(android, ios);
    // await flutterLocalNotificationsPlugin.show(0,'Your Order has being processed','flutter local notification',platform,payload: '');
  }
}
