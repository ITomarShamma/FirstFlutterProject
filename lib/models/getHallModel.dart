///gethall
///
///POST http://127.0.0.1:8000/api/user/gethall
class Gethall {
  final bool? success;
  final String? message;
  final List<GethallDatum>? data;
  final dynamic erros;
  final int? status;

  Gethall({
    this.success,
    this.message,
    this.data,
    this.erros,
    this.status,
  });
  factory Gethall.fromJson(Map<String, dynamic> json) => Gethall(
        success: json['success'] as bool?,
        message: json['message'] as String?,
        data: List<GethallDatum>.from(
          json['data'].map((x) => GethallDatum.fromJson(x)),
        ),
        erros: json[
            'erros'], // You might need to handle this based on your API response structure
        status: json['status'] as int?,
      );
}

class GethallDatum {
  final int? id;
  final String? name;
  final int? price;
  final int? budgetId;
  final dynamic createdAt;
  final dynamic updatedAt;

  GethallDatum({
    this.id,
    this.name,
    this.price,
    this.budgetId,
    this.createdAt,
    this.updatedAt,
  });
  factory GethallDatum.fromJson(Map<String, dynamic> json) => GethallDatum(
        id: json['id'] as int?,
        name: json['name'] as String?,
        price: json['price'] as int?,
        budgetId: json['budgetId'] as int?,
        createdAt: json['createdAt'], // You might need to handle dynamic types
        updatedAt: json['updatedAt'], // You might need to handle dynamic types
      );
}
