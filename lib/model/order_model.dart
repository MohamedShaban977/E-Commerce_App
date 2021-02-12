class OrderDetailsModel {
  String oName, oPrice, oDescription, oCategory, oImageLocation, oId;
  int oQuantity, oTotalPrice;

  OrderDetailsModel(
      {this.oName,
      this.oPrice,
      this.oDescription,
      this.oCategory,
      this.oImageLocation,
      this.oId,
      this.oQuantity,
      this.oTotalPrice});
}

class OrderModel {
  String fullName, phone, address, docId;
  int totalPrice, totalQuantity;

  OrderModel(
      {this.address,
      this.totalPrice,
      this.docId,
      this.fullName,
      this.phone,
      this.totalQuantity});
}
