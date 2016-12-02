angular.module('shop', [])
.controller('ShopCtrl', [
    '$scope', '$http', 'cartService',
    function($scope, $http, cartService) {
        $scope.inventory = [];
        $http.get('/shop.json').success(function(data){
            angular.copy(data, $scope.inventory);
        });
        $scope.cart = cartService.cart;
        $scope.toggleCart = function(product) {
            product.inCart = (product.inCart === undefined) ? false : product.inCart;
            if (!product.inCart && product.quantity >= 1) {
                this.cart.addItem(product.work_id, product.name, product.price, 1, product.image.thumb.url);
                product.inCart = true;
            } else if(product.inCart) {
                this.cart.removeItem(product.work_id);
                product.inCart = false;
            }
        };      
}]);

