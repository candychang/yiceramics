angular.module('cart', ['ng-Route'])
.config(['$routeProvider', function($routeProvider) {
    $routeProvider.when('/cart', {
        templateUrl: '/views/carts/show.html',
        controller: 'CartCtrl'
    });
}])
.controller('CartCtrl', [
    '$scope', '$http',
    function($scope, $http) {
       $scope.cart_items = [];
       $http.get('/cart.json').success(function(data){
            angular.copy(data, $scope.cart_items);
        });
        $scope.count = 0;
    }
    
]);
//need to figure out: add/remove routing, cart updates, how that impacts rails backend if at all. count!!!!