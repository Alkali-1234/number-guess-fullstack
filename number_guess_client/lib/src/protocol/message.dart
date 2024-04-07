/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// Custom Specific Messages that may be sent
abstract class Message extends _i1.SerializableEntity {
  Message._({required this.message});

  factory Message({required String message}) = _MessageImpl;

  factory Message.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Message(
        message: serializationManager
            .deserialize<String>(jsonSerialization['message']));
  }

  String message;

  Message copyWith({String? message});
  @override
  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}

class _MessageImpl extends Message {
  _MessageImpl({required String message}) : super._(message: message);

  @override
  Message copyWith({String? message}) {
    return Message(message: message ?? this.message);
  }
}
