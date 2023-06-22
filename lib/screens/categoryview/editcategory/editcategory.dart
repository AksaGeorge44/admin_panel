//import 'dart:html';
import 'dart:io';

import 'package:admin_panel/constants/constants.dart';
import 'package:admin_panel/helpers/firebasestoragehelper/firebasestoragehelper.dart';
import 'package:admin_panel/models/categorymodel/categorymodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../provider/provider.dart';

class EditCategory extends StatefulWidget {
  final CategoryModel categoryModel;
  final int index;

  const EditCategory({super.key, required this.categoryModel, required this.index});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
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
    AppProvider appProvider=Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category Edit",style: TextStyle(color: Colors.black),),
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
                hintText: widget.categoryModel.name,
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
                child: const Text("Update"),
                onPressed: ()async {
                  if(image==null && name.text.isEmpty){
                    Navigator.of(context).pop();
                  }
                  else if (image != null) {
                    String imageUrl=await  FirebaseStorageHelper.instance.uploadUserImage(widget.categoryModel.id,image!);
                    CategoryModel categoryModel = widget.categoryModel.copyWith(
                      image: imageUrl,
                      name: name.text.isEmpty?null:name.text,
                    );
                    appProvider.updateCategoryList(widget.index,categoryModel);
                    showMessage("Update Successfully");
                  }
                  else{
                    CategoryModel categoryModel = widget.categoryModel.copyWith(
                      name: name.text.isEmpty?null:name.text,
                    );
                    appProvider.updateCategoryList(widget.index,categoryModel);
                    showMessage("Update Successfully");
                  }


                }

            ),
          ),

        ],
      ),

    );
  }
}
