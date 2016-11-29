angular.module('cart', [])
.controller('CartCtrl', [
    '$scope', '$http', 'cartService',
    function($scope, $http, cartService) {
       $scope.cart_items = [];
       $http.get('/cart.json').success(function(data){
            angular.copy(data, $scope.cart_items);
        });
        $scope.count = 0;
        $scope.addItem = function($http) {
            //send http reuest here/???
    
        };
        $scope.removeItem = function($http) {
            //send http request to rails he22re??
        };
    }
    
]);
//need to figure out: add/remove routing, cart updates, how that impacts rails backend if at all. count!!!!