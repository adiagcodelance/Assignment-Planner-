class LoginModel {
  String username;
  String password;
  LoginModel(this.username, this.password);

  Map toJson() {
    return {"username": username, "password": password};
  }
}
