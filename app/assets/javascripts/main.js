
mainApp = angular.module('yiceramics', ['home', 'posts', 'cart', 'shop', 'works', 'thatisuday.ng-image-gallery'])
.factory('cartService', ['$http', function($http) {
  var cartService = new ShoppingCart("YiceramicsCart");

  return {
      cart: cartService
  };
}])

.factory('galleryService', ['$http', '$q', function ($http, $q) {
        
        
  return {
      getGallery: function() {
          // the $http API is based on the deferred/promise APIs exposed by the $q service
          // so it returns a promise for us by default
          return $http.get('/works.json')
              .then(function(response) {
                  if (typeof response.data === 'object') {
                      return response.data;
                  } else {
                      // invalid response
                      return $q.reject(response.data);
                  }

              }, function(response) {
                  // something went wrong
                  return $q.reject(response.data);
              });
      }
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
  
  
  
  var loadProducts = function(reload) {
      if (reload || allProducts.loaded == false) {
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
  };
  
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
   
  loadProducts(true);
  return {
    products: allProducts.list,
    gallery: onlyGallery.list,
    stockLeft: stockLeft,
    loadProducts: loadProducts
  };
  
}]);


mainApp.config(['ngImageGalleryOptsProvider', function(ngImageGalleryOptsProvider){
    ngImageGalleryOptsProvider.setOpts({
        thumbnails  :   true,   
        inline      :   false,
        imgBubbles  :   true, 
        bgClose     :   false,
        bubbles     :   true, 
        imgAnim     :   'fade',
    });
}]);

        