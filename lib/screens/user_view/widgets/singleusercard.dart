import 'package:admin_panel/provider/provider.dart';
import 'package:admin_panel/screens/user_view/edituser/edituser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/routes.dart';
import '../../../models/usermodel/usermodel.dart';

class SingleUserCard extends StatefulWidget {
  final UserModel userModel;
  final int index;

  const SingleUserCard({super.key, required this.userModel, required this.index});

  @override
  State<SingleUserCard> createState() => _SingleUserCardState();
}

class _SingleUserCardState extends State<SingleUserCard> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    AppProviderr appProviderr=Provider.of<AppProviderr>(context);

    return Card(
    child: Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
    children: [
       widget.userModel.image!=null?
       CircleAvatar(
         backgroundImage: NetworkImage(widget.userModel.image!),

       )

        :const CircleAvatar(
    child: Icon(Icons.person),
    ),
    const SizedBox(
    width: 12,
    ),
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

    Text(widget.userModel.name),
    Text(widget.userModel.email),
    ],
    ),
   // const Spacer(),
       isLoading? const CircularProgressIndicator():
       GestureDetector(onTap: ()async{
        setState(() {
       isLoading=true;

       });
        await appProviderr.deleteUserFromFirebase(widget.userModel);
         setState(() {
         isLoading=false;

                });
           }
           ,child:  const Icon(Icons.delete,color: Colors.red,)),
             const SizedBox(width: 6,),

              GestureDetector(
              onTap: ()async{
              Routes.instance.push(widget: EditUser(index:widget.index,userModel:widget.userModel),
              context: context);
           },
                  child: const Icon(Icons.edit,color: Colors.black,)),



    ],
),
),
);
  }
}


