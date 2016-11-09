var app = angular.module('yiceramics', [])

app.controller('PostsCtrl', [
    '$scope',
    function($scope){
        $scope.help = "help"
      $scope.posts = [
          { title: "Title",
            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse non leo finibus, feugiat arcu non, pretium ligula. Vestibulum scelerisque turpis a tincidunt convallis. Cras quis consequat massa. Morbi metus sem, auctor vel scelerisque at, pharetra sit amet nibh. Sed ligula nunc, porttitor ac tempor at"
          }, 
          {title: "Title",
            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse non leo finibus, feugiat arcu non, pretium ligula. Vestibulum scelerisque turpis a tincidunt convallis. Cras quis consequat massa. Morbi metus sem, auctor vel scelerisque at, pharetra sit amet nibh. Sed ligula nunc, porttitor ac tempor at"}]
          
}]);

app.run(function() {  
  return console.log('angular is working'); 
});