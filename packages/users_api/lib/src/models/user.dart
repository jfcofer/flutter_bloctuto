import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:users_api/src/models/json_map.dart';
import 'package:uuid/uuid.dart';

part 'user.g.dart';

///{@template user_item}
///Clase para el objeto [User].
///
///Contiene un [id], [name], y [email]
///
///Si un id es dado al constructur, no puede ser vacío, y si no
///se especifica, se crea automáticamente.
///
///
///{@endtemplate}
@immutable
@JsonSerializable()
class User extends Equatable {
  ///{@macro user_item}
  User({required this.name, required this.email, String? id})
      : assert(
          id == null || id.isNotEmpty,
          'id must either be null or not empty',
        ),
        id = id ?? const Uuid().v8();

  /// Deserializa un [JsonMap] en un [User]
  factory User.fromJson(JsonMap json) => _$UserFromJson(json);

  /// Convierte un [User] en un [JsonMap]
  JsonMap toJson() => _$UserToJson(this);

  ///Devuelve una copia de este 'usuario' con los nuevos valores dados
  ///
  ///{@macro user_item}
  User copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  ///El identificador del 'usuario'
  ///
  ///No puede ser vacío
  final String id;

  ///El nombre del usuario
  final String name;

  ///El email del usuario
  final String email;

  @override
  List<Object?> get props => [id, name, email];
}
