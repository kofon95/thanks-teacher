permitObject = (obj, keys)->
  result = {}
  for key in keys
    result[key] = obj[key]
  result


ThanksCtrl = ($scope, $http, $httpParamSerializer)->
  authToken = document.getElementById("auth_token").value
  authTokenData = $httpParamSerializer({authenticity_token: authToken})
  deleteHeaders = { "Content-Type": "application/x-www-form-urlencoded" }

  $scope.totalPublishedThanks = Number(document.getElementById("total_published_thanks").value)
  $scope.totalUnpublishedThanks = Number(document.getElementById("total_unpublished_thanks").value)

  thanks = []
  $scope.thanks = thanks
  $scope.publishing_filter = '' # all

  $scope.loadThanks = (count) ->
    $http.get("/thanks.json?offset=#{thanks.length}&count=#{count}&show=all")
      .then (resp)->
        $scope.thanks = thanks = thanks.concat resp.data


  $scope.loadThanks(5)



  $scope.removeThank = (index) ->
    thank = thanks[index]
    return if thank.isLoading or !confirm('Вы уверены, что хотите удалить благодарение?')
    $http({
      url: "/thanks/#{thank.id}"
      method: 'DELETE'
      data: authTokenData
      headers: deleteHeaders
    })
    .then (resp) ->
      thanks.splice(index, 1)
      if thank.published
        $scope.totalPublishedThanks--
      else
        $scope.totalUnpublishedThanks--


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
    thank = thanks[index]
    return null if thank.isLoading
    thank.published = published
    saveState = $scope.saveThank(thank)
    if saveState?
      saveState.finally ->
        inc = if published then 1 else -1
        $scope.totalPublishedThanks += inc
        $scope.totalUnpublishedThanks -= inc



ThanksCtrl.$inject = ["$scope", "$http", "$httpParamSerializer"]
angular.module("app", []).controller "ThanksCtrl", ThanksCtrl
