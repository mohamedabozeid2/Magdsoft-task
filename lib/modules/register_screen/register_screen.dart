import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft/business_logic/global_cubit/global_cubit.dart';
import 'package:magdsoft/business_logic/global_cubit/global_state.dart';
import 'package:magdsoft/components/components.dart';
import 'package:magdsoft/modules/login_screen/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Container(
            color: const Color(0xff005da3),
            child: Form(
              key: formKey,
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.35,
                          color: const Color(0xff005da3),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.05,
                                right:
                                    MediaQuery.of(context).size.width * 0.08),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(AppLocalizations.of(context)!.english),
                                    ),
                                  ),
                                  onTap: (){
                                    AppCubit.get(context).changeLanguage();
                                  },
                                ),
                                const Center(
                                  child: Image(
                                    image:
                                        AssetImage("assets/images/logo2.png"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    topRight: Radius.circular(50.0)),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: textFormField(
                                      controller: nameController,
                                      lable: AppLocalizations.of(context)!.fullName,
                                      type: TextInputType.text,
                                      validation: "Please enter your name",
                                      borderRadius: 8.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: textFormField(
                                      controller: emailController,
                                      lable: AppLocalizations.of(context)!.email,
                                      type: TextInputType.emailAddress,
                                      validation: "Please enter your Email",
                                      borderRadius: 8.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: textFormField(
                                      controller: phoneController,
                                      lable: AppLocalizations.of(context)!.phone,
                                      type: TextInputType.phone,
                                      validation:
                                          "Please enter your phone number",
                                      borderRadius: 8.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: textFormField(
                                      controller: passwordController,
                                      lable: AppLocalizations.of(context)!.password,
                                      type: TextInputType.visiblePassword,
                                      suffixIcon: AppCubit.get(context).icon,
                                      isPassword:
                                          AppCubit.get(context).isPassword,
                                      fun: () {
                                        AppCubit.get(context)
                                            .changeVisibility();
                                      },
                                      borderRadius: 8.0,
                                      validation: "Please enter your password",
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: textFormField(
                                      controller: confirmPasswordController,
                                      lable: AppLocalizations.of(context)!.confirmPassword,
                                      type: TextInputType.visiblePassword,
                                      suffixIcon: AppCubit.get(context).icon,
                                      isPassword:
                                          AppCubit.get(context).isPassword,
                                      fun: () {
                                        AppCubit.get(context)
                                            .changeVisibility();
                                      },
                                      borderRadius: 8.0,
                                      validation: "Please enter your password",
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ConditionalBuilder(
                                        condition: state is! AppRegisterLoadingState,
                                        builder: (BuildContext context) {
                                          return defaultButton(
                                              fun: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  if(passwordController.text == confirmPasswordController.text){
                                                    AppCubit.get(context).userRegister(
                                                        name: nameController.text,
                                                        email: emailController.text,
                                                        phone: phoneController.text,
                                                        password:
                                                        passwordController.text,
                                                        confirmPassword:
                                                        confirmPasswordController
                                                            .text);
                                                  }else{
                                                    showToast(msg: "Password does not match the confirm password");
                                                  }

                                                }
                                              },
                                              text: AppLocalizations.of(context)!.register,
                                              backgroundColor: Color(0xff005da3),
                                              height: 61.0,
                                              TextColor: Colors.white,
                                              width: 152.0,
                                              borderRadius: 15.0);
                                        },
                                        fallback: (BuildContext context) => Center(child: const CircularProgressIndicator()),

                                      ),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      defaultButton(
                                          fun: () {
                                            navigateAndFinish(
                                                context: context,
                                                widget: LoginScreen());
                                          },
                                          text: AppLocalizations.of(context)!.login,
                                          backgroundColor: Color(0xff005da3),
                                          height: 61.0,
                                          width: 152.0,
                                          TextColor: Colors.white,
                                          borderRadius: 15.0),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
