import 'package:flutter/material.dart';
import 'package:peanut_api_test/features/auth/controller/auth_ctrl.dart';
import 'package:peanut_api_test/features/profile/controller/profile_ctrl.dart';
import 'package:peanut_api_test/features/profile/view/info_tile.dart';
import 'package:peanut_api_test/features/profile/view/profile_header.dart';
import 'package:peanut_api_test/features/profile/view/section.dart';
import 'package:peanut_api_test/main.export.dart';
import 'package:peanut_api_test/models/user/account_info_model.dart';

class ProfileDetailsSection extends HookConsumerWidget {
  const ProfileDetailsSection({super.key, required this.accountInfo});

  final AccountInfoModel accountInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = useMemoized(() => ref.read(authCtrlProvider.notifier));
    final phoneData = ref.watch(phoneDigitCtrlProvider);
    return Column(
      children: [
        Section(
          title: 'Account Details',
          children: [
            phoneData.when(
              loading: () => LoaderBox(height: 40, width: context.width),
              error: (e, s) => const SizedBox.shrink(),
              data: (digits) {
                if (digits == null) return const SizedBox.shrink();
                return InfoTile(Icons.phone, 'Phone Number', digits);
              },
            ),
            InfoTile(Icons.verified_user, 'Verification Level', 'Level ${accountInfo.verificationLevel}'),
            InfoTile(Icons.currency_exchange, 'Currency Code', accountInfo.currency.toString()),
          ],
        ),
        Section(
          title: 'Trading Statistics',
          children: [
            InfoTile(Icons.bar_chart, 'Total Trades', accountInfo.totalTradesCount.compact()),
            InfoTile(Icons.pie_chart, 'Total Volume', accountInfo.totalTradesVolume.toStringAsFixed(2)),
            InfoTile(Icons.timer, 'Open Trades', accountInfo.currentTradesCount.compact()),
          ],
        ),

        Section(
          title: 'Location',
          children: [
            InfoTile(Icons.location_on, 'Address', accountInfo.address),
            InfoTile(Icons.map, 'City/Zip', '${accountInfo.city}, ${accountInfo.zipCode}'),
            InfoTile(Icons.public, 'Country', accountInfo.country),
          ],
        ),
        const Gap(30),
        if (!context.isLandscape)
          Padding(
            padding: Pads.sym(16),
            child: OutlinedButton.icon(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => LogoutDialog(authController: authController),
              ),
              icon: const Icon(Icons.logout),
              label: const Text('Logout from Account'),
              style: OutlinedButton.styleFrom(
                foregroundColor: context.colors.error,
                iconColor: context.colors.error,
                minimumSize: const Size(double.infinity, 44),
                side: BorderSide(color: context.colors.error),
              ),
            ),
          ),
        const Gap(40),
      ],
    );
  }
}
