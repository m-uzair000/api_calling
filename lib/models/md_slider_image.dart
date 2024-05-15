class MDSliderImage{
  int? id;
  String? type;
  int? order;
  String? image;

  MDSliderImage({
    this.id,
    this.type,
    this.order,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'type': this.type,
      'order': this.order,
      'image': this.image,
    };
  }

  factory MDSliderImage.fromMap(Map<String, dynamic> map) {
    return MDSliderImage(
      id: map['id'] as int,
      type: map['type'] as String,
      order: map['order'] as int,
      image: map['image'] as String,
    );
  }

  @override
  String toString() {
    return 'MDSliderImage{id: $id, type: $type, order: $order, image: $image}';
  }
}