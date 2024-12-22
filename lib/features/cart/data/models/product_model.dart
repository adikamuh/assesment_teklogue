class ProductModel {
  int id;
  String productName;
  dynamic productAlias;
  int? productCategoryId;
  String? productType;
  dynamic inventoryType;
  String? barcode;
  String? sku;
  String? baseUnitName;
  int? baseUnitId;
  num? baseUnitCostPrice;
  int? displaysOnPos;
  int? stockAlert;
  String? lowQuantity;
  String? salesTaxType;
  int? salesTaxId;
  String? salesTaxRate;
  String? salesTaxArticleType;
  String? purchaseTaxType;
  int? purchaseTaxId;
  String? purchaseTaxRate;
  String? purchaseTaxArticleType;
  dynamic incomeTaxType;
  dynamic incomeTaxId;
  String? incomeTaxRate;
  dynamic incomeTaxArticleType;
  dynamic description;
  int? defaultAccountInventory;
  dynamic defaultAccountExpense;
  int? defaultAccountSales;
  int? defaultAccountSalesReturns;
  int? defaultAccountSalesDiscounts;
  int? defaultAccountGoodsShipped;
  int? defaultAccountCostOfGoodSold;
  int? defaultAccountPurchaseReturns;
  int? defaultAccountUnbilledPayable;
  String? productTypeLabel;
  int? productId;
  List<Unit>? units;
  List<ProductBalance>? productBalances;
  int? baseQuantity;
  int? availableQuantity;
  int? availableQuantityShow;
  List<StandardProductCost>? standardProductCosts;
  List<SalesPrice>? salesPriceList;
  List<dynamic>? productUnits;

  ProductModel({
    required this.id,
    required this.productName,
    required this.productAlias,
    required this.productCategoryId,
    required this.productType,
    required this.inventoryType,
    required this.barcode,
    required this.sku,
    required this.baseUnitName,
    required this.baseUnitId,
    required this.baseUnitCostPrice,
    required this.displaysOnPos,
    required this.stockAlert,
    required this.lowQuantity,
    required this.salesTaxType,
    required this.salesTaxId,
    required this.salesTaxRate,
    required this.salesTaxArticleType,
    required this.purchaseTaxType,
    required this.purchaseTaxId,
    required this.purchaseTaxRate,
    required this.purchaseTaxArticleType,
    required this.incomeTaxType,
    required this.incomeTaxId,
    required this.incomeTaxRate,
    required this.incomeTaxArticleType,
    required this.description,
    required this.defaultAccountInventory,
    required this.defaultAccountExpense,
    required this.defaultAccountSales,
    required this.defaultAccountSalesReturns,
    required this.defaultAccountSalesDiscounts,
    required this.defaultAccountGoodsShipped,
    required this.defaultAccountCostOfGoodSold,
    required this.defaultAccountPurchaseReturns,
    required this.defaultAccountUnbilledPayable,
    required this.productTypeLabel,
    required this.productId,
    required this.units,
    required this.productBalances,
    required this.baseQuantity,
    required this.availableQuantity,
    required this.availableQuantityShow,
    required this.standardProductCosts,
    required this.salesPriceList,
    required this.productUnits,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      productName: json['product_name'],
      productAlias: json['product_alias'],
      productCategoryId: json['product_category_id'],
      productType: json['product_type'],
      inventoryType: json['inventory_type'],
      barcode: json['barcode'],
      sku: json['sku'],
      baseUnitName: json['base_unit_name'],
      baseUnitId: json['base_unit_id'],
      baseUnitCostPrice: num.tryParse(json['base_unit_cost_price'] ?? '0') ?? 0,
      displaysOnPos: json['displays_on_pos'],
      stockAlert: json['stock_alert'],
      lowQuantity: json['low_quantity'],
      salesTaxType: json['sales_tax_type'],
      salesTaxId: json['sales_tax_id'],
      salesTaxRate: json['sales_tax_rate'],
      salesTaxArticleType: json['sales_tax_article_type'],
      purchaseTaxType: json['purchase_tax_type'],
      purchaseTaxId: json['purchase_tax_id'],
      purchaseTaxRate: json['purchase_tax_rate'],
      purchaseTaxArticleType: json['purchase_tax_article_type'],
      incomeTaxType: json['income_tax_type'],
      incomeTaxId: json['income_tax_id'],
      incomeTaxRate: json['income_tax_rate'],
      incomeTaxArticleType: json['income_tax_article_type'],
      description: json['description'],
      defaultAccountInventory: json['default_account_inventory'],
      defaultAccountExpense: json['default_account_expense'],
      defaultAccountSales: json['default_account_sales'],
      defaultAccountSalesReturns: json['default_account_sales_returns'],
      defaultAccountSalesDiscounts: json['default_account_sales_discounts'],
      defaultAccountGoodsShipped: json['default_account_goods_shipped'],
      defaultAccountCostOfGoodSold: json['default_account_cost_of_good_sold'],
      defaultAccountPurchaseReturns: json['default_account_purchase_returns'],
      defaultAccountUnbilledPayable: json['default_account_unbilled_payable'],
      productTypeLabel: json['product_type_label'],
      productId: json['product_id'],
      units: List<Unit>.from(json['units'].map((x) => Unit.fromJson(x))),
      productBalances: List<ProductBalance>.from(
          json['product_balances'].map((x) => ProductBalance.fromJson(x))),
      baseQuantity: json['base_quantity'],
      availableQuantity: json['available_quantity'],
      availableQuantityShow: json['available_quantity_show'],
      standardProductCosts: List<StandardProductCost>.from(
          json['standard_product_costs']
              .map((x) => StandardProductCost.fromJson(x))),
      salesPriceList: List<SalesPrice>.from(
          json['sales_price_list'].map((x) => SalesPrice.fromJson(x))),
      productUnits: List<dynamic>.from(json['product_units'].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
    };
  }
}

class Unit {
  String unitName;
  int unitId;
  int unitConversion;

  Unit({
    required this.unitName,
    required this.unitId,
    required this.unitConversion,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      unitName: json['unit_name'],
      unitId: json['unit_id'],
      unitConversion: json['unit_conversion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unit_name': unitName,
      'unit_id': unitId,
      'unit_conversion': unitConversion,
    };
  }
}

class ProductBalance {
  int id;
  int productId;
  String warehouseName;
  int warehouseId;
  String date;
  dynamic barcode;
  dynamic expirationDate;
  dynamic batchNumber;
  String baseUnitCostPrice;
  int sourceId;
  int sourceProductId;
  String sourceType;
  dynamic inventoryAdjustmentId;
  int productOpenBalance;
  String? openBalanceDate;
  String openBalanceBaseQuantity;
  String baseQuantity;
  String productName;
  String productBalanceName;

  ProductBalance({
    required this.id,
    required this.productId,
    required this.warehouseName,
    required this.warehouseId,
    required this.date,
    required this.barcode,
    required this.expirationDate,
    required this.batchNumber,
    required this.baseUnitCostPrice,
    required this.sourceId,
    required this.sourceProductId,
    required this.sourceType,
    required this.inventoryAdjustmentId,
    required this.productOpenBalance,
    required this.openBalanceDate,
    required this.openBalanceBaseQuantity,
    required this.baseQuantity,
    required this.productName,
    required this.productBalanceName,
  });

  factory ProductBalance.fromJson(Map<String, dynamic> json) {
    return ProductBalance(
      id: json['id'],
      productId: json['product_id'],
      warehouseName: json['warehouse_name'],
      warehouseId: json['warehouse_id'],
      date: json['date'],
      barcode: json['barcode'],
      expirationDate: json['expiration_date'],
      batchNumber: json['batch_number'],
      baseUnitCostPrice: json['base_unit_cost_price'],
      sourceId: json['source_id'],
      sourceProductId: json['source_product_id'],
      sourceType: json['source_type'],
      inventoryAdjustmentId: json['inventory_adjustment_id'],
      productOpenBalance: json['product_open_balance'],
      openBalanceDate: json['open_balance_date'],
      openBalanceBaseQuantity: json['open_balance_base_quantity'],
      baseQuantity: json['base_quantity'],
      productName: json['product_name'],
      productBalanceName: json['product_balance_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'warehouse_name': warehouseName,
      'warehouse_id': warehouseId,
      'date': date,
      'barcode': barcode,
      'expiration_date': expirationDate,
      'batch_number': batchNumber,
      'base_unit_cost_price': baseUnitCostPrice,
      'source_id': sourceId,
      'source_product_id': sourceProductId,
      'source_type': sourceType,
      'inventory_adjustment_id': inventoryAdjustmentId,
      'product_open_balance': productOpenBalance,
      'open_balance_date': openBalanceDate,
      'open_balance_base_quantity': openBalanceBaseQuantity,
      'base_quantity': baseQuantity,
      'product_name': productName,
      'product_balance_name': productBalanceName,
    };
  }
}

class StandardProductCost {
  int id;
  String productName;
  int standardProductCostId;
  int productId;
  List<String> warehouseName;
  List<int> warehouseId;
  String unitName;
  int unitId;
  String baseUnitName;
  int baseUnitId;
  String unitConversion;
  String standardProductCostPrice;
  String baseStandardProductCostPrice;
  bool ignore;
  dynamic description;
  List<Unit> units;

  StandardProductCost({
    required this.id,
    required this.productName,
    required this.standardProductCostId,
    required this.productId,
    required this.warehouseName,
    required this.warehouseId,
    required this.unitName,
    required this.unitId,
    required this.baseUnitName,
    required this.baseUnitId,
    required this.unitConversion,
    required this.standardProductCostPrice,
    required this.baseStandardProductCostPrice,
    required this.ignore,
    required this.description,
    required this.units,
  });

  factory StandardProductCost.fromJson(Map<String, dynamic> json) {
    return StandardProductCost(
      id: json['id'],
      productName: json['product_name'],
      standardProductCostId: json['standard_product_cost_id'],
      productId: json['product_id'],
      warehouseName: List<String>.from(json['warehouse_name'].map((x) => x)),
      warehouseId: List<int>.from(json['warehouse_id'].map((x) => x)),
      unitName: json['unit_name'],
      unitId: json['unit_id'],
      baseUnitName: json['base_unit_name'],
      baseUnitId: json['base_unit_id'],
      unitConversion: json['unit_conversion'],
      standardProductCostPrice: json['standard_product_cost_price'],
      baseStandardProductCostPrice: json['base_standard_product_cost_price'],
      ignore: json['ignore'],
      description: json['description'],
      units: List<Unit>.from(json['units'].map((x) => Unit.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'standard_product_cost_id': standardProductCostId,
      'product_id': productId,
      'warehouse_name': List<dynamic>.from(warehouseName.map((x) => x)),
      'warehouse_id': List<dynamic>.from(warehouseId.map((x) => x)),
      'unit_name': unitName,
      'unit_id': unitId,
      'base_unit_name': baseUnitName,
      'base_unit_id': baseUnitId,
      'unit_conversion': unitConversion,
      'standard_product_cost_price': standardProductCostPrice,
      'base_standard_product_cost_price': baseStandardProductCostPrice,
      'ignore': ignore,
      'description': description,
      'units': List<dynamic>.from(units.map((x) => x.toJson())),
    };
  }
}

class SalesPrice {
  int id;
  String productName;
  int salesPriceAdjustmentId;
  int productId;
  String warehouseName;
  List<int> warehouseId;
  String unitName;
  int unitId;
  String priceListName;
  List<int> priceListId;
  String minimumQuantity;
  String salesPrice;
  String minimumSalesPrice;
  bool ignore;
  dynamic description;
  List<Unit> units;

  SalesPrice({
    required this.id,
    required this.productName,
    required this.salesPriceAdjustmentId,
    required this.productId,
    required this.warehouseName,
    required this.warehouseId,
    required this.unitName,
    required this.unitId,
    required this.priceListName,
    required this.priceListId,
    required this.minimumQuantity,
    required this.salesPrice,
    required this.minimumSalesPrice,
    required this.ignore,
    required this.description,
    required this.units,
  });

  factory SalesPrice.fromJson(Map<String, dynamic> json) {
    return SalesPrice(
      id: json['id'],
      productName: json['product_name'],
      salesPriceAdjustmentId: json['sales_price_adjustment_id'],
      productId: json['product_id'],
      warehouseName: json['warehouse_name'],
      warehouseId: List<int>.from(json['warehouse_id'].map((x) => x)),
      unitName: json['unit_name'],
      unitId: json['unit_id'],
      priceListName: json['price_list_name'],
      priceListId: List<int>.from(json['price_list_id'].map((x) => x)),
      minimumQuantity: json['minimum_quantity'],
      salesPrice: json['sales_price'],
      minimumSalesPrice: json['minimum_sales_price'],
      ignore: json['ignore'],
      description: json['description'],
      units: List<Unit>.from(json['units'].map((x) => Unit.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'sales_price_adjustment_id': salesPriceAdjustmentId,
      'product_id': productId,
      'warehouse_name': warehouseName,
      'warehouse_id': List<dynamic>.from(warehouseId.map((x) => x)),
      'unit_name': unitName,
      'unit_id': unitId,
      'price_list_name': priceListName,
      'price_list_id': List<dynamic>.from(priceListId.map((x) => x)),
      'minimum_quantity': minimumQuantity,
      'sales_price': salesPrice,
      'minimum_sales_price': minimumSalesPrice,
      'ignore': ignore,
      'description': description,
      'units': List<dynamic>.from(units.map((x) => x.toJson())),
    };
  }
}
