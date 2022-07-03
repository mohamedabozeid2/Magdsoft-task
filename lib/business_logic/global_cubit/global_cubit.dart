import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft/business_logic/global_cubit/global_state.dart';
import 'package:magdsoft/components/components.dart';
import 'package:magdsoft/constants/constants.dart';
import 'package:magdsoft/constants/end_points.dart';
import 'package:magdsoft/data/local/cache_helper.dart';
import 'package:magdsoft/data/models/account_model.dart';
import 'package:magdsoft/data/models/register_model.dart';
import 'package:magdsoft/data/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData icon = Icons.visibility;

  void changeVisibility() {
    isPassword = !isPassword;
    if (isPassword) {
      icon = Icons.visibility;
    } else {
      icon = Icons.visibility_off;
    }
    emit(AppChangeIconVisibilityState());
  }



  void userLogin({
    required String email,
    required String password
}){
    emit(AppLoginLoadingState());
    DioHelper.postData(url: login, body: {
      "email": email,
      "password" : password,
    }).then((value){
      print(value.data['message']);
      if(value.data['message'] == "user Not Found"){
        showToast(msg: '${value.data['message']}');
        emit(AppLoginUserDataErrorState());
      }else{
        userModel = UserModel.fromJson(value.data);
        emit(AppLoginSuccessState(userModel!));
      }
    }).catchError((error){
      print(error.toString());
      emit(AppLoginErrorState(error.toString()));
    });
  }

  void getUserData({
    required String email,
    required String password
  }){
    if(email != ""){
      emit(AppGetUserLoadingDataState());
      DioHelper.postData(url: login, body: {
        "email": email,
        "password" : password,
      }).then((value){
        print(value.data);
        if(value.data['message'] == "phone number must be more than 11 and less than 15"){
          showToast(msg: value.data['message']);
          emit(AppRegisterPhoneErrorState());
        }else{
          userModel = UserModel.fromJson(value.data);
          emit(AppGetUserSuccessDataState());
        }

      }).catchError((error){
        print(error.toString());
        emit(AppGetUserErrorDataState());
      });
    }
  }


  RegisterModel? registerModel;

  void userRegister({
  required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword
}){
    emit(AppRegisterLoadingState());
    DioHelper.postData(url: register, body: {
      'name' : name,
      'email' : email,
      'password' : password,
      'phone' : phone,
    }).then((value){
      print(value.data);
      registerModel = RegisterModel.fromJson(value.data);
      showToast(msg: "${registerModel!.message}");
      if(registerModel!.message == "Account Created Successfully"){
        userLogin(email: email, password: password);
      }

      emit(AppRegisterSuccessState());
    }).catchError((error){
      emit(AppRegisterErrorState());
    });

  }

  void changeLanguage(){
    if(language == 'en'){
      language = 'ar';
      CacheHelper.saveData(key: 'language', value: 'ar');
    }else{
      language = 'en';
      CacheHelper.saveData(key: 'language', value: 'en');
    }
    emit(AppChangeLanguageState());
  }

}
