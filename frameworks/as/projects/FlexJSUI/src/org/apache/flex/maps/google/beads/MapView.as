////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package org.apache.flex.maps.google.beads
{
	import flash.events.Event;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;
	
	import org.apache.flex.core.IBeadView;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.core.UIBase;
	import org.apache.flex.events.Event;
	import org.apache.flex.events.IEventDispatcher;
	import org.apache.flex.maps.google.Map;
	import org.apache.flex.maps.google.Place;
	
	/**
	 *  The MapView bead class displays a Google Map using HTMLLoader.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion FlexJS 0.0
	 */
	public class MapView implements IBeadView
	{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function MapView()
		{
		}
		
		private var _loader:HTMLLoader;
		
		private var _strand:IStrand;
		
		/**
		 *  @copy org.apache.flex.core.IBead#strand
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function set strand(value:IStrand):void
		{
			_strand = value;
			
			_loader = new HTMLLoader();
			_loader.x = 0;
			_loader.y = 0;
			_loader.width = UIBase(value).width;
			_loader.height = UIBase(value).height;
			
			IEventDispatcher(_strand).addEventListener("widthChanged",handleSizeChange);
			IEventDispatcher(_strand).addEventListener("heightChanged",handleSizeChange);
						
			(_strand as UIBase).addChild(_loader);
			
			var token:String = Map(_strand).token;
			if (token)
				page = pageTemplateStart + "&key=" + token + pageTemplateEnd;
			else
				page = pageTemplateStart + pageTemplateEnd;
			
			if (page) {
				_loader.loadString(page);
				_loader.addEventListener(flash.events.Event.COMPLETE, completeHandler);
			}
		}
		
		private function completeHandler(event:flash.events.Event):void
		{
			trace("htmlLoader complete");
			
			if (_loader && page) {
				_loader.window.map.center_changed = onMapCentered;
				_loader.window.map.bounds_changed = onMapBoundsChanged;
				_loader.window.map.zoom_changed   = onMapZoomChanged;
				_loader.window.map.dragend        = onMapDragEnd;
				
				// custom event handlers
				_loader.window.addEventListener("searchResults",onSearchResults);
			}
			
			IEventDispatcher(_strand).dispatchEvent(new org.apache.flex.events.Event("ready"));
		}
				
		private var page:String;
		
		/**
		 *  Adjusts the map to the given coordinate and zoom level.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function mapit(lat:Number, lng:Number, zoomLevel:Number):void
		{
			if (_loader && page) {
				_loader.window.mapit(lat,lng,zoomLevel);
			}
		}
		
		/**
		 *  Finds the given address and places a marker on it. This function may be dropped
		 *  since centerOnAddress + markCurrentLocation does the same thing.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function geoCodeAndMarkAddress(address:String):void
		{
			if (_loader && page) {
				_loader.window.codeaddress(address);
			}
		}
		
		/**
		 * Centers the map on the address given.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function centerOnAddress(address:String):void
		{
			if (_loader && page) {
				_loader.window.centeronaddress(address);
			}
		}
		
		/**
		 * Marks the current center of the map.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function markCurrentLocation():void
		{
			if (_loader && page) {
				_loader.window.markcurrentlocation();
			}
		}
		
		/**
		 * Performs a search near the center of map. The result is a set of
		 * markers displayed on the map.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function nearbySearch(placeName:String):void
		{
			if (_loader && page) {
				_loader.window.nearbysearch(placeName);
			}
		}
		
		/**
		 * Clears the search result markers from the map.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function clearSearchResults():void
		{
			if (_loader && page) {
				_loader.window.clearmarkers();
			}
		}
		
		/**
		 * Sets the zoom factor of the map.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function setZoom(zoom:Number):void
		{
			if (_loader && page) {
				_loader.window.map.setZoom(zoom);
			}
		}
		
		/**
		 * @private
		 */
		private function handleSizeChange(event:org.apache.flex.events.Event):void
		{
			_loader.width = UIBase(_strand).width;
			_loader.height = UIBase(_strand).height;
		}
		
		/**
		 * @private
		 */
		private function onMapCentered():void
		{
			IEventDispatcher(_strand).dispatchEvent( new org.apache.flex.events.Event("centered") );
		}
		
		/**
		 * @private
		 */
		private function onMapBoundsChanged():void
		{
			IEventDispatcher(_strand).dispatchEvent( new org.apache.flex.events.Event("boundsChanged") );
		}
		
		/**
		 * @private
		 */
		private function onMapZoomChanged():void
		{
			IEventDispatcher(_strand).dispatchEvent( new org.apache.flex.events.Event("zoomChanged") );
		}
		
		/**
		 * @private
		 */
		private function onMapDragEnd():void
		{
			IEventDispatcher(_strand).dispatchEvent( new org.apache.flex.events.Event("dragEnd") );
		}
		
		/**
		 * @private
		 */
		private function onSearchResults(event:*):void
		{
			var results:Array = [];
			for(var i:int=0; i < event.results.length; i++) {
				var result:Place = new Place();
				result.geometry.location.lat = event.results[i].geometry.location.lat();
				result.geometry.location.lng = event.results[i].geometry.location.lng();
				result.icon = event.results[i].icon;
				result.id = event.results[i].id;
				result.name = event.results[i].name;
				result.reference = event.results[i].reference;
				result.vicinity = event.results[i].vicinity;
				results.push(result);
			}
			
			Map(_strand).searchResults = results;
			IEventDispatcher(_strand).dispatchEvent(new org.apache.flex.events.Event("searchResult"));
		}
		
		/**
		 * @private
		 * This page definition is used with HTMLLoader to bring in the Google Maps
		 * API (a Google APP token is required).
		 */
		private static var pageTemplateStart:String = '<!DOCTYPE html>'+
			'<html>'+
			'  <head>'+
			'    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />'+
			'    <style type="text/css">'+
			'      html { height: 100% }'+
			'      body { height: 100%; margin: 0; padding: 0 }'+
			'      #map-canvas { height: 100% }'+
			'    </style>'+
			'    <script type="text/javascript"'+
			'      src="https://maps.googleapis.com/maps/api/js?v=3.exp';
		
		private static var pageTemplateEnd:String = '&libraries=places&sensor=false">'+
			'    </script>'+
			'    <script type="text/javascript">'+
			'      var map;'+
			'      var geocoder;'+
			'      var currentCenter;' +
			'      var service;' +
			'      var places;' +
			'      var markers;'+
			'      function mapit(lat, lng, zoomLevel) {' +
			'        currentCenter = new google.maps.LatLng(lat, lng);'+
			'        if (map == null) {' +
			'            var mapOptions = {'+
			'              center: currentCenter,'+
			'              zoom: zoomLevel'+
			'            };'+
			'            map = new google.maps.Map(document.getElementById("map-canvas"),'+
			'              mapOptions);' +
			'        }' +
			'        map.addEventListener("center_changed", function() {' +
			'            currentCenter = map.getCenter();' +
			'        });' +
			'        map.addEventListener("bounds_changed", function() {' +
			'            currentCenter = map.getCenter();' +
			'        });' +
			'        map.setCenter(currentCenter);'+
			'      };'+
			'      function codeaddress(address) {'+
			'        if (!geocoder) geocoder = new google.maps.Geocoder();'+
		    '        geocoder.geocode( { "address": address}, function(results, status) {'+
			'           if (status == google.maps.GeocoderStatus.OK) {'+
			'             currentCenter = results[0].geometry.location;'+
			'             map.setCenter(currentCenter);'+
			'             var marker = new google.maps.Marker({'+
			'                map: map,'+
			'                position: currentCenter,'+
			'            });'+
			'            } else {'+
			'                alert("Geocode was not successful for the following reason: " + status);'+
			'            }'+
			'        });'+
		    '      };'+
			'      function centeronaddress(address) {'+
			'        if (!geocoder) geocoder = new google.maps.Geocoder();'+
			'        geocoder.geocode( { "address": address}, function(results, status) {'+
			'          if (status == google.maps.GeocoderStatus.OK) {'+
			'             currentCenter = results[0].geometry.location;'+
			'             map.setCenter(currentCenter);' +
			'          } else {'+
			'                alert("Geocode was not successful for the following reason: " + status);'+
			'          }'+
			'        });'+
			'      };'+
			'      function markcurrentlocation() {'+
			'         createMarker(currentCenter);'+
			'      };' +
			'      function createMarker(location) {' +
			'         var marker = new google.maps.Marker({'+
			'            map: map,'+
			'            position: location,'+
			'         });' +
			'         return marker;'+
			'      };' +
			'      function clearmarkers() {' +
			'        if (markers) {' +
			'          for(var i=0; i < markers.length; i++) {' +
			'             markers[i].setMap(null);' +
			'          }' +
			'          markers = null;' +
			'        }' +
			'      };'+
			'      function nearbysearch(placename) {' +
			'         if (markers == null) markers = [];' +
			'         service = new google.maps.places.PlacesService(map);'+
		    '         service.nearbySearch({"location": currentCenter,' +
			'           "radius": 5000,' +
			'           "name": placename}, function(results, status) {' +
			'              places = results;' +
			'              if (status == google.maps.places.PlacesServiceStatus.OK) {' +
			'                 for(var i=0; i < results.length; i++) {' +
			'                    var place = results[i];' +
			'                    markers.push(createMarker(place.geometry.location));' +
			'                 }' +
			'                 var event = document.createEvent("Event");' +
			'                 event.results = places;'+
            '                 event.initEvent("searchResults", true, true);' +
			'                 window.dispatchEvent(event);' +
			'              }' +
			'          });'+
			'      };'+
			'      function initialize() {'+
			'        mapit(37.333, -121.900, 12);'+
			'      };'+
			'      google.maps.event.addDomListener(window, "load", initialize);'+
			'    </script>'+
			'  </head>'+
			'  <body>'+
			'    <div id="map-canvas"></div>'+
			'  </body>'+
			'</html>';
	}
	
}