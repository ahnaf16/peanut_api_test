import 'package:flutter/material.dart';
import 'package:peanut_api_test/features/auth/controller/auth_ctrl.dart';
import 'package:peanut_api_test/features/profile/controller/profile_ctrl.dart';
import 'package:peanut_api_test/main.export.dart';
import 'package:peanut_api_test/models/user/account_info_model.dart';

// Profile Screen
class ProfileView extends HookConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(accountInfoCtrlProvider);
    final phoneData = ref.watch(phoneDigitCtrlProvider);
    final authController = useMemoized(() => ref.read(authCtrlProvider.notifier));

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
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
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Flex(
                crossAxisAlignment: CrossAxisAlignment.start,
                direction: context.isLandscape ? Axis.horizontal : Axis.vertical,
                children: [
                  _buildHeader(accountInfo, authController),
                  Column(
                    children: [
                      _buildSection('Account Details', [
                        phoneData.when(
                          loading: () => LoaderBox(height: 40, width: context.width),
                          error: (e, s) => const SizedBox.shrink(),
                          data: (digits) {
                            if (digits == null) return const SizedBox.shrink();
                            return _InfoTile(Icons.phone, 'Phone Number', digits);
                          },
                        ),
                        _InfoTile(Icons.verified_user, 'Verification Level', 'Level ${accountInfo.verificationLevel}'),
                        _InfoTile(Icons.currency_exchange, 'Currency Code', accountInfo.currency.toString()),
                      ]),
                      _buildSection('Trading Statistics', [
                        _InfoTile(Icons.bar_chart, 'Total Trades', accountInfo.totalTradesCount.compact()),
                        _InfoTile(Icons.pie_chart, 'Total Volume', accountInfo.totalTradesVolume.toStringAsFixed(2)),
                        _InfoTile(Icons.timer, 'Open Trades', accountInfo.currentTradesCount.compact()),
                      ]),
                      _buildSection('Location', [
                        _InfoTile(Icons.location_on, 'Address', accountInfo.address),
                        _InfoTile(Icons.map, 'City/Zip', '${accountInfo.city}, ${accountInfo.zipCode}'),
                        _InfoTile(Icons.public, 'Country', accountInfo.country),
                      ]),
                      const Gap(30),
                      if (!context.isLandscape)
                        Padding(
                          padding: Pads.sym(16),
                          child: OutlinedButton.icon(
                            onPressed: () => _showLogoutDialog(context, authController),
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
                  ).conditionalExpanded(context.isLandscape),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(AccountInfoModel info, AuthCtrl authController) {
    return Builder(
      builder: (context) {
        return DecoContainer(
          width: context.isLandscape ? context.width * .3 : double.infinity,

          padding: Pads.lg(),
          child: Column(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: context.colors.primary.op3,
                child: Text(
                  info.name.isNotEmpty ? info.name[0] : '?',
                  style: const TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              const Gap(Insets.sm),
              Text(info.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text(
                "Account Type: ${info.type == 0 ? 'Standard' : 'Partner'}",
                style: TextStyle(color: Colors.grey.shade600),
              ),

              if (context.isLandscape) ...[
                const Gap(Insets.lg),
                OutlinedButton.icon(
                  onPressed: () => _showLogoutDialog(context, authController),
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
      },
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: Pads.sym(16, 12),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
        Card(
          margin: Pads.sym(16),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context, dynamic authController) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile(this.icon, this.label, this.value);

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 20, color: context.colors.primary.op7),
      title: Text(label, style: TextStyle(fontSize: 12, color: context.colors.secondary)),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
          fontFamily: 'monospace',
        ),
      ),
      dense: true,
    );
  }
}
