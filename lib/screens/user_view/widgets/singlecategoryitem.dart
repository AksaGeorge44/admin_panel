import 'package:admin_panel/models/categorymodel/categorymodel.dart';
import 'package:admin_panel/screens/categoryview/editcategory/editcategory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/routes.dart';
import '../../../provider/provider.dart';

class SingleCategoryItem extends StatefulWidget {
  final CategoryModel singleCategory;
  final int index;
  const SingleCategoryItem({super.key, required this.singleCategory, required this.index});

  @override
  State<SingleCategoryItem> createState() => _SingleCategoryItemState();
}

class _SingleCategoryItemState extends State<SingleCategoryItem> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    AppProviderr appProviderr=Provider.of<AppProviderr>(
      context,
    );
    return Card(
      color: Colors.white,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              child: Image.network(widget.singleCategory.image,
                scale: 8,
              ),
            ),
          ),

          Positioned(
            right:0.0,
            child: Row(
              children: [
                IgnorePointer(
                  ignoring: isLoading,
                  child: GestureDetector(
                    onTap: ()async {
                      setState(() {
                        isLoading=true;
                      });

                   await   appProviderr.deleteCategoryFromFirebase(widget.singleCategory);
                      setState(() {
                        isLoading=false;
                      });
                    },
                    child:isLoading?const Center(child: CircularProgressIndicator(),)
                        : const Icon(Icons.delete,color: Colors.red,),
                  ),
                ),
                const SizedBox(width: 12,),
                GestureDetector(
                  onTap: (){
                    Routes.instance.push(widget: EditCategory(categoryModel: widget.singleCategory, index: widget.index), context: context);
                  },
                  child: const Icon(Icons.edit),
                ),
                const SizedBox(width: 12.0,),


              ],
            ),
          )

        ],
      ),

    );
  }
}
