import 'package:digitalflake_hackathon/utils/navigator_utils.dart';
import 'package:digitalflake_hackathon/view_models/create_acc_view_model.dart';
import 'package:digitalflake_hackathon/views/common_widgets/elevated_button_widget.dart';
import 'package:digitalflake_hackathon/views/login_screen_view/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _fullNameEditingController = TextEditingController();
  final TextEditingController _mobileNumberEditingController = TextEditingController();

  CreateAccViewModel createAccViewModel = CreateAccViewModel();

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
                       padding: EdgeInsets.only(top:80,bottom:MediaQuery.of(context).size.height *0.05,left: 8.0),
                       child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Create an Account',style: Theme.of(context).textTheme.headline5,)),
                     ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Full name',style: Theme.of(context).textTheme.titleMedium,)
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: TextField(
                                controller: _fullNameEditingController,
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
                              child: Text('Mobile number',style: Theme.of(context).textTheme.titleMedium,)
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: TextField(
                                controller: _mobileNumberEditingController,
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
                              child: Text('Email id',style: Theme.of(context).textTheme.titleMedium,)
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
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButtonWidget(
                      onPressed: () async{
                        await createAccViewModel.createAccount(context,_fullNameEditingController.text,_emailEditingController.text,_mobileNumberEditingController.text);
                      },
                      child: const Text('Create an Account')),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: RichText(
                          text: TextSpan(children: [
                        const TextSpan(
                            style: TextStyle(color: Colors.black),
                            text: "Existing user?"),
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap = () {
                              NavigatorUtils.navigatePushReplacement(context, const LoginScreen());
                            },
                            style: const TextStyle(color: Colors.blue,fontSize: 17),
                            text: 'Log In'),
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