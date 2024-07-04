import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hieroglyphic_app/compenets/components.dart';
import 'package:hieroglyphic_app/Screens/loginscreen/loginscreen.dart';
import 'package:hieroglyphic_app/Screens/register_screen/cubit/cubit.dart';
import 'package:hieroglyphic_app/Screens/register_screen/cubit/state.dart';
import 'package:hieroglyphic_app/compenets/constant/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../compenets/constants.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var adminController = TextEditingController();
  String? grade;

  String? selectedGrade = 'Select your grade';
 // bool isAdmin  = false;
  File? profileImage;
  var pickerController = ImagePicker();


  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterState>(
        listener: (context, state) {
          if (state is SocialusercreateSuccessState) {}
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.primaryColor,
              title: Text(AppLocalizations.of(context)!.registerAppBar),
              centerTitle: true,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 100.0,
                              width: 100.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                           Center(
                            child: Text(
                              " Welcome ",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                           Center(
                            child: Text(
                              "Rgister Now",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            obscureText: false,
                            enabled: true,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter name';
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              prefixIcon: Icon(
                                Icons.person,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            enabled: true,
                            validator: (value) {
                              if (value!.trim() == "") {
                                return "Please Enter Email";
                              }
                              final bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value);
                              if (!emailValid) {
                                return "Please Enter valid Email";
                              }

                              if (value.isEmpty) {
                                return 'Please enter Email';
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(
                                Icons.email,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText:
                                SocialRegisterCubit.get(context).isPassword,
                            enabled: true,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.key),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  SocialRegisterCubit.get(context)
                                      .ChangePassword();
                                },
                                icon: Icon(
                                  SocialRegisterCubit.get(context).suffix,
                                ),
                              ),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  isAdmin = SocialRegisterCubit.get(context)
                                      .CheckIfUser(isAdmin);
                                },
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'User ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: isAdmin
                                                ? AppColor.primaryColor
                                                : Colors.white),
                                      ),
                                      Icon(
                                        Icons.account_circle_rounded,
                                        color: isAdmin
                                            ? AppColor.primaryColor
                                            : Colors.white,
                                      ),
                                    ],
                                  )),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: isAdmin
                                          ? Colors.white
                                          : AppColor.primaryColor),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  isAdmin = SocialRegisterCubit.get(context)
                                      .CheckIfAdmin(isAdmin);
                                },
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Admin ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: isAdmin
                                                ? Colors.white
                                                : AppColor.primaryColor),
                                      ),
                                      Icon(
                                        Icons.lock_person,
                                        color: isAdmin
                                            ? Colors.white
                                            : AppColor.primaryColor,
                                      ),
                                    ],
                                  )),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: isAdmin
                                          ? AppColor.primaryColor
                                          : Colors.white),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          isAdmin
                              ? TextFormField(
                                  controller: adminController,
                                  keyboardType: TextInputType.number,
                                  obscureText: false,
                                  enabled: true,
                                  validator: (value) {
                                    if (value != '123') {
                                      return 'Please enter Admin code';
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Admin Code',
                                    prefixIcon: Icon(
                                      Icons.lock_person,
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                )
                              : Center(
                                  child: DropdownButton<String>(
                                    hint: Text(selectedGrade!),
                                    value: grade,
                                    onChanged: (String? value) {
                                      grade = value;
                                      selectedGrade =
                                          SocialRegisterCubit.get(context)
                                              .CheckGrade(grade!);
                                    },
                                    items: <String>[
                                      'one',
                                      'two',
                                      'three',
                                      'four'
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          ConditionalBuilder(
                            condition: state is! SocialRegisterLoadingState,
                            builder: (context) => Center(
                              child: defaultMaterialButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      SocialRegisterCubit.get(context)
                                          .UserRegister(
                                              email: emailController.text,
                                              password: passwordController.text,
                                              name: nameController.text,
                                              isAdmin: isAdmin);
                                      navigateTo(context, LoginScreen());
                                    }
                                  },
                                  text: 'Register',
                                  radius: 20),
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Already have acount',
                                style: GoogleFonts.lobster(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    navigateTo(context, LoginScreen());
                                  },
                                  child: Text(
                                    'Login',
                                    style: GoogleFonts.lobster(
                                      fontSize: 18.0,
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ))
                            ],
                          )
                        ]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
