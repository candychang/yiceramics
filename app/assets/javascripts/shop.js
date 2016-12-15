angular.module('shop', [])
.controller('ShopCtrl', [
    '$scope', '$http', 'cartService', 'productService',
    function($scope, $http, cartService, productService) {
        $scope.inventory = productService.products;
        $scope.service = productService;
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
        };
        
        $scope.inStock = function(id, quantity) {
            var amt = productService.stockLeft(id);
            return quantity <= amt;
        };
        
        $scope.outOfStock = function(id, quantity) {
            var amt = productService.stockLeft(id);
            return quantity >= amt;
        };
        
        $scope.errors = ['hi'];
        
        $scope.startCheckout = function() {
            $http.put('/cart/confirm', {items: $scope.cart.items}).success(function(data){
                angular.copy(data.items, $scope.cart.items);
                alert("updated?");
                $scope.cart.saveItems();
                angular.copy(data.errors, $scope.errors);
                if (data.errors.length > 0) {
                    productService.loadProducts(true);
                }
            });
            
       };
}])

.directive('integer', function() {
    var INTEGER_REGEXP = /^-?\d+$/;
  return {
    require: 'ngModel',
    link: function(scope, elm, attrs, ctrl) {
        
        function fromInput(value) {
            var val = parseInt(value);
            return val;
        };
        
        function toInput(value) {
            var val = parseInt(value);
            return val;
        };
        
        ctrl.$parsers.push(fromInput);
        ctrl.$formatters.push(toInput);
      
      
      ctrl.$validators.integer = function(modelValue, viewValue) {
          return scope.inStock(scope.item.work_id, modelValue);
      };
    }
  };
});

