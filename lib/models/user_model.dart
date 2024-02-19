class UserModel {
  final String email;
  final String name;
  final List<String> followers;
  final List<String> following;
  final String profilePic;
  final String bannerPic;
  final String uid;
  final String bio;
  final bool isTwitterBlue;

  UserModel(
      {required this.email,
      required this.name,
      required this.followers,
      required this.following,
      required this.profilePic,
      required this.bannerPic,
      required this.uid,
      required this.bio,
      required this.isTwitterBlue});

  /*all the variable in user model are final and it is immutable so to change the
  * value of the variable we need copy with function*/
  UserModel copyWith({
    String? email,
    String? name,
    List<String>? followers,
    List<String>? following,
    String? profilePic,
    String? bannerPic,
    String? uid,
    String? bio,
    bool? isTwitterBlue,
  }) {
    return UserModel(
        email: email ?? this.email,
        name: name ?? this.name,
        followers: followers ?? this.followers,
        following: following ?? this.following,
        profilePic: profilePic ?? this.profilePic,
        bannerPic: bannerPic ?? this.bannerPic,
        uid: uid ?? this.uid,
        bio: bio ?? this.bio,
        isTwitterBlue: isTwitterBlue ?? this.isTwitterBlue);
  }

  /*to map function will convert all the fields into a map format*/
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'email': email});
    result.addAll({'name': name});
    result.addAll({'followers': followers});
    result.addAll({'following': following});
    result.addAll({'profilePic': profilePic});
    result.addAll({'bannerPic': bannerPic});
    result.addAll({'bio': bio});
    result.addAll({'isTwitterBlue': isTwitterBlue});
    return result;
  }

  /*from map gets the map and converts into to model*/
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        email: map['email'] ?? '',
        name: map['name'] ?? '',
        followers: List<String>.from(map['followers']),
        following: List<String>.from(map['following']),
        profilePic: map['profilePic'] ?? '',
        bannerPic: map['bannerPic'] ?? '',
        uid: map['\$id'] ?? '',
        bio: map['bio'] ?? '',
        isTwitterBlue: map['isTwitterBlue'] ?? '');
  }

  @override
  String toString() {
    return 'UserModel(email:$email, name:$name, followers:$followers, following:$following,profilePic:$profilePic, bannerPic:$bannerPic, uid: $uid, bio: $bio, isTwitterBlue: $isTwitterBlue)';
  }
}
