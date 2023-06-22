import 'package:admin_panel/screens/productview/editproduct/editproduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/routes.dart';
import '../../../models/productmodel/productmodel.dart';
import '../../../provider/provider.dart';

class SingleProductView extends StatefulWidget {
  const SingleProductView({super.key, required this.singleProduct, required this.index});
  final ProductModel singleProduct;
  final int index;

  @override
  State<SingleProductView> createState() => _SingleProductViewState();
}

class _SingleProductViewState extends State<SingleProductView> {
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider=Provider.of<AppProvider>(
      context,
    );

    return Card(
      elevation: 0.0,
        color: Colors.white.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
       //   border: Border.all(color: Colors.blue),

        ),

      child: Stack(
       // alignment: Alignment.topRight,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(widget.singleProduct.image,height: 100,width: 100,),
                // const SizedBox(height: 25,),
                Text(
                  widget.singleProduct.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20,),
                Row(crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 15,),
                    Text("M.R.P: \$${widget.singleProduct.price}"),
                  ],
                ),

              ],
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
                      await   appProvider.deleteProductsFromFirebase(widget.singleProduct);
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
                    Routes.instance.push(
                        widget: EditProduct(
                        productModel: widget.singleProduct,
                        index: widget.index),
                        context: context);

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

