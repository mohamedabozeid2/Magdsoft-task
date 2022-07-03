import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



Widget textFormField({
  required TextEditingController controller,
  bool isPassword = false,
  String validation = "",
  required String lable,
  required TextInputType type,
  IconData? prefixIcon,
  IconData? suffixIcon,
  void Function()? fun,
  double borderRadius = 5.0,

}){
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    validator: (String? value) {
      if (value!.isEmpty) {
        return validation;
      }
    },
    decoration: InputDecoration(
        label: Text(
          lable,
        ),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(
          onPressed:  fun,
          icon: Icon(suffixIcon==null?suffixIcon = null: suffixIcon = suffixIcon),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Colors.black))),
  );
}

Widget defaultButton({
  double width = double.infinity,
  double height = 55,
  Color backgroundColor = Colors.blue,
  double borderRadius = 5.0,
  String? text,
  bool isUpperCase = false,
  Color? TextColor,
  required fun,
}) {
  return Container(
    width: width,
    height: height,
    child: MaterialButton(
      onPressed: fun,
      child: Text(
        isUpperCase ? text!.toUpperCase() : text!,
        style: TextStyle(
          color: TextColor,
          fontSize: 15,
        ),
      ),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      color: backgroundColor,
    ),
  );
}

void navigateAndFinish({required context, required widget}) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget), (route) => false);
}

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return widget;
  }));
}

void showToast({
  required String msg,
  Color color = Colors.white,
  Color textColor = Colors.black,

}){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: textColor,
      fontSize: 16.0
  );
}