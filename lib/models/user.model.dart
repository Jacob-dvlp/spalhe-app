class UserModel {
  int? id;
  String? email;
  String? name;
  String? username;
  String? avatar;
  String? biography;
  bool? active;
  bool? verified;
  String? createdAt;
  String? updatedAt;
  String? following;
  String? followed;
  bool? privated;
  ProfileDetails? profileDetails;

  UserModel(
      {this.id,
      this.email,
      this.name,
      this.username,
      this.avatar,
      this.biography,
      this.active,
      this.verified,
      this.createdAt,
      this.updatedAt,
      this.following,
      this.followed,
      this.privated,
      this.profileDetails});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    username = json['username'];
    avatar = json['avatar'];
    biography = json['biography'];
    active = json['active'];
    verified = json['verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    following = json['following'];
    followed = json['followed'];
    privated = json['privated'];
    profileDetails = json['profile_details'] != null
        ? new ProfileDetails.fromJson(json['profile_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['biography'] = this.biography;
    data['active'] = this.active;
    data['verified'] = this.verified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['following'] = this.following;
    data['followed'] = this.followed;
    data['privated'] = this.privated;
    if (this.profileDetails != null) {
      data['profile_details'] = this.profileDetails!.toJson();
    }
    return data;
  }
}

class ProfileDetails {
  int? mentions;
  int? medias;
  int? posts;
  int? followed;
  int? followers;

  ProfileDetails({
    this.mentions,
    this.medias,
    this.posts,
    this.followed,
    this.followers,
  });

  ProfileDetails.fromJson(Map<String, dynamic> json) {
    mentions = json['mentions'];
    medias = json['medias'];
    posts = json['posts'];
    followed = json['followed'];
    followers = json['followers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mentions'] = this.mentions;
    data['medias'] = this.medias;
    data['posts'] = this.posts;
    data['followed'] = this.followed;
    data['followers'] = this.followers;
    return data;
  }
}
