
mainApp = angular.module('yiceramics', ['home', 'posts', 'cart', 'shop'])
.factory('cartService', ['$http', function($http) {
  var cartService = new ShoppingCart("YiceramicsCart");

  return {
      cart: cartService
  };
}])
.factory('productService', ['$http', function($http) {
  var allProducts= { 
    list: [],
    loaded: false,
  }
  
  var onlyGallery = {
    list: [],
    loaded: false,
  }
  
  var cachedProducts = [];
  
  if (allProducts.loaded == false) {
    $http.get('/shop.json').success(function(data){
            angular.copy(data, allProducts.list);
            allProducts.loaded = true;
            cachedProducts = [];
    }); 
  }
  
  if (onlyGallery.loaded == false) {
    $http.get('/works.json').success(function(data){
            angular.copy(data, onlyGallery.list);
            onlyGallery.loaded = true;
  }); 
  }
  
  var stockLeft = function(id) {
    var currProduct;
    var found = false;
    for (var i = 0; i < cachedProducts.length; i++) {
      currProduct = cachedProducts[i];
      if (currProduct.id == id) {
        found = true;
        return currProduct.quantity * 1;
      }
    }
    
    if (!found) {
      for (var j = 0; j < allProducts.list.length; j++) {
        currProduct = allProducts.list[j];
        if (currProduct.id == id) {
          found = true;
          return currProduct.quantity * 1;
        }
      }
    }
    
    return 0;
  }
   
  
  return {
    products: allProducts.list,
    gallery: onlyGallery.list,
    stockLeft: stockLeft,
  };
  
}]);


