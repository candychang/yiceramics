angular.module('shop', [])
.controller('ShopCtrl', [
    '$scope', '$http',
    function($scope, $http) {
        $scope.inventory = [];
        $http.get('/shop.json').success(function(data){
            angular.copy(data, $scope.inventory);
        });
}]);
