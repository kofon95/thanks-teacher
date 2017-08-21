permitObject = (obj, keys)->
  result = {}
  for key in keys
    result[key] = obj[key]
  result

angular.module("main", []).controller("thanksCtrl", ($scope, $http, $httpParamSerializer)->
  authToken = document.getElementById("auth_token").value
  authTokenData = $httpParamSerializer({authenticity_token: authToken})
  deleteHeaders = { "Content-Type": "application/x-www-form-urlencoded" }

  $scope.totalThanks = document.getElementById("total_thanks").value

  thanks = []
  $scope.thanks = thanks

  $scope.loadThanks = (count) ->
    $http.get("/thanks.json?offset=#{thanks.length}&count=#{count}&show=all")
      .then (resp)->
        $scope.thanks = thanks = thanks.concat resp.data


  $scope.loadThanks(5)




  $scope.removeThank = (index) ->
    return if thanks[index].isLoading or !confirm('Вы уверены, что хотите удалить благодарение?')
    $http({
      url: "/thanks/#{thanks[index].id}"
      method: 'DELETE'
      data: authTokenData
      headers: deleteHeaders
    })
    .then (resp) ->
      thanks.splice(index, 1)
      $scope.totalThanks--


  # returns promise
  $scope.saveThank = (thank) ->
    return null if thank.isLoading
    keys = ['visitor_name', 'teacher_name', 'school_name', 'body', 'published']
    thank.isLoading = true
    $http.patch("/thanks/#{thank.id}", {
      authenticity_token: authToken
      thanks: permitObject thank, keys
    }
      {transformResponse: -> null}
    )
    .catch (e)-> alert "#{e.status}: #{e.statusText}"
    .finally -> thank.isLoading = false



  $scope.saveThankWithPublish = (index, published) ->
    thanks[index].published = published
    if $scope.saveThank(thanks[index])?
      thanks[index].published = published
)
