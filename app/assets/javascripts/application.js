// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require angular
//= require underscore
//= require jquery_ujs
//= require turbolinks
//= require_tree .

/**
* app Module
*
* Description
*/

var app = angular.module('app', []);

app.directive('menu',['$http','$compile',function($http,$compile){
	return {
		// name: 'menuv1',
		scope:true,
		controller: function($scope, $element, $attrs, $transclude) {
			$scope.get_menu = function(id){
			if($scope.menus.indexOf(id)<0){
				$scope.menus.push(id);
				$http.get('/admin/menus/parent/' + id).
				success(function(data, status, headers, config) {
					$scope.data[id] = data;

					var template  = $compile(
						'<table class="table table-hover table-bordered table-condensed">'+
						'<tr>'+
						'<th>Name</th>'+
						'<th>Controller</th>'+
						'<th>Action</th>'+
						'</tr>'+
						'<tr ng-repeat="d in data['+id+']">'+
						'<td>{{ d.name }}</td>'+
						'<td>{{ d.controller }}</td>'+
						'<td>{{ d.action }}</td>'+
						'</tr>'+
						'</table>'
					)($scope);

					$('div.panel-body.'+id).html(
						template
					);
				}).
				error(function(data, status, headers, config) {
				});
			}
		};

		},
		restrict: 'A',
		link: function($scope, el, attrs, controller) {
			id = parseInt(attrs.menu);
			if($scope.menus.indexOf(id)<0){
				el.on('click',function(){
					$scope.get_menu(attrs.menu);
				});
			}

		}
	};
}]);

app.controller('HomeCtrl', ['$scope','$http', function($scope,$http){
	$scope.menus = [];
	$scope.data = {};
}]);