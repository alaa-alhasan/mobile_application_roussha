import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../app_properties.dart';
import '../../custom_background.dart';

class ReturnExchange extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MainBackground(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: kToolbarHeight,bottom: kToolbarHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  color: darkGrey,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Html(
                  data: data,
                )
              ],
            )
          )
        )
      ),
    );
  }


  final String data = """<h3>Exchange and return policy</h3>
                <p>The sale process in Roussha International, your purchase and use of the products available on this site are subject to the following terms and conditions of use and service:</p>

                <p>Roussha International may choose to accept, not accept, or cancel your order in some cases, for example, if the product you wish to purchase is not available, or if the product is priced incorrectly, or if the order is found to be fraudulent, Grass International will By returning what you paid for orders that were not accepted or that are canceled.</p>
                <p>All content on the Roussha International website, including writings, designs, graphics, logos, icons, images, interfaces, symbols, programs and trademarks, is an exclusive property owned by the Grass International website, and this property is subject to copyright protection.</p>

                <p>When purchasing or sending an email to Roussha International, you agree to receive any emails or any notifications regarding the order.</p>
                <p>Roussha International reserves the right to make any amendments or changes to its site and to the policies and agreements associated with it, including the privacy policy as well as the document for the terms and conditions of service and the terms of exchange and return.</p>
                <p>All products are returned within a period not exceeding 3 days of receiving the order if the product is in its original condition and has not been opened, tested or used in one way or another, and in order to preserve the quality of the product and the validity of preservation, it cannot be returned after that.</p>
                
                <h4>There are a number of specific cases in which a product cannot be returned:</h4>
                <p>When submitting a return request after the specified time, which is 3 days from the date of receipt regarding the products. <br>
                    When the product has been used, damaged, or not in the same condition that you received it in, or when the product safety sticker has been removed. or consumer products that have been used or installed.<br>
                    Products whose serial numbers have been tampered with or removed.<br>
                    Products without price tags, stickers, original packaging, or missing any accessories.</p>""";

}
