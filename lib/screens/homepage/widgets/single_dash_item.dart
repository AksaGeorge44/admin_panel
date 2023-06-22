import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleDashItem extends StatelessWidget {
  final String title,subtitle;
final void Function()? onPressed;
  const SingleDashItem({super.key, required this.title, required this.subtitle, this.onPressed});

  @override
  Widget build(BuildContext context) {

    return  CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Card(
        child: Container(
          width: double.infinity,
          color: Colors.redAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(title,
                style: TextStyle(fontSize: subtitle=="Earning"?30:35,),),
              Text(subtitle,

                style: TextStyle(fontSize: 25,),),
            ],
          ),

        ),
      ),
    );;
  }
}
