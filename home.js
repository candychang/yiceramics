angular.module('yiceramics', [])
.controller('MainCtrl', [
    '$scope',
    function($scope){
      $scope.photos = [
        { name: "dish",
          imageUrl: "dish.jpg"
        },
      ]
      
      $scope.toc = [
          "About",
          "Gallery",
          "Blog",
          "Shop",
        ]
          
}]);