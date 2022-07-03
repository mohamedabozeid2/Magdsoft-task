import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft/business_logic/global_cubit/global_cubit.dart';
import 'package:magdsoft/business_logic/global_cubit/global_state.dart';
import 'package:magdsoft/components/components.dart';
import 'package:magdsoft/data/local/cache_helper.dart';
import 'package:magdsoft/modules/home_screen/home_screen.dart';
import 'package:magdsoft/modules/register_screen/register_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is AppLoginSuccessState){
          print(state.userModel.status);
          CacheHelper.saveData(key: 'login', value: true);
          CacheHelper.saveData(key: 'email', value: state.userModel.account![0].email);
          CacheHelper.saveData(key: 'password', value: state.userModel.account![0].password);
          print("==>now ${CacheHelper.getData(key: 'login')}");
          navigateAndFinish(context: context, widget: HomeScreen());
          print(state.userModel.account![0].id);
          showToast(msg: 'Login done successfully');
        }
      },
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
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.35,
                          color: const Color(0xff005da3),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.05,
                                right: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.08),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            10.0)),
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
                                    image: AssetImage(
                                        "assets/images/logo2.png"),
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
                                  const Spacer(),
                                  SizedBox(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.7,
                                    child: textFormField(
                                      controller: emailController,
                                      lable: AppLocalizations.of(context)!.email,
                                      type: TextInputType.emailAddress,
                                      validation: "Email must not be empty",
                                      borderRadius: 8.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  SizedBox(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.7,
                                    child: textFormField(
                                      controller: passwordController,
                                      lable: AppLocalizations.of(context)!.password,
                                      type: TextInputType.visiblePassword,
                                      suffixIcon: AppCubit
                                          .get(context)
                                          .icon,
                                      isPassword: AppCubit
                                          .get(context)
                                          .isPassword,
                                      fun: () {
                                        AppCubit.get(context)
                                            .changeVisibility();
                                      },
                                      borderRadius: 8.0,
                                      validation: "Password must not be empty",
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .center,
                                    children: [
                                      defaultButton(
                                          fun: () {
                                            navigateTo(
                                                context, RegisterScreen());
                                          },
                                          text: AppLocalizations.of(context)!.register,
                                          backgroundColor: Color(0xff005da3),
                                          height: 61.0,
                                          TextColor: Colors.white,
                                          width: 152.0,
                                          borderRadius: 15.0),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      ConditionalBuilder(
                                        condition: state is! AppLoginLoadingState,
                                        builder: (context) {
                                          return defaultButton(
                                              fun: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  AppCubit.get(context)
                                                      .userLogin(
                                                      email: emailController
                                                          .text,
                                                      password: passwordController
                                                          .text);
                                                }
                                              },
                                              text: AppLocalizations.of(context)!.login,
                                              backgroundColor: const Color(
                                                  0xff005da3),
                                              height: 61.0,
                                              width: 152.0,
                                              TextColor: Colors.white,
                                              borderRadius: 15.0);
                                        },
                                        fallback: (context) =>
                                        const Center(
                                            child: CircularProgressIndicator()),
                                      ),
                                      SizedBox(
                                        height: MediaQuery
                                            .of(context)
                                            .size
                                            .height *
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
