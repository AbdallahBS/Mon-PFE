// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_intership_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataIntershipModelAdapter extends TypeAdapter<DataIntershipModel> {
  @override
  final int typeId = 1;

  @override
  DataIntershipModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataIntershipModel(
      name: fields[0] as String,
      location: fields[1] as String,
      description: fields[2] as String,
      shortdescription: fields[3] as String,
      sujet: fields[4] as String,
      images: (fields[5] as List).cast<String>(),
      linkDin: fields[6] as String,
      pfeBook2023: fields[7] as String,
      pfeBook2024: fields[8] as String,
      web: fields[9] as String,
      email: fields[10] as String,
      long: fields[11] as String,
      lat: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DataIntershipModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.location)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.shortdescription)
      ..writeByte(4)
      ..write(obj.sujet)
      ..writeByte(5)
      ..write(obj.images)
      ..writeByte(6)
      ..write(obj.linkDin)
      ..writeByte(7)
      ..write(obj.pfeBook2023)
      ..writeByte(8)
      ..write(obj.pfeBook2024)
      ..writeByte(9)
      ..write(obj.web)
      ..writeByte(10)
      ..write(obj.email)
      ..writeByte(11)
      ..write(obj.long)
      ..writeByte(12)
      ..write(obj.lat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataIntershipModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
