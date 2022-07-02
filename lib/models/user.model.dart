class UserModel {
  int? id;
  String? name;
  String? email;
  String? username;
  String? avatar;
  String? biography;
  bool? active;
  bool? verified;
  bool? privated;
  String? createdAt;
  String? updatedAt;
  ProfileDetails? profileDetails;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.username,
      this.avatar,
      this.biography,
      this.active,
      this.verified,
      this.privated,
      this.createdAt,
      this.updatedAt,
      this.profileDetails});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    avatar = json['avatar'];
    biography = json['biography'];
    active = json['active'];
    privated = json['privated'];
    verified = json['verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profileDetails = json['profile_details'] != null
        ? new ProfileDetails.fromJson(json['profile_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['biography'] = this.biography;
    data['active'] = this.active;
    data['privated'] = this.privated;
    data['verified'] = this.verified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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

  ProfileDetails(
      {this.mentions, this.medias, this.posts, this.followed, this.followers});

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
