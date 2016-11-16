angular.module('shop', [])
.controller('ShopCtrl', [
    '$scope', '$http',
    function($scope, $http) {
        $scope.inventory = [];
        $http.get('/shop.json').success(function(data){
            angular.copy(data, $scope.inventory);
        });
        $scope.count = 0; // TODO: figure out repeated code issue w cart ctrl
        $scope.cart_message = "Add to cart";
        $scope.addCart = function() {
            $scope.count++;
        };
        $scope.removeCart = function() {
            $scope.count--;
        }
}]);

