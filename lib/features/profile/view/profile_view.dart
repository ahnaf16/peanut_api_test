import 'package:flutter/material.dart';
import 'package:peanut_api_test/features/profile/controller/profile_ctrl.dart';
import 'package:peanut_api_test/features/profile/view/profile_details_section.dart';
import 'package:peanut_api_test/features/profile/view/profile_header.dart';
import 'package:peanut_api_test/main.export.dart';

class ProfileView extends HookConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(accountInfoCtrlProvider);

    return Scaffold(
      appBar: AppBar(scrolledUnderElevation: 0, title: const Text('Profile')),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) {
          return Center(child: ErrorView(e, s, prov: [accountInfoCtrlProvider, phoneDigitCtrlProvider]));
        },
        data: (accountInfo) {
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(accountInfoCtrlProvider);
              ref.invalidate(phoneDigitCtrlProvider);
            },
            child: context.isLandscape
                ? Row(
                    children: [
                      Expanded(child: ProfileHeader(accountInfo: accountInfo)),
                      Expanded(
                        flex: 2,
                        child: SingleChildScrollView(child: ProfileDetailsSection(accountInfo: accountInfo)),
                      ),
                    ],
                  )
                : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileHeader(accountInfo: accountInfo),
                        ProfileDetailsSection(accountInfo: accountInfo),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
