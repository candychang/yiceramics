angular.module('cart', [])
.controller('CartCtrl', [
    '$scope', '$http', 'cartService',
    function($scope, $http, cartService) {
       $scope.cart = cartService.cart;
       $scope.updateCart = function() {
           storeWithExpiration(cart.name, cart);
       }
    }
    
]);
//need to figure out: add/remove routing, cart updates, how that impacts rails backend if at all. count!!!!