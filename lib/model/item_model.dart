final String tableItems = 'items';

class ItemFields {
  static final List<String> values = [
    itemId, itemName, barcode
  ];

  static final String itemId = 'ItemID';
  static final String itemName = 'ItemName';
  static final String barcode = 'Barcode';
}

class Item {
  final int? itemId;
  final String? itemName;
  final String? barcode;

  const Item({
    this.itemId,
    this.itemName,
    this.barcode,
  });

  Item copy({
  int? itemId,
    String? itemName,
    String? barcode,
}) =>
  Item(
    itemId: itemId ?? this.itemId,
    itemName: itemName ?? this.itemName,
    barcode: barcode ?? this.barcode,
  );

  static Item fromJson(Map<String, Object?> json) => Item(
    itemId: json[ItemFields.itemId] as int?,
    itemName: json[ItemFields.itemName] as String?,
    barcode: json[ItemFields.barcode] as String?,
  );

  Map<String, Object?> toJson() => {
    ItemFields.itemId: itemId,
    ItemFields.itemName: itemName,
    ItemFields.barcode: barcode,
  };
}
