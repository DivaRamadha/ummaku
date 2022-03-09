// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemeResourceAdapter extends TypeAdapter<ThemeResource> {
  @override
  final int typeId = 1;

  @override
  ThemeResource read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ThemeResource(
      status: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ThemeResource obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeResourceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
