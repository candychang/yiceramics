angular.module('shop', [])
.controller('ShopCtrl', [
    '$scope', '$http', 'cartService',
    function($scope, $http, cartService) {
        $scope.inventory = [];
        $http.get('/shop.json').success(function(data){
            angular.copy(data, $scope.inventory);
        });
        $scope.cart = cartService.cart;
        $scope.addItem = function(product) {
            if(product.quantity > 0) {
                this.cart.addItem(product.id, product.name, product.price, 1, product.image.thumb.url);
            }
        };   
        $scope.removeItem = function(product) {
            this.cart.removeItem(product.id);
        }
}]);

