// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  String id;
  String name;
  bool enable;
  UserModel({
    required this.id,
    required this.name,
    required this.enable,
  });

  UserModel copyWith({
    String? id,
    String? name,
    bool? enable,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      enable: enable ?? this.enable,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'enable': enable,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      enable: map['enable'] as bool,
    );
  }
}
