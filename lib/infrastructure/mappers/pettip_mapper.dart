import 'package:petto_app/domain/entities/pettip.dart';

class PettipMapper {
  static Pettip localPettipToEntity(json) => Pettip(
        asset: json['asset'],
        title: json['title'],
        tip: json['tip'],
      );
}
