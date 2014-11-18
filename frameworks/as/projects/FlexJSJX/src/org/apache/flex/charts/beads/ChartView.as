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
package org.apache.flex.charts.beads
{
	import org.apache.flex.charts.core.IAxisGroup;
	import org.apache.flex.charts.core.IHorizontalAxisBead;
	import org.apache.flex.charts.core.IVerticalAxisBead;
	import org.apache.flex.core.IBeadLayout;
	import org.apache.flex.core.IBeadView;
	import org.apache.flex.core.IParent;
	import org.apache.flex.core.ISelectionModel;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.core.UIBase;
	import org.apache.flex.core.ValuesManager;
	import org.apache.flex.events.Event;
	import org.apache.flex.events.IEventDispatcher;
	import org.apache.flex.html.beads.ListView;
	
	public class ChartView extends ListView implements IBeadView
	{
		public function ChartView()
		{
			super();
		}
		
		private var _strand:IStrand;
		private var _horizontalAxisGroup:IAxisGroup;
		private var _verticalAxisGroup:IAxisGroup;
		
		/**
		 *  @copy org.apache.flex.core.IBead#strand
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		override public function set strand(value:IStrand):void
		{
			super.strand = value;
			
			_strand = value;
			IEventDispatcher(_strand).addEventListener("widthChanged", handleLocalChange);
			IEventDispatcher(_strand).addEventListener("heightChanged",handleLocalChange);
			
			var listModel:ISelectionModel = value.getBeadByType(ISelectionModel) as ISelectionModel;
			listModel.addEventListener("dataProviderChanged", dataProviderChangeHandler);
			
			var haxis:IHorizontalAxisBead = _strand.getBeadByType(IHorizontalAxisBead) as IHorizontalAxisBead;
			if (haxis && _horizontalAxisGroup == null) {
				_horizontalAxisGroup = new (ValuesManager.valuesImpl.getValue(value, "iHorizontalAxisGroup")) as IAxisGroup;
				haxis.axisGroup = _horizontalAxisGroup;
				IParent(_strand).addElement(_horizontalAxisGroup);
			}
			
			var vaxis:IVerticalAxisBead = _strand.getBeadByType(IVerticalAxisBead) as IVerticalAxisBead;
			if (vaxis && _verticalAxisGroup == null) {
				_verticalAxisGroup = new (ValuesManager.valuesImpl.getValue(value, "iVerticalAxisGroup")) as IAxisGroup;
				vaxis.axisGroup = _verticalAxisGroup;
				IParent(_strand).addElement(_verticalAxisGroup);
			}
			
			if (_strand.getBeadByType(IBeadLayout) == null)
			{
				var layout:IBeadLayout = new (ValuesManager.valuesImpl.getValue(_strand, "iBeadLayout")) as IBeadLayout;
				_strand.addBead(layout);
			}
			
			handleLocalChange(null);
		}
		
		public function get horizontalAxisGroup():IAxisGroup
		{
			return _horizontalAxisGroup;
		}
		
		public function get verticalAxisGroup():IAxisGroup
		{
			return _verticalAxisGroup;
		}
		
		/**
		 * @private
		 */
		override protected function dataProviderChangeHandler(event:Event):void
		{
			if (verticalAxisGroup) {
				verticalAxisGroup.removeAllElements();
			}
			
			if (horizontalAxisGroup) {
				horizontalAxisGroup.removeAllElements();
			}
			
			dataGroup.removeAllElements();
		}
		
		/**
		 * @private
		 */
		private function handleLocalChange(event:Event):void
		{	
			var widthAdjustment:Number = 0;
			var heightAdjustment:Number = 0;
			
			var vaxis:IVerticalAxisBead = _strand.getBeadByType(IVerticalAxisBead) as IVerticalAxisBead;
			var haxis:IHorizontalAxisBead = _strand.getBeadByType(IHorizontalAxisBead) as IHorizontalAxisBead;
			
			if (vaxis) {
				widthAdjustment = vaxis.axisWidth;
			}
			
			if (haxis) {
				heightAdjustment = haxis.axisHeight;
			}
			
			UIBase(dataGroup).x = widthAdjustment;
			UIBase(dataGroup).y = 0;
			UIBase(dataGroup).width = UIBase(dataGroup).width - widthAdjustment;
			UIBase(dataGroup).height= UIBase(dataGroup).height - heightAdjustment;
			
			if (verticalAxisGroup) {
				UIBase(verticalAxisGroup).x = 0;
				UIBase(verticalAxisGroup).y = 0;
				UIBase(verticalAxisGroup).width = widthAdjustment;
				UIBase(verticalAxisGroup).height = UIBase(dataGroup).height;
			}
			
			if (horizontalAxisGroup) {
				UIBase(horizontalAxisGroup).x = widthAdjustment;
				UIBase(horizontalAxisGroup).y = UIBase(dataGroup).height;
				UIBase(horizontalAxisGroup).width = UIBase(dataGroup).width;
				UIBase(horizontalAxisGroup).height = heightAdjustment;
			}
		}
	}
}