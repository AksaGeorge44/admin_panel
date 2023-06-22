import 'package:admin_panel/provider/provider.dart';
import 'package:admin_panel/screens/productview/addproduct/addproduct.dart';
import 'package:admin_panel/screens/productview/widgets/singleproductview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../models/productmodel/productmodel.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider=Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Routes.instance.push(widget: const AddProduct(), context: context);

          }, icon: const Icon(Icons.add_circle)),
        ],
        title: const Text("Products View"),
      ),


      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Products",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              const SizedBox(height: 24,),
              GridView.builder(
                shrinkWrap: true,
                itemCount: appProvider.getProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.9,
                    crossAxisCount: 2),

                itemBuilder: (ctx,index){
                  ProductModel singleProduct= appProvider.getProducts[index];
                  return  SingleProductView(singleProduct:singleProduct,index: index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

