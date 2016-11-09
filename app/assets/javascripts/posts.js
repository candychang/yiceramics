angular.module('yiceramics', [])
.controller('PostCtrl', [
    '$scope',
    function($scope){
      $scope.posts = [
        { title: "Title",
          body: "Lorem Ipsum body goes here"
        },
        { title: "Title 2",
          body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut lorem dui, convallis id aliquam ut, condimentum sed justo. In quis tincidunt ligula. Sed rhoncus quis leo at molestie. Praesent dignissim porttitor leo, nec ultricies ipsum auctor eu. Fusce dui eros, viverra a sodales eu, imperdiet faucibus nunc. Nunc ornare tristique mauris, tempus facilisis neque ultricies quis. Sed dictum tortor nec turpis molestie, a malesuada lectus finibus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla facilisi. Integer in faucibus ipsum. In quis nulla tincidunt, ullamcorper ipsum vitae, blandit enim. Donec eget cursus neque, eget sagittis arcu. Sed malesuada tortor et purus rhoncus venenatis. Donec eget bibendum enim, in efficitur justo. In hac habitasse platea dictumst. "
        }]
          
}]);