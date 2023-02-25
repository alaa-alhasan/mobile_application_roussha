import 'package:flutter/material.dart';
import 'package:roussha_store/controllers/home_controller.dart';
import 'products_for_category.dart';
import 'on_sale_card.dart';
import 'package:get/get.dart';

class TabView extends StatelessWidget {

  final TabController tabController;
  final HomeController controller = Get.find();

  TabView({
    required this.tabController
  });

  List<Column> getWidgetList(){
    List<Column> columns = [];
    for(int i=0; i< controller.categories.length; i++){
      columns.add(
          Column(
            children: [
              controller.saleState.value == 1 ? OnSaleCard() : SizedBox(height: 5),
              Flexible(child: CategoryProducts())
            ],
          ));
    }
    return columns;
  }



  @override
  Widget build(BuildContext context) {

    print(MediaQuery.of(context).size.height / 9);
    return TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: getWidgetList()
    );
  }


}


