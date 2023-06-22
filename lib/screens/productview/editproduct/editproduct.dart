//import 'dart:html';
import 'dart:io';

import 'package:admin_panel/constants/constants.dart';
import 'package:admin_panel/helpers/firebasestoragehelper/firebasestoragehelper.dart';
import 'package:admin_panel/models/categorymodel/categorymodel.dart';
import 'package:admin_panel/models/productmodel/productmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../provider/provider.dart';

class EditProduct extends StatefulWidget {
  final ProductModel productModel;
  final int index;

  const EditProduct({super.key, required this.productModel, required this.index});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {

  File?image;

  void takePicture()async{
    XFile?value= await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 40);

    if(value!=null){
      setState(() {
        image= File(value.path);
      });

    }

  }
  TextEditingController name=TextEditingController();
  TextEditingController description=TextEditingController();
  TextEditingController price=TextEditingController();


  @override
  Widget build(BuildContext context) {
    AppProvider appProvider=Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Edit",style: TextStyle(color: Colors.black),),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        children: [
          image==null?
         widget.productModel.image.isNotEmpty?
         CupertinoButton(
            onPressed: (){
              takePicture();

            },
            child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(widget.productModel.image),

                ),)
              : CupertinoButton(
            onPressed: (){
              takePicture();

            },
            child: const CircleAvatar(

              radius: 70,
              child: Icon(Icons.camera_alt),
            ),
          )
          :CupertinoButton(child: CircleAvatar(
            backgroundImage: FileImage(image!),
          ),

              onPressed: (){
            takePicture();
              }),
          const SizedBox(height: 20,),
          TextFormField(
            controller: name,
            decoration: InputDecoration(
              hintText: widget.productModel.name,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              // hintText: appProvider.getUserInformation.name,
            ),
          ),
          const SizedBox(height: 24,),
          TextFormField(
            controller: description,
            maxLines: 9,
            decoration: InputDecoration(
              hintText: widget.productModel.description,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              // hintText: appProvider.getUserInformation.name,
            ),
          ),
          const SizedBox(height: 24,),
          TextFormField(
            controller: price,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "\$${widget.productModel.price.toString()}",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              // hintText: appProvider.getUserInformation.name,
            ),
          ),

          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8),


            child: ElevatedButton(
                child: const Text("Update"),
                onPressed: ()async {
                  if(image==null && name.text.isEmpty && description.text.isEmpty && price.text.isEmpty){
                    Navigator.of(context).pop();
                  }
                  else if (image != null) {
                    String imageUrl=await
                    FirebaseStorageHelper.instance.uploadUserImage(widget.productModel.id,image!);
                    ProductModel productModel=widget.productModel.copyWith(
                      description:description.text.isEmpty?null:description.text,
                      image:imageUrl,
                      name: name.text.isEmpty?null:name.text,
                      price: price.text.isEmpty?null:price.text,

                    );

                    appProvider.updateProductList(widget.index, productModel);
                    showMessage("Update Successfully");
                  }
                  else{
                    ProductModel productModel=widget.productModel.copyWith(
                      description:description.text.isEmpty?null:description.text,

                      name: name.text.isEmpty?null:name.text,
                      price: price.text.isEmpty?null:price.text,

                    );

                    appProvider.updateProductList(widget.index, productModel);


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
