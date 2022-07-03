class UserModel{
  int? status;
  List<UserData>? account;

  UserModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    if(json['account'] != null){
      account = <UserData>[];
      json['account'].forEach((element){
        account!.add(UserData.fromJson(element));
      });
    }
  }
}

class UserData{
  int? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? updated_at;
  String? created_at;


  UserData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json ['phone'];
    updated_at = json['updated_at'];
    created_at = json['created_at'];
  }

}