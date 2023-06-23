//import 'dart:html';
import 'dart:io';

import 'package:admin_panel/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../provider/provider.dart';

class AddCategory extends StatefulWidget {

  const AddCategory({super.key,});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController name=TextEditingController();
  File?image;

  void takePicture()async{
    XFile?value= await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 40);

    if(value!=null){
      setState(() {
        image= File(value.path);
      });

    }

  }
  //TextEditingController name=TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProviderr appProviderr=Provider.of<AppProviderr>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category Add",style: TextStyle(color: Colors.black),),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        children: [
          image==null?
          CupertinoButton(
            onPressed: (){
              takePicture();

            },
            child:const CircleAvatar(
                radius: 70,
                child:
                Icon(Icons.camera_alt)),)
              : CupertinoButton(
            onPressed: (){
              takePicture();

            },
            child: CircleAvatar(
              backgroundImage:FileImage(image!),
              radius: 70,
            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                hintText: "Category Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                // hintText: appProvider.getUserInformation.name,
              ),
            ),
          ),

          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8),


            child: ElevatedButton(
                child: Text("Add"),
                onPressed: ()async {
                  if(image==null && name.text.isEmpty){
                    Navigator.of(context).pop();
                  }
                  else if (image != null && name.text.isNotEmpty) {

                    appProviderr.addCategory(image!,name.text);
                    showMessage("Successfully Added");
                  }


                }

            ),
          ),

        ],
      ),

    );
  }
}
