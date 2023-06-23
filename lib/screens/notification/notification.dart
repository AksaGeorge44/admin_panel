import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';

class NotificatonScreen extends StatefulWidget {
  const NotificatonScreen({super.key});

  @override
  State<NotificatonScreen> createState() => _NotificatonScreenState();
}

class _NotificatonScreenState extends State<NotificatonScreen> {
 final TextEditingController _title=TextEditingController();
  final TextEditingController _body=TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProviderr appProviderr=Provider.of<AppProviderr>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _title,
              decoration: const InputDecoration(
                hintText: "Notification Title"
              ),
            ),

            const SizedBox(height: 12,),
            TextFormField(
              controller: _body,
              decoration: const InputDecoration(
                  hintText: "Notification Body"
              ),
            ),
            const SizedBox(height: 12,),
            ElevatedButton(onPressed: (){

              sendNotificatonToAllUsers(appProviderr.getUsersToken);
            }, child: const Text("Send Notification!")),
          ],
        ),
      ),
    );
  }
}


Future<void>sendNotificatonToAllUsers(List<String?>usersToken)async {
  const String serverKey='';
      String firebaseUrl='';

  final Map<String,String>headers={
    'Content-Type':'application/json',
    'Authorization':'key=$serverKey',
  };
  final Map<String,dynamic>notification={
    'title':'Notification Title',
    'body':'Notification Body',
  };
  final Map<String,dynamic>reqestBody={
    'notification':notification,
    'priority':'high',
    'registration_ids':usersToken,
  };
final String encodedBody=jsonEncode(reqestBody);

final http.Response response = await http.post(
  Uri.parse(firebaseUrl),
  headers:headers,
  body:encodedBody,
);
if(response.statusCode==200){
  print("Notification sent Successfully");
}
else{
  print("Notification Sending failed with status:${response.statusCode}");
}


}