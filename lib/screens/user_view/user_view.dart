import 'package:admin_panel/models/usermodel/usermodel.dart';
import 'package:admin_panel/provider/provider.dart';
import 'package:admin_panel/screens/user_view/widgets/singleusercard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    AppProviderr appProviderr=Provider.of<AppProviderr>(context);

    return Scaffold(

      appBar: AppBar(
        title: const Text("User View"),
      ),
      body: Consumer<AppProviderr>(

          builder:(context,value,child){
            return ListView.builder(
                itemCount: value.getUserList.length,
                padding: const EdgeInsets.all(12),
                itemBuilder: (context,index){
                  UserModel userModel =value.getUserList[index];
                  return SingleUserCard(userModel: userModel,index: index);

            });

      }),
    );
  }
}
