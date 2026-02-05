import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:post_wagens/main.export.dart';
import 'package:post_wagens/models/user/user_model.dart';
import 'package:textf/textf.dart';

class AuthVerificationView extends HookConsumerWidget {
  const AuthVerificationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = useState(AuthState.unverified);
    return Scaffold(
      appBar: AppBar(title: Text(status.value.isSuspended ? 'Security Lockout' : 'Verification')),
      body: Center(
        child: Padding(
          padding: Pads.lg(),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              UImage(
                status.value.isVerified ? MdiIcons.accountCheck : MdiIcons.accountCancel,
                dimension: 80,
                iconSize: 40,
                borderRadius: 999,
                color: status.value.isVerified ? context.xColors.success : context.colors.primary,
                backgroundColor: status.value.isVerified
                    ? context.xColors.successContainer
                    : context.colors.primaryContainer,
              ),
              const Gap(Insets.med),
              Text(
                status.value.titleText(),
                style: context.text.titleMedium?.semiBold.textColor(
                  status.value.isVerified ? context.xColors.success : context.colors.primary,
                ),
              ),
              const Gap(Insets.sm),
              Text(status.value.subtitleText(), textAlign: .center),
              if (!status.value.isSuspended) ...[
                const Gap(Insets.med),
                DecoContainer(
                  padding: Pads.sym(12, 6),
                  borderRadius: 999,
                  color: status.value.isVerified ? context.xColors.successContainer : context.xColors.warningContainer,
                  child: Row(
                    spacing: Insets.sm,
                    mainAxisSize: .min,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 13,
                        color: status.value.isVerified ? context.xColors.success : context.xColors.warning,
                      ),
                      Textf(
                        '**Status:** ${status.value.name.titleCase}',
                        style: context.text.bodyMedium?.textColor(
                          status.value.isVerified ? context.xColors.success : context.xColors.warning,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              if (!status.value.isSuspended) ...[
                const Gap(Insets.lg),
                SubmitButton(label: 'Continue to Dashboard', expanded: true, onPressed: (l) {}),
              ],
              const Gap(Insets.lg),
              SubmitButton(label: 'Contact Support', type: .outlined, onPressed: (l) {}, expanded: true),

              const Gap(Insets.xs),
              if (!status.value.isSuspended) ...[
                const Gap(Insets.xs),
                TextButton(onPressed: () => context.pop(), child: const Text('Wrong email address?')),
              ] else
                const Gap(Insets.sm),

              Text(
                status.value.isSuspended
                    ? 'Having trouble? Our support team is here to help you recover your account.'
                    : 'Verify your email to unlock dashboard access',
                style: context.text.bodySmall?.outline,
                textAlign: .center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
