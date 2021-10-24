class Assets {
  static final svgs = _SVGs._();
  static final images = _Images._();

  Assets._();
}

class _SVGs {
  _SVGs._();

  String get battery => 'assets/svgs/battery.svg';

  String get car => 'assets/svgs/car.svg';

  String get charge => 'assets/svgs/charge.svg';

  String get coolShape => 'assets/svgs/cool_shape.svg';

  String get flTyre => 'assets/svgs/fl_tyre.svg';

  String get heatShape => 'assets/svgs/heat_shape.svg';

  String get lockRounded => 'assets/svgs/lock_rounded.svg';

  String get lock => 'assets/svgs/lock.svg';

  String get temp => 'assets/svgs/temp.svg';

  String get tyre => 'assets/svgs/tyre.svg';

  String get unlockRounded => 'assets/svgs/unlock_rounded.svg';
}

class _Images {
  _Images._();

  String get coolGlow => 'assets/images/cool_glow.png';

  String get hotGlow => 'assets/images/hot_glow.png';
}
