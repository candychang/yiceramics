
mainApp = angular.module('yiceramics', ['home', 'posts', 'cart', 'shop'])
.factory('cartService', ['$http', function($http) {
  cartService = new ShoppingCart("YiceramicsCart");

  return {
      cart: cartService
  };
}]);


