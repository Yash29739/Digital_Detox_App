import 'package:digital_detox/LogIn-SignUp/screens/signup.dart';
import 'package:digital_detox/LogIn-SignUp/widgets/button.dart';
import 'package:digital_detox/LogIn-SignUp/widgets/text_Field.dart';
import 'package:digital_detox/Login%20with%20Google/google_auth.dart';
import 'package:flutter/material.dart';

import '../Services/authentication.dart';
import '../widgets/snack_bar.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<LoginScreen> {


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUsers() async {
    // set is loading to true.
    setState(() {
      isLoading = true;
    });
    // signup user using our authmethod
    String res = await AuthMethod().loginUser(
        email: emailController.text,
        password: passwordController.text,);
    // if string return is success, user has been creaded and navigate to next screen other witse show error.
    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      //navigate to the next screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      // show error
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: SizedBox(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: height/2.7,
              child: Image.asset("images/login.jpg"),
            ),
            TextFieldInpute(textEditingController: emailController, hintText: "Enter Your Email", icon: Icons.email, textInputType: TextInputType.text,),
            TextFieldInpute(isPass:true,textEditingController: passwordController, hintText: "Enter Your Password", icon: Icons.lock, textInputType: TextInputType.text,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("ForgotPassword?",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16 ,color:Colors.blue),)),
            ),
            MyButtons(onTap: loginUsers, text: "Log In"),



            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Expanded(child:Container(height: 1,color: Colors.black,),)
                ,const Text("   or   "),
                Expanded(child:Container(height: 1,color: Colors.black,),)
              ],),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white70),
                  onPressed: () async{
                    await FirebaseServices().signInWithGoogle();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen(),),);
                  },
                  child:Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("images/google_logo.png",height: 35,),
                      ),
                      const Text("continue with google",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black45),),
                    ],
                  )
              ),
            ),

            // const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const Text("Don't have an Account?",style: TextStyle(fontSize: 16),),
              GestureDetector(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignupScreen(),));
              },
              child: const Text("Sign Up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),) ,
              )
              ],)
          ],
        )
      )),
    );
  }
}
