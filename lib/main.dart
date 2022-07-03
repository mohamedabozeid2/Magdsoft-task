import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:magdsoft/business_logic/bloc_observer.dart';
import 'package:magdsoft/business_logic/global_cubit/global_cubit.dart';
import 'package:magdsoft/business_logic/global_cubit/global_state.dart';
import 'package:magdsoft/constants/constants.dart';
import 'package:magdsoft/data/local/cache_helper.dart';
import 'package:magdsoft/data/remote/dio_helper.dart';
import 'package:magdsoft/modules/home_screen/home_screen.dart';
import 'package:magdsoft/modules/login_screen/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  if(CacheHelper.getData(key: 'language') == null){
    CacheHelper.saveData(key: 'language', value: 'en');
    language = CacheHelper.getData(key: 'language');
  }else{
    language = CacheHelper.getData(key: 'language');
  }
  if (CacheHelper.getData(key: 'email') != null) {
    email = CacheHelper.getData(key: 'email');
    password = CacheHelper.getData(key: 'password');
  }
  if (CacheHelper.getData(key: 'login') == null) {
    CacheHelper.saveData(key: 'login', value: false);
  }
  Widget startWidget;
  if (CacheHelper.getData(key: 'login')) {
    startWidget = HomeScreen();
  } else {
    startWidget = LoginScreen();
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        startWidget: startWidget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          AppCubit()..getUserData(email: email, password: password),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              title: 'magdsoft intern',
              localizationsDelegates: [
                AppLocalizations.delegate, // Add this line
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                Locale('en'),
                Locale('ar'),
              ],
              locale: Locale(language),
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: startWidget);
        },
      ),
    );
  }
}
