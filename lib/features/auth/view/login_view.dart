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
    return Scaffold(
      body: Padding(
        padding: Pads.med(),
        child: FormBuilder(
          key: formKey,
          initialValue: const {'login': '2088888', 'password': 'ral11lod'},
          child: Column(
            children: [
              Gap(context.padding.top + 6),
              const Spacer(),

              Text('Welcome back', style: context.text.headlineSmall),
              const Gap(Insets.sm),
              Text('Sign in to continue', style: context.text.bodyLarge?.medium),
              const Gap(Insets.lg),

              const Spacer(),

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
                prefixIcon: Icon(LIcon.lock),
              ),

              const Spacer(flex: 3),

              SubmitButton(
                label: 'Sign In',
                expanded: true,
                onPressed: (l) async {
                  final state = formKey.currentState!;
                  if (!state.saveAndValidate()) return;

                  l.truthy();
                  await authCtrl.login(state.value);
                },
              ),

              const Gap(Insets.med),
              Text('By signing in, you agree to our Terms & Privacy Policy', style: context.text.bodySmall?.outline),
              const Gap(Insets.med),
            ],
          ),
        ),
      ),
    );
  }
}
