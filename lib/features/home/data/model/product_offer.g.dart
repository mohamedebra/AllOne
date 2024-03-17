// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_offer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataProductAdapter extends TypeAdapter<DataProduct> {
  @override
  final int typeId = 4;

  @override
  DataProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataProduct(
      id: fields[0] as int?,
      maxCount: fields[3] as double?,
      weight: fields[2] as String?,
      created_at: fields[6] as String?,
      price: fields[1] as double?,
      typeId: fields[4] as int?,
      delivary: fields[5] as int?,
      status: fields[7] as int?,
      createdAt: fields[8] as String?,
      updatedAt: fields[9] as String?,
      title: fields[10] as String?,
      files: (fields[11] as List?)?.cast<Files>(),
      categories: (fields[12] as List?)?.cast<CategoriesData>(),
      types: fields[13] as TypesProduct?,
      translations: (fields[14] as List?)?.cast<TranslationsProduct>(),
    );
  }

  @override
  void write(BinaryWriter writer, DataProduct obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.maxCount)
      ..writeByte(4)
      ..write(obj.typeId)
      ..writeByte(5)
      ..write(obj.delivary)
      ..writeByte(6)
      ..write(obj.created_at)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.title)
      ..writeByte(11)
      ..write(obj.files)
      ..writeByte(12)
      ..write(obj.categories)
      ..writeByte(13)
      ..write(obj.types)
      ..writeByte(14)
      ..write(obj.translations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
