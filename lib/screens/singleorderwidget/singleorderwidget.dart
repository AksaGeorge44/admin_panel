import 'package:admin_panel/models/ordermodel/ordermodel.dart';
import 'package:admin_panel/provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/firebase_firestore_helper/firebase_firestore_helper.dart';

class SingleOrderWidget extends StatefulWidget {
 final OrderModel orderModel;
  const SingleOrderWidget({super.key, required this.orderModel});

  @override
  State<SingleOrderWidget> createState() => _SingleOrderWidgetState();
}

class _SingleOrderWidgetState extends State<SingleOrderWidget> {
  @override
  Widget build(BuildContext context) {
    AppProviderr appProviderr=Provider.of<AppProviderr>(context);
    return Padding(
      padding:
      const EdgeInsets.only(left: 12.0, top: 6.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Container(
                height: 80,
                width: 80,
                color:Theme.of(context).primaryColor.withOpacity(0.5),
                child: Image.network(
                  widget.orderModel.products[0].image,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.orderModel.products[0].name,
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Column(
                      children: [
                        Text(
                          "Quantity: ${widget.orderModel.products[0].qty.toString()}",
                          style: const TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                      ],
                    ),
                    Text(
                      "Price: \$${widget.orderModel.totalPrice.toString()}",
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      "Order status: \$${widget.orderModel.status}",
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(height: 12,),

                  widget.orderModel.status=="Pending"?  CupertinoButton(
                      onPressed: ()async{

                     await   FirebaseFirestoreHelper.instance.updateOrder(widget.orderModel,"Delivery");
                     widget.orderModel.status="Delivery";
                     appProviderr.updatePendingOrder(widget.orderModel);
                     setState(() {

                     });

                      },
                      padding: EdgeInsets.zero,
                      child: Container(
                        height: 48,
                        width: 150,

                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text("Send to Delivery",style: TextStyle(color: Colors.white),),
                      ),
                    ):SizedBox.fromSize(),
                    const SizedBox(height: 12,),
                    widget.orderModel.status=="Pending"|| widget.orderModel.status=="Delivery"
                 ?   CupertinoButton(
                      onPressed: ()async{

                        if(widget.orderModel.status=="Pending"){
                          widget.orderModel.status="Cancel";

                      await    FirebaseFirestoreHelper.instance.updateOrder(widget.orderModel,"Cancel");

                          appProviderr.updateCancelPendingOrder(widget.orderModel);
                        }
                        else{
                          widget.orderModel.status="Cancel";

                          await    FirebaseFirestoreHelper.instance.updateOrder(widget.orderModel,"Cancel");

                          appProviderr.updateCancelDeliveryOrder(widget.orderModel);

                        }

                      },
                      padding: EdgeInsets.zero,
                      child: Container(
                        height: 48,
                        width: 150,

                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text("Cancel Order",style: TextStyle(color: Colors.white),),
                      ),
                    )
                        :SizedBox.fromSize(),




                  ],
                ),
              ),
            ],
          ),
          Divider(color: Theme.of(context).primaryColor),
        ],
      ),
    );

  }
}
