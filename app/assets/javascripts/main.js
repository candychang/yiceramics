
mainApp = angular.module('yiceramics', ['home', 'posts', 'cart', 'shop'])
.factory('cartService', ['$http', function($http) {
  var cartService = new ShoppingCart("YiceramicsCart");

  return {
      cart: cartService
  };
}]);
// .factory('productService', ['$http', function($http) {
//   var allProducts= { 
//     list: [],
//     loaded: false,
//     needsUpdate: true
//   }
  
//   var onlyGallery = {
//     list: [],
//     loaded: false,
//     needsUpdate: true
//   }
  
//   if (allProducts.loaded == false || allProducts.needsUpdate == true) {
//     $http.get('/shop.json').success(function(data){
//             angular.copy(data, allProducts.list);
//             allProducts.loaded = true;
//             allProducts.needsUpdate = false;
//     }); 
//   }
  
//   if (onlyGallery.loaded == false || onlyGallery.needsUPdate == true) {
//     $http.get('/works.json').success(function(data){
//             angular.copy(data, onlyGallery.list);
//             onlyGallery.loaded = true;
//             onlyGallery.needsUpdate = false;
//   }); 
//   }
   
  
//   return {
//     products: allProducts.list,
//     gallery: onlyGallery.list
//   };
  
// }]);


