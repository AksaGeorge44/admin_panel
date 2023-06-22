import 'package:admin_panel/provider/provider.dart';
import 'package:admin_panel/screens/categoryview/categoryview.dart';
import 'package:admin_panel/screens/homepage/widgets/single_dash_item.dart';
import 'package:admin_panel/screens/notification/notification.dart';
import 'package:admin_panel/screens/orderlist/orderlist.dart';
import 'package:admin_panel/screens/productview/productview.dart';
import 'package:admin_panel/screens/user_view/user_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';

class HomePage extends StatefulWidget {
   const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isLoading=false;

  void getData() async{
    setState(() {

      isLoading=true;
    });

    AppProvider appProvider=Provider.of<AppProvider>(context,listen: false);
     await appProvider.callBackFunction();
    setState(() {

      isLoading=false;
    });

  }

  @override
  void initState(){
   getData();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    AppProvider appProvider=Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),

      body:isLoading?const Center(child: CircularProgressIndicator(),
      )
      :Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const CircleAvatar(
                radius: 30,
              ),
              const SizedBox(height: 12,),

              const Text("Aksa",style: TextStyle(fontSize: 18),),
              const Text("aksa@gmal.com",style: TextStyle(fontSize: 18),),
              const SizedBox(height: 12,),
              ElevatedButton(onPressed: (){
                Routes.instance.push(widget: const NotificatonScreen(), context: context);


              }, child: const Text("Send notifications to users")),

              GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.only(top: 12),
                crossAxisCount: 2,
                children: [

                  SingleDashItem(title: appProvider.getUserList.length.toString(),

                      subtitle: "Users",

                    onPressed: (){
                    Routes.instance.push(widget: const UserView(), context: context);

                    },


                  ),
                  SingleDashItem(title:appProvider.getCategories.length.toString() ,

                      subtitle: "Categories",onPressed: (){
                      Routes.instance.push(widget: const CategoriesView(), context: context);


                    },),


                  SingleDashItem(title: appProvider.getProducts.length.toString(),
                      subtitle: "Products",onPressed: (){
                        Routes.instance.push(widget: const ProductView(), context: context);


                      }),


                  SingleDashItem(title: "\$${appProvider.getTotalEarning}",
                      subtitle: "Earnings",onPressed: (){},),
                  SingleDashItem(title: appProvider.getPendingOrderList.length.toString(),
                      subtitle: "Pending Order",onPressed: (){

                     Routes.instance.push(widget: const OrderList(
                        title: "Pending",
                        ), context: context);
                    },),
                  SingleDashItem(title: appProvider.getPendingOrderList.length.toString(),
                    subtitle: "Delivery Order",onPressed: (){

                    Routes.instance.push(widget: const OrderList(
                        title: "Delivery",
                        ), context: context);

                    },


                  ),

                  SingleDashItem(title: appProvider.getCancelOrderList.length.toString(),
                    subtitle: "Cancel Order",onPressed: (){
                    Routes.instance.push(widget: const OrderList(
                        title: "Cancel Order",
                        ), context: context);


                    },),

                  SingleDashItem(title: appProvider.getCompletedOrderList.length.toString(),
                      subtitle: "Completed Order",onPressed: (){
                    Routes.instance.push(widget: const OrderList(
                        title: "Completed",
                        ), context: context);

                    },),


                ],



                  )

            ],
          ),
        ),
      ),
    );
  }
}
