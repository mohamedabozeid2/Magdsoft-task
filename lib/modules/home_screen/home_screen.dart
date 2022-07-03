import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft/business_logic/global_cubit/global_cubit.dart';
import 'package:magdsoft/business_logic/global_cubit/global_state.dart';
import 'package:magdsoft/components/components.dart';
import 'package:magdsoft/constants/constants.dart';
import 'package:magdsoft/data/local/cache_helper.dart';
import 'package:magdsoft/modules/login_screen/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    print("Hello");
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){


      },
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.userData),
            centerTitle: true,
            backgroundColor: const Color(0xff005da3),
          ),
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                fillOverscroll: false,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ConditionalBuilder(
                      condition: userModel != null,
                      builder: (context) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20.0,),
                            const Spacer(),
                            Text('${AppLocalizations.of(context)!.name} : ${userModel!.account![0].name}',
                              style: const TextStyle(
                                color: Color(0xff005da3),
                                fontSize: 24.0,

                              ),),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Text('${AppLocalizations.of(context)!.email} : ${userModel!.account![0].email}',
                              style: const TextStyle(
                                color: Color(0xff005da3),
                                fontSize: 24.0,

                              ),),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Text('${AppLocalizations.of(context)!.phone} : ${userModel!.account![0].phone}',
                              style: const TextStyle(
                                color: Color(0xff005da3),
                                fontSize: 24.0,

                              ),),
                            const Spacer(),
                            Row(
                              children: [
                                const Spacer(),
                                defaultButton(
                                  TextColor: Colors.white,
                                  borderRadius: 20.0,
                                  width: MediaQuery.of(context).size.width*0.35,
                                  text: (AppLocalizations.of(context)!.logout),
                                  backgroundColor: const Color(0xffad002f),
                                  fun: (){
                                    CacheHelper.saveData(key: "login", value: false);
                                    CacheHelper.removeData(key: 'email');
                                    CacheHelper.removeData(key: 'password');
                                    navigateAndFinish(context: context, widget: LoginScreen());
                                  },
                                ),
                                const Spacer(),
                              ],
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height*0.08
                            )
                          ],
                        );
                      },
                      fallback: (context)=> const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
              )
            ],

          ),
        );
      },

    );
  }
}
