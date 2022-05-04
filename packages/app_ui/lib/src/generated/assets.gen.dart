/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/app_logo.svg
  SvgGenImage get appLogo => const SvgGenImage('assets/icons/app_logo.svg');

  /// File path: assets/icons/drag-icon.svg
  SvgGenImage get dragIcon => const SvgGenImage('assets/icons/drag-icon.svg');

  /// File path: assets/icons/ic-add.svg
  SvgGenImage get icAdd => const SvgGenImage('assets/icons/ic-add.svg');

  /// File path: assets/icons/ic-added.svg
  SvgGenImage get icAdded => const SvgGenImage('assets/icons/ic-added.svg');

  /// File path: assets/icons/ic-back.svg
  SvgGenImage get icBack => const SvgGenImage('assets/icons/ic-back.svg');

  /// File path: assets/icons/ic-checkmark.svg
  SvgGenImage get icCheckmark =>
      const SvgGenImage('assets/icons/ic-checkmark.svg');

  /// File path: assets/icons/ic-chevron-right.svg
  SvgGenImage get icChevronRight =>
      const SvgGenImage('assets/icons/ic-chevron-right.svg');

  /// File path: assets/icons/ic-close.svg
  SvgGenImage get icClose => const SvgGenImage('assets/icons/ic-close.svg');

  /// File path: assets/icons/ic-distance-done.svg
  SvgGenImage get icDistanceDone =>
      const SvgGenImage('assets/icons/ic-distance-done.svg');

  /// File path: assets/icons/ic-duration.svg
  SvgGenImage get icDuration =>
      const SvgGenImage('assets/icons/ic-duration.svg');

  /// File path: assets/icons/ic-edit.svg
  SvgGenImage get icEdit => const SvgGenImage('assets/icons/ic-edit.svg');

  /// File path: assets/icons/ic-favorite.svg
  SvgGenImage get icFavorite =>
      const SvgGenImage('assets/icons/ic-favorite.svg');

  /// File path: assets/icons/ic-filter.svg
  SvgGenImage get icFilter => const SvgGenImage('assets/icons/ic-filter.svg');

  /// File path: assets/icons/ic-history.svg
  SvgGenImage get icHistory => const SvgGenImage('assets/icons/ic-history.svg');

  /// File path: assets/icons/ic-minus.svg
  SvgGenImage get icMinus => const SvgGenImage('assets/icons/ic-minus.svg');

  /// File path: assets/icons/ic-play.svg
  SvgGenImage get icPlay => const SvgGenImage('assets/icons/ic-play.svg');

  /// File path: assets/icons/ic-plus-big.svg
  SvgGenImage get icPlusBig =>
      const SvgGenImage('assets/icons/ic-plus-big.svg');

  /// File path: assets/icons/ic-plus.svg
  SvgGenImage get icPlus => const SvgGenImage('assets/icons/ic-plus.svg');

  /// File path: assets/icons/ic-rest-time.svg
  SvgGenImage get icRestTime =>
      const SvgGenImage('assets/icons/ic-rest-time.svg');

  /// File path: assets/icons/ic-search.svg
  SvgGenImage get icSearch => const SvgGenImage('assets/icons/ic-search.svg');

  /// File path: assets/icons/ic-time.svg
  SvgGenImage get icTime => const SvgGenImage('assets/icons/ic-time.svg');

  /// File path: assets/icons/ic-timer.svg
  SvgGenImage get icTimer => const SvgGenImage('assets/icons/ic-timer.svg');

  /// File path: assets/icons/ic-tonnage-lifted.svg
  SvgGenImage get icTonnageLifted =>
      const SvgGenImage('assets/icons/ic-tonnage-lifted.svg');

  /// File path: assets/icons/ic-userpic.svg
  SvgGenImage get icUserpic => const SvgGenImage('assets/icons/ic-userpic.svg');

  /// File path: assets/icons/ic-weigh.svg
  SvgGenImage get icWeigh => const SvgGenImage('assets/icons/ic-weigh.svg');

  /// File path: assets/icons/ic-workouts-completed.svg
  SvgGenImage get icWorkoutsCompleted =>
      const SvgGenImage('assets/icons/ic-workouts-completed.svg');
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName, package: 'app_ui');

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package = 'app_ui',
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    bool cacheColorFilter = false,
    SvgTheme? theme,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
      theme: theme,
    );
  }

  String get path => _assetName;
}
