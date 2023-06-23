import 'package:flutter/material.dart';

import '../../../constants/routes.dart';
import '../../../widgets/primary_button/primary_button.dart';
import '../../../widgets/top_titles/top_titles.dart';
import '../login/login.dart';
import '../sign_up/signup.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const TopTitles(title: "Enjoy Shopping", subtitle:"Buy Products"),
              const Center(child: Padding(
                padding: EdgeInsets.all(50),

                child: Text("WELCOME",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.blue),),

              ),

              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 45,width: double.infinity,
                child: ElevatedButton(onPressed: (

                    ){
                 Routes.instance.push(widget:const Login(),context:context );

                }, child: const Text("Login",style: TextStyle(fontSize:20,color: Colors.black),),),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PrimaryButton(title: "SignUp",
                  onPressed: (){
                    Routes.instance.push(widget:const SignUp(),context:context );

                  },),
              )


            ],
          ),
        ),
      ),
    );
  }
}
