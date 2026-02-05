enum UserType {
  locum,
  pharmacy;

  bool get isPharmacy => this == UserType.pharmacy;
  bool get isLocum => this == UserType.locum;
}

enum AuthState {
  verified,
  unverified,
  suspended;

  bool get isVerified => this == AuthState.verified;
  bool get isUnverified => this == AuthState.unverified;
  bool get isSuspended => this == AuthState.suspended;

  String titleText() {
    return switch (this) {
      AuthState.verified => 'Verification Done',
      AuthState.unverified => 'Verification link sent',
      AuthState.suspended => 'Account Suspended',
    };
  }

  String subtitleText() {
    return switch (this) {
      AuthState.verified => 'Your email Verification Complete. Continue to Dashboard.',
      AuthState.unverified =>
        'We\'ve sent an email to your email. Please click the link inside to verify your account.',
      AuthState.suspended =>
        'For your security, we have temporarily disabled login attempts due to suspicious activities.',
    };
  }
}

class UserModel {
  final String id;
  final String name;
  final String userHandle;
  final String profileImageUrl;
  final bool isVerified;
  final String bio;
  final String location;
  final String followersCount;
  final String followingCount;
  final String salesCount;

  UserModel({
    required this.id,
    required this.profileImageUrl,
    required this.isVerified,
    required this.bio,
    required this.location,
    required this.followersCount,
    required this.followingCount,
    required this.salesCount,
    required this.name,
    required this.userHandle,
  });
}
