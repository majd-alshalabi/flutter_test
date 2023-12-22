class MyIdentity {
  int? id;
  String? name;
  String? createdAt;
  String? token;

  MyIdentity({
    this.id,
    this.name,
    this.createdAt,
    this.token,
  });

  MyIdentity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    name = json['name'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['token'] = token;
    data['createdAt'] = createdAt;
    return data;
  }

  MyIdentity copyWith({
    int? id,
    String? name,
    String? token,
    String? createdAt,
  }) =>
      MyIdentity(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        token: token ?? this.token,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "token": token,
        "createdAt": createdAt,
      };

  factory MyIdentity.fromMap(Map<String, dynamic> json) => MyIdentity(
        id: json["id"],
        name: json["name"],
        token: json["token"],
        createdAt: json["createdAt"],
      );
}
