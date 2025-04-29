import 'package:e__commerce/Features/Home/presentation/widgets/CategoriesListView.dart';
import 'package:e__commerce/Features/Home/presentation/widgets/CustomSearchBar.dart';
import 'package:e__commerce/Features/Home/presentation/widgets/RecentProductLIstView.dart';
import 'package:e__commerce/Features/auth/data/models/UserModel.dart';
import 'package:e__commerce/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.user});

final UserDataModel user ; 
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

   @override
  void initState() {
    PaymentData.initialize(
      apiKey:
         Constants().apiKey, // Required: Found under Dashboard -> Settings -> Account Info -> API Key
      iframeId:
          Constants().iframeId, // Required: Found under Developers -> iframes
      integrationCardId:
           Constants().integrationCardId, // Required: Found under Developers -> Payment Integrations -> Online Card ID
      integrationMobileWalletId:
           Constants().integrationMobileWalletId, // Required: Found under Developers -> Payment Integrations -> Mobile Wallet ID

      
      userData: UserData(
        email: widget.user.email, // Optional: Defaults to 'NA'  
       // phone: "User Phone", // Optional: Defaults to 'NA'
        name: widget.user.name, // Optional: Defaults to 'NA'
      // lastName: "User Last Name", // Optional: Defaults to 'NA'
      ),

      // // Optional Style Customizations
      // style: Style(
      //   primaryColor: Colors.blue, // Default: Colors.blue
      //   scaffoldColor: Colors.white, // Default: Colors.white
      //   appBarBackgroundColor: Colors.blue, // Default: Colors.blue
      //   appBarForegroundColor: Colors.white, // Default: Colors.white
      //   textStyle: TextStyle(), // Default: TextStyle()
      //   buttonStyle:
      //       ElevatedButton.styleFrom(), // Default: ElevatedButton.styleFrom()
      //   circleProgressColor: Colors.blue, // Default: Colors.blue
      //   unselectedColor: Colors.grey, // Default: Colors.grey
      // ),
      
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

   

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomSearchbar(),
          Image.asset(
            "Assets/images/buy.jpg",
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Popular categories",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const CategoriesListView(),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Recently added products",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          RecentProductListView(),
        ],
      ),
    );
  }
}
