import 'package:get/get.dart';
import 'package:roussha_store/app_properties.dart';
import 'package:roussha_store/controllers/home_controller.dart';
import 'package:roussha_store/custom_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roussha_store/functions/alert_exit_app.dart';
import 'package:roussha_store/screens/cart/cart_page.dart';
import 'package:roussha_store/screens/filter/filter_page.dart';
import 'package:roussha_store/screens/profile/profile_page.dart';
import 'package:roussha_store/screens/search/search_page.dart';
import 'components/custom_bottom_bar.dart';
import 'components/product_list.dart';
import 'components/tab_view.dart';

class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> with TickerProviderStateMixin<MainPage> {

  late TabController tabController;
  late TabController bottomTabController;

  final HomeController controller = Get.find();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: controller.categories.length, vsync: this);
    bottomTabController = TabController(length: 4, vsync: this);

  }

  @override
  Widget build(BuildContext context) {

    Widget appBar = Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              onPressed: () async {},
              icon: Image.asset('assets/logo.png'),iconSize: 40,tooltip: 'Roussha Store'),
          IconButton(
              onPressed: (){
                Get.to(() => SearchPage());
              },
              icon: SvgPicture.asset('assets/icons/search_icon.svg'))
        ],
      ),
    );

    Widget topHeader = Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              child: InkWell(
                onTap: () {
                  setState(() {
                    controller.selectedTimeline = controller.timelines[0];
                    controller.product_tag(0);
                    controller.changeProductList();
                  });
                },
                child: Text(
                  controller.timelines[0],
                  style: TextStyle(
                      fontSize: controller.timelines[0] == controller.selectedTimeline ? 20 : 14,
                      color: deepGrey),
                )
              ),
            ),
            Flexible(
              child: InkWell(
                onTap: () {
                  setState(() {
                    controller.selectedTimeline = controller.timelines[1];
                    controller.product_tag(1);
                    controller.changeProductList();
                  });
                },
                child: Text(
                    controller.timelines[1],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: controller.timelines[1] == controller.selectedTimeline ? 20 : 14,
                        color: deepGrey))
              ),
            ),
            Flexible(
              child: InkWell(
                onTap: () {
                  setState(() {
                    controller.selectedTimeline = controller.timelines[2];
                    controller.product_tag(2);
                    controller.changeProductList();
                  });
                },
                child: Text(
                    controller.timelines[2],
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: controller.timelines[2] == controller.selectedTimeline ? 20 : 14,
                        color: deepGrey))
              ),
            ),
          ],
        ));

    Widget tabBar = Obx((){
      if(controller.LOADING_CATEGORIES.value){
        return Center(
            child: CircularProgressIndicator()
        );
      }else{
        return TabBar(
          tabs: [
            for(var c in controller.categories)
              Tab(text: c.name),
          ],
          labelStyle: TextStyle(fontSize: 16.0),
          unselectedLabelStyle: TextStyle(
            fontSize: 14.0,
          ),
          labelColor: deepGrey,
          unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.5),
          isScrollable: true,
          controller: tabController,
          onTap: (value) {
            controller.tab_category_selected_id(controller.categories[value].id);
            controller.fetchOnSaleProducts();
            controller.fetchProductsByCategory();
          },
        );
      }
    });



    return Scaffold(
      bottomNavigationBar: CustomBottomBar(controller: bottomTabController),
      body: WillPopScope(
        onWillPop: alertExitApp,
        child: CustomPaint(
          painter: MainBackground(),
          child: TabBarView(
            controller: bottomTabController,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              SafeArea(
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    // These are the slivers that show up in the "outer" scroll view.
                    return <Widget>[
                      SliverToBoxAdapter(
                        child: appBar,
                      ),
                      SliverToBoxAdapter(
                        child: topHeader,
                      ),
                      SliverToBoxAdapter(
                        child: ProductList(),
                      ),
                      SliverToBoxAdapter(
                        child: tabBar,
                      ),
                    ];
                  },
                  body: TabView(
                    tabController: tabController,
                  ),
                ),
              ),
              FilterPage(),
              CartPage(),
              ProfilePage()
            ],
          ),
        ),
      ),
    );
  }
}
