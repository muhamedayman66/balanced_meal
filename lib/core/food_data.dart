import 'food_item.dart';

class FoodDataService {
  static List<FoodItem> getVegetables() {
    return [
      FoodItem(
        foodName: "Broccoli",
        calories: 55,
        imageUrl:
            "https://cdn.britannica.com/25/78225-050-1781F6B7/broccoli-florets.jpg",
        price: 12,
      ),
      FoodItem(
        foodName: "Spinach",
        calories: 23,
        imageUrl:
            "https://www.daysoftheyear.com/cdn-cgi/image/dpr=1%2Cf=auto%2Cfit=cover%2Cheight=650%2Cq=40%2Csharpen=1%2Cwidth=956/wp-content/uploads/fresh-spinach-day.jpg",
        price: 12,
      ),
      FoodItem(
        foodName: "Carrot",
        calories: 41,
        imageUrl:
            "https://cdn11.bigcommerce.com/s-kc25pb94dz/images/stencil/1280x1280/products/271/762/Carrot__40927.1634584458.jpg?c=2",
        price: 12,
      ), 
      FoodItem(
        foodName: "Bell Pepper",
        calories: 31,
        imageUrl:
            "https://i5.walmartimages.com/asr/5d3ca3f5-69fa-436a-8a73-ac05713d3c2c.7b334b05a184b1eafbda57c08c6b8ccf.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF",
        price: 12,
      ),
    ];
  }

  static List<FoodItem> getMeats() {
    return [
      FoodItem(
        foodName: "Chicken Breast",
        calories: 165,
        imageUrl:
            "https://www.savorynothings.com/wp-content/uploads/2021/02/airy-fryer-chicken-breast-image-8.jpg",
        price: 12,
      ),
      FoodItem(
        foodName: "Salmon",
        calories: 206,
        imageUrl:
            "https://cdn.apartmenttherapy.info/image/upload/f_jpg,q_auto:eco,c_fill,g_auto,w_1500,ar_1:1/k%2F2023-04-baked-salmon-how-to%2Fbaked-salmon-step6-4792",
        price: 12,
      ),
      FoodItem(
        foodName: "Lean Beef",
        calories: 250,
        imageUrl:
            "https://www.mashed.com/img/gallery/the-truth-about-lean-beef/l-intro-1621886574.jpg",
        price: 12,
      ),
      FoodItem(
        foodName: "Turkey",
        calories: 135,
        imageUrl:
            "https://fox59.com/wp-content/uploads/sites/21/2022/11/white-meat.jpg?w=2560&h=1440&crop=1",
        price: 12,
      ),
    ];
  }

  static List<FoodItem> getCarbs() {
    return [
      FoodItem(
        foodName: "Brown Rice",
        calories: 111,
        imageUrl:
            "https://assets-jpcust.jwpsrv.com/thumbnails/k98gi2ri-720.jpg",
        price: 12,
      ),
      FoodItem(
        foodName: "Oats",
        calories: 389,
        imageUrl:
            "https://media.post.rvohealth.io/wp-content/uploads/2020/03/oats-oatmeal-732x549-thumbnail.jpg",
        price: 12,
      ),
      FoodItem(
        foodName: "Sweet Corn",
        calories: 86,
        imageUrl:
            "https://m.media-amazon.com/images/I/41F62-VbHSL._AC_UF1000,1000_QL80_.jpg",
        price: 12,
      ),
      FoodItem(
        foodName: "Black Beans",
        calories: 132,
        imageUrl:
            "https://www.realsimple.com/thmb/If2bF9wouwqTO1q-qciF37n0-AM=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/black-beans-health-benefits-GettyImages-1268890779-ba643ccca3254398acdca809552d66de.jpg",
        price: 12,
      ),
    ];
  }

  static String getImageUrl(String foodName) {
    Map<String, String> foodImages = {
      'Bell Pepper':
          "https://i5.walmartimages.com/asr/5d3ca3f5-69fa-436a-8a73-ac05713d3c2c.7b334b05a184b1eafbda57c08c6b8ccf.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF",
      'Carrot':
          "https://cdn11.bigcommerce.com/s-kc25pb94dz/images/stencil/1280x1280/products/271/762/Carrot__40927.1634584458.jpg?c=2",
      'Broccoli':
          "https://cdn.britannica.com/25/78225-050-1781F6B7/broccoli-florets.jpg",
      'Spinach':
          "https://www.daysoftheyear.com/cdn-cgi/image/dpr=1%2Cf=auto%2Cfit=cover%2Cheight=650%2Cq=40%2Csharpen=1%2Cwidth=956/wp-content/uploads/fresh-spinach-day.jpg",
      'Lean Beef':
          "https://www.mashed.com/img/gallery/the-truth-about-lean-beef/l-intro-1621886574.jpg",
      'Salmon':
          "https://cdn.apartmenttherapy.info/image/upload/f_jpg,q_auto:eco,c_fill,g_auto,w_1500,ar_1:1/k%2F2023-04-baked-salmon-how-to%2Fbaked-salmon-step6-4792",
      'Chicken Breast':
          "https://www.savorynothings.com/wp-content/uploads/2021/02/airy-fryer-chicken-breast-image-8.jpg",
      'Turkey':
          "https://fox59.com/wp-content/uploads/sites/21/2022/11/white-meat.jpg?w=2560&h=1440&crop=1",
      'Sweet Corn':
          "https://m.media-amazon.com/images/I/41F62-VbHSL._AC_UF1000,1000_QL80_.jpg",
      'Brown Rice':
          "https://assets-jpcust.jwpsrv.com/thumbnails/k98gi2ri-720.jpg",
      'Oats':
          "https://media.post.rvohealth.io/wp-content/uploads/2020/03/oats-oatmeal-732x549-thumbnail.jpg",
      'Black Beans':
          "https://www.realsimple.com/thmb/If2bF9wouwqTO1q-qciF37n0-AM=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/black-beans-health-benefits-GettyImages-1268890779-ba643ccca3254398acdca809552d66de.jpg",
    };
    return foodImages[foodName] ?? '';
  }
}
