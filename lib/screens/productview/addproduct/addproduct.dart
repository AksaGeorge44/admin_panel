//import 'dart:html';
import 'dart:io';

import 'package:admin_panel/constants/constants.dart';
import 'package:admin_panel/models/categorymodel/categorymodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../provider/provider.dart';

class AddProduct extends StatefulWidget {


  const AddProduct({super.key,});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

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
CategoryModel? _selectedCategory;
String? _selectedValue;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider=Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Add",style: TextStyle(color: Colors.black),),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        children: [
          image==null
      ?  CupertinoButton(
            onPressed: (){
              takePicture();

            },
            child: const CircleAvatar(
              radius: 70,
              child: Icon(Icons.camera_alt),
            ),
          )

              :CupertinoButton(
              child: CircleAvatar(
            backgroundImage: FileImage(image!),
          ),

              onPressed: (){
                takePicture();
              }),
          const SizedBox(height: 20,),
          TextFormField(
            controller: name,
            decoration: InputDecoration(
              hintText: "Product Name",
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
              hintText: "Product Description",
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
              hintText: "\$ Product Price",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              // hintText: appProvider.getUserInformation.name,
            ),
          ),
               SizedBox(height: 24,),
               Theme(
              data: Theme.of(context).copyWith(
    canvasColor: Colors.white,
    ),

                 child: DropdownButtonFormField(
                  value: _selectedCategory,
    hint: const Text(
    'please select category',
    ),

    isExpanded: true,
    onChanged: (value) {
    setState(() {
    _selectedCategory = value;
    });
    },


    items: appProvider.getCategories
        .map((CategoryModel val) {
    return DropdownMenuItem(
    value: val,
    child: Text(
    val.name,
    ),
    );
    }).toList(),
    ),
               ),

           const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(8),


            child: ElevatedButton(
                child: const Text("Add"),
                onPressed: ()async {
                  if(image==null ||
                  _selectedCategory==null ||
                  name.text.isEmpty || description.text.isEmpty || price.text.isEmpty){

                 showMessage("Please fill all information");
                  }
                  else  {

                    appProvider.addProduct(image!,name.text,_selectedCategory!.id,price.text,description.text);
                    showMessage("Update Successfully");
                  }


                  //  appProvider.updateProductList(widget.index, productModel);


                    showMessage("Update Successfully");
                  }


            ),
  ),
  ],
      ),
    );
  }
}
