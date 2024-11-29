import 'package:digital_detox/LogIn-SignUp/screens/signup.dart';
import 'package:digital_detox/LogIn-SignUp/widgets/button.dart';
import 'package:digital_detox/LogIn-SignUp/widgets/text_Field.dart';
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
            SizedBox(height: height/15,),
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
