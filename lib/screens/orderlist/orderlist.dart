import 'package:admin_panel/screens/singleorderwidget/singleorderwidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/ordermodel/ordermodel.dart';
import '../../provider/provider.dart';

class OrderList extends StatelessWidget {
final String title;
  const OrderList({super.key, required this.title});
List<OrderModel>getOrderList(AppProvider appProvider){
  if(title=="Pending"){
    return appProvider.getPendingOrderList;
  }
  else if(title=="Completed"){
    return appProvider.getCompletedOrderList;

  }
  else if(title=="Cancel"){
    return appProvider.getCancelOrderList;
  }
  else if(title=="Delivery"){
    return appProvider.getDeliveryOrderList;

  }
  else{
    return[];
  }
}
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider=Provider.of<AppProvider>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        title:  Text("$title Order List"),
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: getOrderList(appProvider).isEmpty?Center(
          child: Text("$title is empty"),
        )

       : ListView.builder(
                  itemCount: getOrderList(appProvider).length,
                  itemBuilder: (context,index){
                    OrderModel orderModel=getOrderList(appProvider)[index];
                    return SingleOrderWidget(orderModel: orderModel);

                  },
        ),
      )
    );


  }
}
