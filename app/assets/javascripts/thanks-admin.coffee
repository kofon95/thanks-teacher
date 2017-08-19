angular.module("main", []).controller("thanksCtrl", ($scope, $http, $httpParamSerializer)->
  authToken = document.getElementById("auth_token").value
  authTokenData = $httpParamSerializer({authenticity_token: authToken})
  deleteHeaders = { "Content-Type": "application/x-www-form-urlencoded" }

  $scope.totalThanks = document.getElementById("total_thanks").value

  $scope.thanks = []

  $scope.loadThanks = (count) ->
    console.log(count + " load")
    $http.get("/thanks.json?offset=#{$scope.thanks.length}&count=#{count}")
      .then (resp)->
        console.log(resp)
        $scope.thanks = $scope.thanks.concat resp.data
        console.log($scope.thanks)


  $scope.loadThanks(5)

  $scope.removeThank = (index) ->
    return unless confirm('Вы уверены, что хотите удалить благодарение?')
    $http({
      url: "/thanks/#{$scope.thanks[index].id}"
      method: 'DELETE'
      data: authTokenData
      headers: deleteHeaders
    })
    .then (resp) ->
      $scope.thanks.splice(index, 1)
      $scope.totalThanks--
)
