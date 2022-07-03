import 'package:magdsoft/data/models/account_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates{}

class AppChangeIconVisibilityState extends AppStates{}

class AppLoginLoadingState extends AppStates{}
class AppLoginSuccessState extends AppStates{
  final UserModel userModel;

  AppLoginSuccessState(this.userModel);
}
class AppLoginUserDataErrorState extends AppStates{}
class AppLoginErrorState extends AppStates{
  final String error;

  AppLoginErrorState(this.error);
}

class AppGetUserLoadingDataState extends AppStates{}
class AppGetUserSuccessDataState extends AppStates{}
class AppGetUserErrorDataState extends AppStates{}

class AppRegisterLoadingState extends AppStates{}
class AppRegisterSuccessState extends AppStates{}
class AppRegisterErrorState extends AppStates{}
class AppRegisterPhoneErrorState extends AppStates{}

class AppChangeLanguageState extends AppStates{}