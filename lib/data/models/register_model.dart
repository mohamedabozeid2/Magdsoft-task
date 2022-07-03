class RegisterModel{
  int? status;
  String? message;

  RegisterModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}