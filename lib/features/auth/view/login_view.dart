import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:peanut_api_test/features/auth/controller/auth_ctrl.dart';
import 'package:peanut_api_test/main.export.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authCtrl = useMemoized(() => ref.read(authCtrlProvider.notifier));
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final remember = useState(false);

    return Scaffold(
      // 1. LayoutBuilder gives us the constraints of the screen
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            // Use BouncingScrollPhysics for a more "Production" feel
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              // 2. Ensure the content is at least as tall as the screen to keep things centered
              constraints: BoxConstraints(minHeight: constraints.maxHeight, minWidth: constraints.maxWidth),
              child: Padding(
                padding: Pads.med().copyWith(top: context.padding.top),
                child: FormBuilder(
                  key: formKey,
                  initialValue: authCtrl.getSavedLoginData(),
                  child: Flex(
                    direction: context.isLandscape ? Axis.horizontal : Axis.vertical,
                    // Center content on both axes
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: context.isLandscape ? Insets.xl : Insets.lg,
                    children: [
                      // --- WELCOME SECTION ---
                      _buildWelcomeSection(context).conditionalExpanded(context.isLandscape),

                      // --- FORM SECTION ---
                      _buildFormSection(context, formKey, remember, authCtrl).conditionalExpanded(context.isLandscape),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return DecoContainer(
      padding: context.isLandscape ? Pads.all(Insets.lg) : Pads.zero,
      color: context.isLandscape ? context.colors.primaryContainer.op(0.05) : null,
      borderRadius: Corners.med,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_balance_wallet, size: 55, color: context.colors.primary),
          const Gap(Insets.med),
          Text('Welcome back', textAlign: TextAlign.center, style: context.text.headlineSmall?.bold),
          const Gap(Insets.xs),
          Text(
            'Sign in to manage your trades',
            textAlign: TextAlign.center,
            style: context.text.bodyLarge?.medium.outline,
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection(
    BuildContext context,
    GlobalKey<FormBuilderState> formKey,
    ValueNotifier<bool> remember,
    AuthCtrl authCtrl,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: .start,
      children: [
        const KTextField(
          name: 'login',
          title: 'Login Code',
          hintText: 'Enter your login code',
          prefixIcon: Icon(LIcon.notebook),
          keyboardType: TextInputType.number,
        ),
        const Gap(Insets.lg),
        const KTextField(
          name: 'password',
          title: 'Password',
          hintText: 'Enter your password',
          isPasswordField: true,
          prefixIcon: Icon(LIcon.lock),
        ),
        const Gap(Insets.sm),
        GestureDetector(
          onTap: () => remember.value = !remember.value,
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                remember.value ? Icons.check_box : Icons.check_box_outline_blank,
                color: remember.value ? context.colors.primary : null,
                size: 20,
              ),
              const Gap(Insets.sm),
              Text(
                'Remember me',
                style: context.text.labelLarge?.textColor(remember.value ? context.colors.primary : null),
              ),
            ],
          ),
        ),
        const Gap(Insets.xl),
        SubmitButton(
          label: 'Sign In',
          expanded: true,
          onPressed: (l) async {
            final state = formKey.currentState!;
            if (!state.saveAndValidate()) return;

            l.truthy();
            try {
              await authCtrl.login(state.value, remember.value);
            } finally {
              l.falsey();
            }
          },
        ),
        const Gap(Insets.lg),
        Center(
          child: Text(
            'By signing in, you agree to our Terms & Privacy Policy',
            textAlign: TextAlign.center,
            style: context.text.bodySmall?.outline,
          ),
        ),
      ],
    );
  }
}
