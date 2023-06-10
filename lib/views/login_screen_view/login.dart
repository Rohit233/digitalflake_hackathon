import 'package:digitalflake_hackathon/utils/navigator_utils.dart';
import 'package:digitalflake_hackathon/view_models/login_view_model.dart';
import 'package:digitalflake_hackathon/views/common_widgets/elevated_button_widget.dart';
import 'package:digitalflake_hackathon/views/create_acc_screen_view/create_account.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginViewModel loginViewModel = LoginViewModel();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Column(
                    children: [
                      Padding(
                    padding: EdgeInsets.only(top: 20.0,bottom: MediaQuery.of(context).size.height * 0.1),
                    child: Column(
                      children: [
                        Image.asset('assets/images/df_icon.png',height: 100, width: 100,),
                        Text('Co-working',style: Theme.of(context).textTheme.headline5,),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Mobile number or Email',style: Theme.of(context).textTheme.titleMedium,)
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: TextField(
                                controller: _emailEditingController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Password',style: Theme.of(context).textTheme.titleMedium,)
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: TextField(
                                controller: _passwordEditingController,
                                obscureText: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButtonWidget(
                      onPressed: ()async{
                          await loginViewModel.login(context, _emailEditingController.text, _passwordEditingController.text);
                      },
                      child: const Text('LogIn')),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: RichText(
                          text: TextSpan(children: [
                        const TextSpan(
                            style: TextStyle(color: Colors.black),
                            text: "New user?"),
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap = () {
                              NavigatorUtils.navigatePushReplacement(context, const CreateAccountScreen());
                            },
                            style: const TextStyle(color:Colors.blue,fontSize: 17),
                            text: 'Create an account '),
                      ])),
                    )
                  ],
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}