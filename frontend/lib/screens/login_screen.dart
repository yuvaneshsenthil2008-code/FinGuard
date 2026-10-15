import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'main_navigation.dart';
import '../utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  void login(){

    // Temporary login
    // Later connect Firebase

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context)=> const MainNavigation(),
      ),
    );

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: AppColors.background,


      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.all(24),

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,


            children: [


              // Logo

              CircleAvatar(

                radius: 45,

                backgroundColor: AppColors.primary,

                child: const Icon(
                  Icons.account_balance_wallet,
                  size:50,
                  color:Colors.white,
                ),

              ),


              const SizedBox(height:20),


              const Text(

                "FinGuard AI",

                style: TextStyle(

                  fontSize:32,

                  fontWeight:FontWeight.bold,

                ),

              ),


              const SizedBox(height:8),


              const Text(

                "Smart payments. Better financial decisions.",

                textAlign: TextAlign.center,

                style: TextStyle(
                  color:Colors.grey,
                ),

              ),



              const SizedBox(height:40),



              TextField(

                controller: emailController,

                decoration: InputDecoration(

                  labelText:"Email",

                  prefixIcon:const Icon(Icons.email),

                  border:OutlineInputBorder(

                    borderRadius:BorderRadius.circular(12),

                  ),

                ),

              ),



              const SizedBox(height:20),



              TextField(

                controller:passwordController,

                obscureText:true,

                decoration:InputDecoration(

                  labelText:"Password",

                  prefixIcon:const Icon(Icons.lock),

                  border:OutlineInputBorder(

                    borderRadius:BorderRadius.circular(12),

                  ),

                ),

              ),



              const SizedBox(height:30),



              SizedBox(

                width:double.infinity,

                height:55,


                child:ElevatedButton(

                  onPressed:login,


                  style:ElevatedButton.styleFrom(

                    backgroundColor:AppColors.primary,

                    shape:RoundedRectangleBorder(

                      borderRadius:BorderRadius.circular(12),

                    ),

                  ),


                  child:const Text(

                    "Login",

                    style:TextStyle(

                      color:Colors.white,

                      fontSize:18,

                    ),

                  ),

                ),

              ),



              const SizedBox(height:15),



              TextButton(

                onPressed:(){},

                child:const Text(

                  "Create New Account",

                ),

              )



            ],

          ),

        ),

      ),

    );

  }
}