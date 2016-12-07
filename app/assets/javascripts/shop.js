angular.module('shop', [])
.controller('ShopCtrl', [
    '$scope', '$http', 'cartService', 'productService',
    function($scope, $http, cartService, productService) {
        $scope.inventory = productService.products;
        // $http.get('/shop.json').success(function(data){
        //     angular.copy(data, $scope.inventory);
        // });  
        $scope.getStock = function(item) {
            return productService.stockLeft(item.work_id);
        }
        
        $scope.cart = cartService.cart;
        $scope.addItem = function(product) {
            if(product.id > 0) {
                this.cart.addItem(product.id, product.name, product.price, 1, product.image.thumb.url);
            }
        };   
        $scope.removeItem = function(product) {
            this.cart.removeItem(product.id);
        }
        
        $scope.inStock = function(id, quantity) {
            var amt = productService.stockLeft(id);
            return quantity <= amt;
        }
        
        $scope.outOfStock = function(id, quantity) {
            var amt = productService.stockLeft(id);
            return quantity >= amt;
        }
}])

.directive('integer', function() {
    var INTEGER_REGEXP = /^-?\d+$/;
  return {
    require: 'ngModel',
    link: function(scope, elm, attrs, ctrl) {
      ctrl.$validators.integer = function(modelValue, viewValue) {
        if (ctrl.$isEmpty(modelValue)) {
          // consider empty models to be valid
          return true;
        }
        
        if (INTEGER_REGEXP.test(viewValue)) {
            var value = viewValue *1;
            return scope.inStock(scope.item.work_id, value);
        }

        // it is invalid
        return false;
      };
    }
  };
});

