/*
 * searchField - jQuery plugin to display and remove
 * a default value in a searchvalue on blur/focus
 *
 * Copyright (c) 2008
 *
 * $Id$
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 *
 */
/**
 * Clear the help text in a search field (either in the value or title attribute)
 * when focused, and restore it on blur if nothing was entered. If the value is
 * blank but there is a title attribute, the title will be moved to the initial value.
 *
 * @example $('#quicksearch').searchField();
 * @before <input id="quicksearch" title="Enter search here" name="quicksearch" />
 * @result <input id="quicksearch" value="Enter search here" name="quicksearch" />
 *
 * @name searchField
 * @type jQuery
 * @cat Plugins/SearchField
 */
jQuery.fn.searchField=function(e){return this.each(function(){var e=e||this.title;if(!e)return;var t=this,n=$(this);this.type=="password"&&(t=$("<input />").insertBefore(this).css("display",$(this).css("display")).attr("size",this.size).attr("title",this.title).attr("class",this.className).addClass("watermark")[0],this.value?$(t).hide():$(this).hide()),(!t.value||e==this.value)&&$(t).addClass("watermark");if(!this.value||t!=this)t.value=e;$(t).focus(function(){t!=n[0]?($(this).hide(),n.show().focus()):this.value==e&&(this.value="",$(this).removeClass("watermark"))}),$(this).blur(function(){this.value.length||(t!=n[0]?($(t).show(),n.hide()):(this.value=e,$(this).addClass("watermark")))}),$(this).parents("form:first").submit(function(){$(t).hasClass("watermark")&&($(t).attr("value",""),$(t).removeClass("watermark"))})})};