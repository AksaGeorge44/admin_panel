import 'package:admin_panel/provider/provider.dart';
import 'package:admin_panel/screens/categoryview/addcategory.dart';
import 'package:admin_panel/screens/user_view/widgets/singlecategoryitem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../models/categorymodel/categorymodel.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    AppProviderr appProviderr=Provider.of<AppProviderr>(context);

    return Scaffold(

      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Routes.instance.push(widget: const AddCategory(), context: context);
            
          }, icon: const Icon(Icons.add_circle)),
        ],
        title: const Text("Categories View"),
      ),
      body: Consumer<AppProviderr>(

          builder:(context,value,child){
            return Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Categories",style: TextStyle(fontSize: 24),),
                    const SizedBox(height: 12,),
                    GridView.builder(
                      shrinkWrap: true,
                        primary: false,
                        itemCount: value.getCategories.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        padding: const EdgeInsets.all(12),
                        itemBuilder: (context,index){
                          CategoryModel categoryModel =value.getCategories[index];
                          return SingleCategoryItem(singleCategory: categoryModel,index: index,);


                        },
                    ),
                  ],
                ),
              ),
            );

          }),
    );
  }
}
