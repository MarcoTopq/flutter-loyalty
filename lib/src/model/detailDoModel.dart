import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:warnakaltim/main.dart';

// To parse this JSON data, do
//
//     final detailDoAgen = detailDoAgenFromJson(jsonString);

import 'dart:convert';

DetailDoAgen detailDoAgenFromJson(String str) => DetailDoAgen.fromJson(json.decode(str));

String detailDoAgenToJson(DetailDoAgen data) => json.encode(data.toJson());

class DetailDoAgen {
    DetailDoAgen({
        this.id,
        this.salesOrderNumber,
        this.customer,
        this.customerId,
        this.agenId,
        this.agen,
        this.createdAt,
        this.updatedAt,
        this.deliveryOrders,
    });

    int id;
    String salesOrderNumber;
    String customer;
    int customerId;
    int agenId;
    String agen;
    String createdAt;
    String updatedAt;
    List<DeliveryOrder> deliveryOrders;

    factory DetailDoAgen.fromJson(Map<String, dynamic> json) => DetailDoAgen(
        id: json["id"],
        salesOrderNumber: json["sales_order_number"],
        customer: json["customer"],
        customerId: json["customer_id"],
        agenId: json["agen_id"],
        agen: json["agen"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deliveryOrders: List<DeliveryOrder>.from(json["delivery_orders"].map((x) => DeliveryOrder.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sales_order_number": salesOrderNumber,
        "customer": customer,
        "customer_id": customerId,
        "agen_id": agenId,
        "agen": agen,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "delivery_orders": List<dynamic>.from(deliveryOrders.map((x) => x.toJson())),
    };
}

class DeliveryOrder {
    DeliveryOrder({
        this.id,
        this.deliveryOrderNumber,
        this.effectiveDateStart,
        this.effectiveDateEnd,
        this.product,
        this.quantity,
        this.shippedWith,
        this.shippedVia,
        this.noVehicles,
        this.kmStart,
        this.kmEnd,
        this.sgMeter,
        this.topSeal,
        this.bottomSeal,
        this.temperature,
        this.departureTime,
        this.arrivalTime,
        this.unloadingStartTime,
        this.unloadingEndTime,
        this.departureTimeDepot,
        this.status,
        this.salesOrderId,
        this.driver,
        this.bast,
        this.piece,
        this.depot,
        this.quantityText,
        this.doDate,
        this.detailAddress,
        this.transportir,
        this.distribution,
        this.adminName,
        this.knowing,
        this.qrcode,
    });

    int id;
    String deliveryOrderNumber;
    String effectiveDateStart;
    String effectiveDateEnd;
    String product;
    int quantity;
    String shippedWith;
    String shippedVia;
    String noVehicles;
    int kmStart;
    String kmEnd;
    String sgMeter;
    String topSeal;
    String bottomSeal;
    String temperature;
    String departureTime;
    String arrivalTime;
    dynamic unloadingStartTime;
    DateTime unloadingEndTime;
    dynamic departureTimeDepot;
    String status;
    int salesOrderId;
    Driver driver;
    List<dynamic> bast;
    String piece;
    String depot;
    String quantityText;
    String doDate;
    String detailAddress;
    String transportir;
    String distribution;
    String adminName;
    String knowing;
    String qrcode;

    factory DeliveryOrder.fromJson(Map<String, dynamic> json) => DeliveryOrder(
        id: json["id"],
        deliveryOrderNumber: json["delivery_order_number"],
        effectiveDateStart: json["effective_date_start"],
        effectiveDateEnd: json["effective_date_end"],
        product: json["product"],
        quantity: json["quantity"],
        shippedWith: json["shipped_with"],
        shippedVia: json["shipped_via"],
        noVehicles: json["no_vehicles"],
        kmStart: json["km_start"],
        kmEnd: json["km_end"],
        sgMeter: json["sg_meter"] == null ? null : json["sg_meter"],
        topSeal: json["top_seal"],
        bottomSeal: json["bottom_seal"],
        temperature: json["temperature"],
        departureTime: json["departure_time"],
        arrivalTime: json["arrival_time"] == null ? null : json["arrival_time"],
        unloadingStartTime: json["unloading_start_time"],
        unloadingEndTime: json["unloading_end_time"] == null ? null : DateTime.parse(json["unloading_end_time"]),
        departureTimeDepot: json["departure_time_depot"],
        status: json["status"],
        salesOrderId: json["sales_order_id"],
        driver: Driver.fromJson(json["driver"]),
        bast: List<dynamic>.from(json["bast"].map((x) => x)),
        piece: json["piece"],
        depot: json["depot"],
        quantityText: json["quantity_text"],
        doDate: json["do_date"],
        detailAddress: json["detail_address"],
        transportir: json["transportir"] == null ? null : json["transportir"],
        distribution: json["distribution"],
        adminName: json["admin_name"],
        knowing: json["knowing"],
        qrcode: json["qrcode"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "delivery_order_number": deliveryOrderNumber,
        "effective_date_start": effectiveDateStart,
        "effective_date_end": effectiveDateEnd,
        "product": product,
        "quantity": quantity,
        "shipped_with": shippedWith,
        "shipped_via": shippedVia,
        "no_vehicles": noVehicles,
        "km_start": kmStart,
        "km_end": kmEnd,
        "sg_meter": sgMeter == null ? null : sgMeter,
        "top_seal": topSeal,
        "bottom_seal": bottomSeal,
        "temperature": temperature,
        "departure_time": departureTime,
        "arrival_time": arrivalTime == null ? null : arrivalTime,
        "unloading_start_time": unloadingStartTime,
        "unloading_end_time": unloadingEndTime == null ? null : unloadingEndTime.toIso8601String(),
        "departure_time_depot": departureTimeDepot,
        "status": status,
        "sales_order_id": salesOrderId,
        "driver": driver.toJson(),
        "bast": List<dynamic>.from(bast.map((x) => x)),
        "piece": piece,
        "depot": depot,
        "quantity_text": quantityText,
        "do_date": doDate,
        "detail_address": detailAddress,
        "transportir": transportir == null ? null : transportir,
        "distribution": distribution,
        "admin_name": adminName,
        "knowing": knowing,
        "qrcode": qrcode,
    };
}

class Driver {
    Driver({
        this.id,
        this.name,
        this.address,
        this.phone,
        this.avatar,
        this.route,
        this.userId,
        this.agenId,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String name;
    String address;
    String phone;
    String avatar;
    int route;
    int userId;
    int agenId;
    String createdAt;
    String updatedAt;

    factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        avatar: json["avatar"],
        route: json["route"],
        userId: json["user_id"],
        agenId: json["agen_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "phone": phone,
        "avatar": avatar,
        "route": route,
        "user_id": userId,
        "agen_id": agenId,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class DetailDoAgenModel with ChangeNotifier {
  List<DetailDoAgen> _listDetailDoAgen = [];
  List filteredDetailDoAgen = new List();
  List<DetailDoAgen> get listDetailDoAgen {
    return [..._listDetailDoAgen];
  }

  Future<void> fetchDataDetailDoAgen(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('Token');
    final response = await http
        .get(Uri.encodeFull(urls + '/api/salesorder/' + id), headers: {
      "Accept": "application/JSON",
      "Authorization": 'Bearer ' + token
    });
    if (response.statusCode == 200) {
      var convertData = jsonDecode(response.body);
      final List<DetailDoAgen> newData = [];
      var data = Map<String, dynamic>.from(convertData);
      newData.add(DetailDoAgen.fromJson(data));

      _listDetailDoAgen = newData;
      notifyListeners();
    }
  }
  // }
}
