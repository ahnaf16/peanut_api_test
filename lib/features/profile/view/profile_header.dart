import 'package:flutter/material.dart';
import 'package:peanut_api_test/features/auth/controller/auth_ctrl.dart';
import 'package:peanut_api_test/main.export.dart';
import 'package:peanut_api_test/models/user/account_info_model.dart';

class ProfileHeader extends HookConsumerWidget {
  const ProfileHeader({super.key, required this.accountInfo});

  final AccountInfoModel accountInfo;
  @override
  Widget build(BuildContext context, ref) {
    final authController = useMemoized(() => ref.read(authCtrlProvider.notifier));
    return DecoContainer(
      width: double.infinity,
      padding: Pads.lg(),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: context.colors.primary.op3,
            child: Text(
              accountInfo.name.isNotEmpty ? accountInfo.name[0] : '?',
              style: const TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          const Gap(Insets.sm),
          Text(accountInfo.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SpacedText(
            left: 'Balance',
            right: accountInfo.balance.currency(),
            centered: true,
            styleBuilder: (l, r) => (l, r.primary.bold),
          ),

          if (context.isLandscape) ...[
            const Spacer(),
            const Gap(Insets.lg),
            OutlinedButton.icon(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => LogoutDialog(authController: authController),
              ),
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: OutlinedButton.styleFrom(
                foregroundColor: context.colors.error,
                iconColor: context.colors.error,
                minimumSize: const Size(double.infinity, 44),
                side: BorderSide(color: context.colors.error),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key, required this.authController});

  final AuthCtrl authController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Logout'),
      content: const Text('Are you sure you want to log out?'),
      actions: [
        TextButton(onPressed: () => context.nPop(), child: const Text('Cancel')),
        TextButton(
          onPressed: () {
            context.nPop();
            authController.logout();
          },
          child: Text('Logout', style: TextStyle(color: context.colors.error)),
        ),
      ],
    );
  }
}
