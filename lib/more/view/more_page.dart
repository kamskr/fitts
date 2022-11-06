import 'package:app_ui/app_ui.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:fitts/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template more_page}
/// More page view.
/// {@endtemplate}
class MorePage extends StatelessWidget {
  /// {@macro more_page}
  const MorePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppBloc>().state;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _AppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  height: 1,
                ),
                const AppGap.md(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Text(
                    'CURRENT FOCUS',
                    style: context.textTheme.caption,
                  ),
                ),
                const AppGap.md(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      gradient: context.appColorScheme.primaryGradient2,
                      borderRadius: BorderRadius.circular(AppSpacing.xxs),
                    ),
                    child: Text(
                      'Strength',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: context.colorScheme.onPrimary),
                    ),
                  ),
                ),
                const AppGap.md(),
                const Divider(height: 1),
              ],
            ),
          ),
          const _ActiveRoutine(),
          const _Redirects(),
          const _SignOutButton(),
        ],
      ),
    );
  }
}

class _ActiveRoutine extends StatelessWidget {
  const _ActiveRoutine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const percentDone = .3;

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            height: 1,
          ),
          const AppGap.md(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Text(
              'ACTIVE ROUTINE',
              style: context.textTheme.caption,
            ),
          ),
          const AppGap.md(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: context.appColorScheme.primaryGradient2,
                borderRadius: BorderRadius.circular(AppSpacing.xxs),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    top: 0,
                    left: 0,
                    right: 0,
                    child: LayoutBuilder(
                      builder: (context, constraints) => Row(
                        children: [
                          Container(
                            color: context.appColorScheme.primary900
                                .withOpacity(0.4),
                            height: double.infinity,
                            width: constraints.maxWidth * percentDone,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Week: 1',
                          style: context.textTheme.caption!.copyWith(
                            color:
                                context.colorScheme.onPrimary.withOpacity(.8),
                          ),
                        ),
                        const AppGap.xxs(),
                        Text(
                          '${percentDone * 100}% done',
                          style: context.textTheme.caption!.copyWith(
                            color:
                                context.colorScheme.onPrimary.withOpacity(.8),
                          ),
                        ),
                        const AppGap.md(),
                        Text(
                          'Routione name',
                          style: context.textTheme.headline5!.copyWith(
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                        const AppGap.md(),
                        Text(
                          'By: Kamil Sikora',
                          style: context.textTheme.caption!.copyWith(
                            color:
                                context.colorScheme.onPrimary.withOpacity(.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const AppGap.md(),
        ],
      ),
    );
  }
}

class _Redirects extends StatelessWidget {
  const _Redirects({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppGap.md(),
          ColoredBox(
            color: context.colorScheme.onPrimary,
            child: ListTile(
              title: Text(
                'Routines',
                style: context.textTheme.bodyText1,
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
          const Divider(height: 1),
          ColoredBox(
            color: context.colorScheme.onPrimary,
            child: ListTile(
              title: Text(
                'Progress',
                style: context.textTheme.bodyText1,
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
          const Divider(height: 1),
          ColoredBox(
            color: context.colorScheme.onPrimary,
            child: ListTile(
              title: Text(
                'Settings',
                style: context.textTheme.bodyText1,
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _SignOutButton extends StatelessWidget {
  const _SignOutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: AppTextButton(
          textColor: context.colorScheme.error,
          child: const Text('Sign out'),
          onPressed: () => context.read<AuthenticationClient>().signOut(),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppBloc>().state;
    final photoUrl = state.userProfile.photoUrl.replaceAll('s96-c', 's400-c');

    return SliverAppBar(
      expandedHeight: 260,
      pinned: true,
      backgroundColor: context.appColorScheme.primary,
      actions: [
        AppTextButton(
          textColor: context.colorScheme.onPrimary,
          onPressed: () {},
          child: const Text('Edit'),
        ),
      ],
      flexibleSpace: DecoratedBox(
        decoration: BoxDecoration(
          gradient: context.appColorScheme.primaryGradient2,
        ),
        child: FlexibleSpaceBar(
          background: Stack(
            children: [
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      width: 210,
                      height: 170,
                      child: photoUrl != ''
                          ? Image.network(
                              photoUrl,
                              fit: BoxFit.cover,
                            )
                          : Assets.icons.emptyProfileImage.svg(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.userProfile.displayName,
                style: TextStyle(
                  color: context.colorScheme.onPrimary,
                ),
              ),
              Text(
                state.userProfile.email,
                style: context.textTheme.caption!.copyWith(
                  color: context.colorScheme.onPrimary.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
