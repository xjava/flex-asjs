/**
 * Licensed under the Apache License, Version 2.0 (the 'License');
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an 'AS IS' BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

goog.provide('org.apache.flex.html.beads.ContainerView');

goog.require('org.apache.flex.core.BeadViewBase');



/**
 * @constructor
 * @extends {org.apache.flex.core.BeadViewBase}
 */
org.apache.flex.html.beads.ContainerView = function() {
  this.lastSelectedIndex = -1;
  org.apache.flex.html.beads.ContainerView.base(this, 'constructor');

  this.className = 'ContainerView';
};
goog.inherits(
    org.apache.flex.html.beads.ContainerView,
    org.apache.flex.core.BeadViewBase);


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
org.apache.flex.html.beads.ContainerView.prototype.FLEXJS_CLASS_INFO =
    { names: [{ name: 'ContainerView',
                qName: 'org.apache.flex.html.beads.ContainerView' }],
    interfaces: [org.apache.flex.core.ILayoutParent]
    };


/**
 * @expose
 * @return {Object} value The content view.
 */
org.apache.flex.html.beads.ContainerView.prototype.get_contentView =
    function() {

  return this._strand;
};


/**
 * @expose
 * @return {Object} value The resizeable view.
 */
org.apache.flex.html.beads.ContainerView.prototype.get_resizableView =
function() {

  return this._strand;
};