import 'package:autth_injustice_app/core/extensions/responsive_extensions.dart';
import 'package:autth_injustice_app/core/l10n/l10n_extensions.dart';
import 'package:autth_injustice_app/core/theme/app_theme.dart';
import 'package:autth_injustice_app/core/widgets/app_action_button.dart';
import 'package:autth_injustice_app/core/widgets/app_back_button.dart';
import 'package:autth_injustice_app/core/widgets/animations/app_step_entrance_transition.dart';
import 'package:flutter/material.dart';

class AppEditorStepScaffold extends StatefulWidget {
  final bool active;
  final int step;
  final int stepCount;
  final String title;
  final String? subtitle;
  final Widget child;
  final String buttonText;
  final bool loading;
  final VoidCallback onBack;
  final VoidCallback? onNext;

  const AppEditorStepScaffold({
    super.key,
    required this.active,
    required this.step,
    required this.stepCount,
    required this.title,
    required this.child,
    required this.buttonText,
    required this.loading,
    required this.onBack,
    required this.onNext,
    this.subtitle,
  });

  @override
  State<AppEditorStepScaffold> createState() => _AppEditorStepScaffoldState();
}

class _AppEditorStepScaffoldState extends State<AppEditorStepScaffold> {
  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.viewInsetsOf(context).bottom;
    final responsive = context.responsive;
    final horizontalPadding = context.extraPagePadding.left;
    final titleSize = responsive.scaled(34, min: 27, max: 38);

    return ColoredBox(
      color: context.tertiary,
      child: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    2,
                    horizontalPadding,
                    0,
                  ),
                  child: Row(
                    children: [
                      AppBackButton(
                        onPressed: widget.onBack,
                        foregroundColor: context.onTertiary,
                      ),
                      const Spacer(),
                      Text(
                        context.l10n.editorStep(
                          widget.step + 1,
                          widget.stepCount,
                        ),
                        style: context.text.labelMedium?.copyWith(
                          color: context.onTertiary.withValues(alpha: 0.54),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    8,
                    horizontalPadding,
                    0,
                  ),
                  child: _StepProgress(
                    currentStep: widget.step,
                    stepCount: widget.stepCount,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      responsive.scaled(34, min: 22, max: 42),
                      horizontalPadding,
                      keyboardHeight + 112,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppStepEntranceTransition(
                          active: widget.active,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                widget.title,
                                style: context.text.headlineLarge?.copyWith(
                                  color: context.onTertiary,
                                  fontSize: titleSize,
                                ),
                              ),
                              if (widget.subtitle case final subtitle?) ...[
                                const SizedBox(height: 10),
                                Text(
                                  subtitle,
                                  style: context.text.bodyMedium?.copyWith(
                                    color: context.onTertiary.withValues(
                                      alpha: 0.56,
                                    ),
                                    height: 1.45,
                                  ),
                                ),
                              ],
                              SizedBox(
                                height: responsive.scaled(34, min: 24, max: 42),
                              ),
                            ],
                          ),
                        ),
                        AppStepEntranceTransition(
                          active: widget.active,
                          child: widget.child,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              maintainBottomViewPadding: true,
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  14,
                  horizontalPadding,
                  16,
                ),
                child: AppStepEntranceTransition(
                  active: widget.active,
                  motion: AppStepEntranceMotion.action,
                  child: AppActionButton(
                    text: widget.buttonText,
                    color: context.secondary,
                    foregroundColor: context.onSecondary,
                    isLoading: widget.loading,
                    onPressed: widget.loading || widget.onNext == null
                        ? null
                        : widget.onNext,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepProgress extends StatelessWidget {
  final int currentStep;
  final int stepCount;

  const _StepProgress({
    required this.currentStep,
    required this.stepCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        stepCount,
        (index) => Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            height: index == currentStep ? 4 : 3,
            margin: EdgeInsets.only(right: index == stepCount - 1 ? 0 : 5),
            decoration: BoxDecoration(
              color: index <= currentStep
                  ? context.secondary
                  : context.onTertiary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(99),
              boxShadow: index == currentStep
                  ? [
                      BoxShadow(
                        color: context.secondary.withValues(alpha: 0.30),
                        blurRadius: 8,
                      ),
                    ]
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
