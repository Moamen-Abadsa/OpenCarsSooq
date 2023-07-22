class Offer {
  String? oldPrice;
  String? newPrice;
  double? percent;

  Offer(this.oldPrice, this.newPrice, this.percent);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oldPrice'] = this.oldPrice;
    data['newPrice'] = this.newPrice;
    data['percent'] = this.percent;
    return data;
  }
}