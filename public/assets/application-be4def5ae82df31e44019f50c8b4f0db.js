(function(e,t){var n=function(){var t=e._data(document,"events");return t&&t.click&&e.grep(t.click,function(e){return e.namespace==="rails"}).length};n()&&e.error("jquery-ujs has already been loaded!");var r;e.rails=r={linkClickSelector:"a[data-confirm], a[data-method], a[data-remote], a[data-disable-with]",inputChangeSelector:"select[data-remote], input[data-remote], textarea[data-remote]",formSubmitSelector:"form",formInputClickSelector:"form input[type=submit], form input[type=image], form button[type=submit], form button:not([type])",disableSelector:"input[data-disable-with], button[data-disable-with], textarea[data-disable-with]",enableSelector:"input[data-disable-with]:disabled, button[data-disable-with]:disabled, textarea[data-disable-with]:disabled",requiredInputSelector:"input[name][required]:not([disabled]),textarea[name][required]:not([disabled])",fileInputSelector:"input:file",linkDisableSelector:"a[data-disable-with]",CSRFProtection:function(t){var n=e('meta[name="csrf-token"]').attr("content");n&&t.setRequestHeader("X-CSRF-Token",n)},fire:function(t,n,r){var i=e.Event(n);return t.trigger(i,r),i.result!==!1},confirm:function(e){return confirm(e)},ajax:function(t){return e.ajax(t)},href:function(e){return e.attr("href")},handleRemote:function(n){var i,s,o,u,a,f,l,c;if(r.fire(n,"ajax:before")){u=n.data("cross-domain"),a=u===t?null:u,f=n.data("with-credentials")||null,l=n.data("type")||e.ajaxSettings&&e.ajaxSettings.dataType;if(n.is("form")){i=n.attr("method"),s=n.attr("action"),o=n.serializeArray();var h=n.data("ujs:submit-button");h&&(o.push(h),n.data("ujs:submit-button",null))}else n.is(r.inputChangeSelector)?(i=n.data("method"),s=n.data("url"),o=n.serialize(),n.data("params")&&(o=o+"&"+n.data("params"))):(i=n.data("method"),s=r.href(n),o=n.data("params")||null);c={type:i||"GET",data:o,dataType:l,beforeSend:function(e,i){return i.dataType===t&&e.setRequestHeader("accept","*/*;q=0.5, "+i.accepts.script),r.fire(n,"ajax:beforeSend",[e,i])},success:function(e,t,r){n.trigger("ajax:success",[e,t,r])},complete:function(e,t){n.trigger("ajax:complete",[e,t])},error:function(e,t,r){n.trigger("ajax:error",[e,t,r])},xhrFields:{withCredentials:f},crossDomain:a},s&&(c.url=s);var p=r.ajax(c);return n.trigger("ajax:send",p),p}return!1},handleMethod:function(n){var i=r.href(n),s=n.data("method"),o=n.attr("target"),u=e("meta[name=csrf-token]").attr("content"),a=e("meta[name=csrf-param]").attr("content"),f=e('<form method="post" action="'+i+'"></form>'),l='<input name="_method" value="'+s+'" type="hidden" />';a!==t&&u!==t&&(l+='<input name="'+a+'" value="'+u+'" type="hidden" />'),o&&f.attr("target",o),f.hide().append(l).appendTo("body"),f.submit()},disableFormElements:function(t){t.find(r.disableSelector).each(function(){var t=e(this),n=t.is("button")?"html":"val";t.data("ujs:enable-with",t[n]()),t[n](t.data("disable-with")),t.prop("disabled",!0)})},enableFormElements:function(t){t.find(r.enableSelector).each(function(){var t=e(this),n=t.is("button")?"html":"val";t.data("ujs:enable-with")&&t[n](t.data("ujs:enable-with")),t.prop("disabled",!1)})},allowAction:function(e){var t=e.data("confirm"),n=!1,i;return t?(r.fire(e,"confirm")&&(n=r.confirm(t),i=r.fire(e,"confirm:complete",[n])),n&&i):!0},blankInputs:function(t,n,r){var i=e(),s,o,u=n||"input,textarea",a=t.find(u);return a.each(function(){s=e(this),o=s.is(":checkbox,:radio")?s.is(":checked"):s.val();if(!o==!r){if(s.is(":radio")&&a.filter('input:radio:checked[name="'+s.attr("name")+'"]').length)return!0;i=i.add(s)}}),i.length?i:!1},nonBlankInputs:function(e,t){return r.blankInputs(e,t,!0)},stopEverything:function(t){return e(t.target).trigger("ujs:everythingStopped"),t.stopImmediatePropagation(),!1},callFormSubmitBindings:function(n,r){var i=n.data("events"),s=!0;return i!==t&&i.submit!==t&&e.each(i.submit,function(e,t){if(typeof t.handler=="function")return s=t.handler(r)}),s},disableElement:function(e){e.data("ujs:enable-with",e.html()),e.html(e.data("disable-with")),e.bind("click.railsDisable",function(e){return r.stopEverything(e)})},enableElement:function(e){e.data("ujs:enable-with")!==t&&(e.html(e.data("ujs:enable-with")),e.data("ujs:enable-with",!1)),e.unbind("click.railsDisable")}},r.fire(e(document),"rails:attachBindings")&&(e.ajaxPrefilter(function(e,t,n){e.crossDomain||r.CSRFProtection(n)}),e(document).delegate(r.linkDisableSelector,"ajax:complete",function(){r.enableElement(e(this))}),e(document).delegate(r.linkClickSelector,"click.rails",function(n){var i=e(this),s=i.data("method"),o=i.data("params");if(!r.allowAction(i))return r.stopEverything(n);i.is(r.linkDisableSelector)&&r.disableElement(i);if(i.data("remote")!==t){if((n.metaKey||n.ctrlKey)&&(!s||s==="GET")&&!o)return!0;var u=r.handleRemote(i);return u===!1?r.enableElement(i):u.error(function(){r.enableElement(i)}),!1}if(i.data("method"))return r.handleMethod(i),!1}),e(document).delegate(r.inputChangeSelector,"change.rails",function(t){var n=e(this);return r.allowAction(n)?(r.handleRemote(n),!1):r.stopEverything(t)}),e(document).delegate(r.formSubmitSelector,"submit.rails",function(n){var i=e(this),s=i.data("remote")!==t,o=r.blankInputs(i,r.requiredInputSelector),u=r.nonBlankInputs(i,r.fileInputSelector);if(!r.allowAction(i))return r.stopEverything(n);if(o&&i.attr("novalidate")==t&&r.fire(i,"ajax:aborted:required",[o]))return r.stopEverything(n);if(s){if(u){setTimeout(function(){r.disableFormElements(i)},13);var a=r.fire(i,"ajax:aborted:file",[u]);return a||setTimeout(function(){r.enableFormElements(i)},13),a}return!e.support.submitBubbles&&e().jquery<"1.7"&&r.callFormSubmitBindings(i,n)===!1?r.stopEverything(n):(r.handleRemote(i),!1)}setTimeout(function(){r.disableFormElements(i)},13)}),e(document).delegate(r.formInputClickSelector,"click.rails",function(t){var n=e(this);if(!r.allowAction(n))return r.stopEverything(t);var i=n.attr("name"),s=i?{name:i,value:n.val()}:null;n.closest("form").data("ujs:submit-button",s)}),e(document).delegate(r.formSubmitSelector,"ajax:beforeSend.rails",function(t){this==t.target&&r.disableFormElements(e(this))}),e(document).delegate(r.formSubmitSelector,"ajax:complete.rails",function(t){this==t.target&&r.enableFormElements(e(this))}),e(function(){csrf_token=e("meta[name=csrf-token]").attr("content"),csrf_param=e("meta[name=csrf-param]").attr("content"),e('form input[name="'+csrf_param+'"]').val(csrf_token)}))})(jQuery),function(e){function u(e){return String(e===null||e===undefined?"":e)}function a(e){return u(e).replace(o,function(e){return s[e]})}var t={method:"GET",queryParam:"q",searchDelay:300,minChars:1,propertyToSearch:"name",jsonContainer:null,contentType:"json",prePopulate:null,processPrePopulate:!1,hintText:"Type in a search term",noResultsText:"No results",searchingText:"Searching...",deleteText:"&times;",animateDropdown:!0,theme:null,zindex:999,resultsLimit:null,enableHTML:!1,resultsFormatter:function(e){var t=e[this.propertyToSearch];return"<li>"+(this.enableHTML?t:a(t))+"</li>"},tokenFormatter:function(e){var t=e[this.propertyToSearch];return"<li><p>"+(this.enableHTML?t:a(t))+"</p></li>"},tokenLimit:null,tokenDelimiter:",",preventDuplicates:!1,tokenValue:"id",allowFreeTagging:!1,allowTabOut:!1,onResult:null,onCachedResult:null,onAdd:null,onFreeTaggingAdd:null,onDelete:null,onReady:null,idPrefix:"token-input-",disabled:!1},n={tokenList:"token-input-list",token:"token-input-token",tokenReadOnly:"token-input-token-readonly",tokenDelete:"token-input-delete-token",selectedToken:"token-input-selected-token",highlightedToken:"token-input-highlighted-token",dropdown:"token-input-dropdown",dropdownItem:"token-input-dropdown-item",dropdownItem2:"token-input-dropdown-item2",selectedDropdownItem:"token-input-selected-dropdown-item",inputToken:"token-input-input-token",focused:"token-input-focused",disabled:"token-input-disabled"},r={BEFORE:0,AFTER:1,END:2},i={BACKSPACE:8,TAB:9,ENTER:13,ESCAPE:27,SPACE:32,PAGE_UP:33,PAGE_DOWN:34,END:35,HOME:36,LEFT:37,UP:38,RIGHT:39,DOWN:40,NUMPAD_ENTER:108,COMMA:188},s={"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#x27;","/":"&#x2F;"},o=/[&<>"'\/]/g,f={init:function(n,r){var i=e.extend({},t,r||{});return this.each(function(){e(this).data("settings",i),e(this).data("tokenInputObject",new e.TokenList(this,n,i))})},clear:function(){return this.data("tokenInputObject").clear(),this},add:function(e){return this.data("tokenInputObject").add(e),this},remove:function(e){return this.data("tokenInputObject").remove(e),this},get:function(){return this.data("tokenInputObject").getTokens()},toggleDisabled:function(e){return this.data("tokenInputObject").toggleDisabled(e),this},setOptions:function(t){return e(this).data("settings",e.extend({},e(this).data("settings"),t||{})),this}};e.fn.tokenInput=function(e){return f[e]?f[e].apply(this,Array.prototype.slice.call(arguments,1)):f.init.apply(this,arguments)},e.TokenList=function(t,s,o){function T(n){return e(t).data("settings").enableHTML?n:a(n)}function N(n){typeof n=="boolean"?e(t).data("settings").disabled=n:e(t).data("settings").disabled=!e(t).data("settings").disabled,d.attr("disabled",e(t).data("settings").disabled),b.toggleClass(e(t).data("settings").classes.disabled,e(t).data("settings").disabled),m&&D(e(m),r.END),v.attr("disabled",e(t).data("settings").disabled)}function C(){if(e(t).data("settings").tokenLimit!==null&&l>=e(t).data("settings").tokenLimit){d.hide(),j();return}}function k(){if(p===(p=d.val()))return;S.html(a(p)),d.width(S.width()+30)}function L(e){return e>=48&&e<=90||e>=96&&e<=111||e>=186&&e<=192||e>=219&&e<=222}function A(){var n=e.trim(d.val()),r=n.split(e(t).data("settings").tokenDelimiter);e.each(r,function(n,r){if(!r)return;e.isFunction(e(t).data("settings").onFreeTaggingAdd)&&(r=e(t).data("settings").onFreeTaggingAdd.call(v,r));var i={};i[e(t).data("settings").tokenValue]=i[e(t).data("settings").propertyToSearch]=r,M(i)})}function O(n){var r=e(e(t).data("settings").tokenFormatter(n)),i=n.readonly===!0?!0:!1;i&&r.addClass(e(t).data("settings").classes.tokenReadOnly),r.addClass(e(t).data("settings").classes.token).insertBefore(w),i||e("<span>"+e(t).data("settings").deleteText+"</span>").addClass(e(t).data("settings").classes.tokenDelete).appendTo(r).click(function(){if(!e(t).data("settings").disabled)return H(e(this).parent()),v.change(),!1});var s=n;return e.data(r.get(0),"tokeninput",n),f=f.slice(0,g).concat([s]).concat(f.slice(g)),g++,B(f,v),l+=1,e(t).data("settings").tokenLimit!==null&&l>=e(t).data("settings").tokenLimit&&(d.hide(),j()),r}function M(n){var r=e(t).data("settings").onAdd;if(l>0&&e(t).data("settings").preventDuplicates){var i=null;b.children().each(function(){var t=e(this),r=e.data(t.get(0),"tokeninput");if(r&&r[o.tokenValue]===n[o.tokenValue])return i=t,!1});if(i){_(i),w.insertAfter(i),Y(d);return}}if(e(t).data("settings").tokenLimit==null||l<e(t).data("settings").tokenLimit)O(n),C();d.val(""),j(),e.isFunction(r)&&r.call(v,n)}function _(n){e(t).data("settings").disabled||(n.addClass(e(t).data("settings").classes.selectedToken),m=n.get(0),d.val(""),j())}function D(n,i){n.removeClass(e(t).data("settings").classes.selectedToken),m=null,i===r.BEFORE?(w.insertBefore(n),g--):i===r.AFTER?(w.insertAfter(n),g++):(w.appendTo(b),g=l),Y(d)}function P(t){var n=m;m&&D(e(m),r.END),n===t.get(0)?D(t,r.END):_(t)}function H(n){var r=e.data(n.get(0),"tokeninput"),i=e(t).data("settings").onDelete,s=n.prevAll().length;s>g&&s--,n.remove(),m=null,Y(d),f=f.slice(0,s).concat(f.slice(s+1)),s<g&&g--,B(f,v),l-=1,e(t).data("settings").tokenLimit!==null&&(d.show().val(""),Y(d)),e.isFunction(i)&&i.call(v,r)}function B(n,r){var i=e.map(n,function(n){return typeof e(t).data("settings").tokenValue=="function"?e(t).data("settings").tokenValue.call(this,n):n[e(t).data("settings").tokenValue]});r.val(i.join(e(t).data("settings").tokenDelimiter))}function j(){E.hide().empty(),y=null}function F(){E.css({position:"absolute",top:e(b).offset().top+e(b).height(),left:e(b).offset().left,width:e(b).width(),"z-index":e(t).data("settings").zindex}).show()}function I(){e(t).data("settings").searchingText&&(E.html("<p>"+T(e(t).data("settings").searchingText)+"</p>"),F())}function q(){e(t).data("settings").hintText&&(E.html("<p>"+T(e(t).data("settings").hintText)+"</p>"),F())}function U(e){return e.replace(R,"\\$&")}function z(e,t){return e.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)("+U(t)+")(?![^<>]*>)(?![^&;]+;)","gi"),function(e,t){return"<b>"+T(t)+"</b>"})}function W(e,t,n){return e.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)("+U(t)+")(?![^<>]*>)(?![^&;]+;)","g"),z(t,n))}function X(n,r){if(r&&r.length){E.empty();var i=e("<ul>").appendTo(E).mouseover(function(t){V(e(t.target).closest("li"))}).mousedown(function(t){return M(e(t.target).closest("li").data("tokeninput")),v.change(),!1}).hide();e(t).data("settings").resultsLimit&&r.length>e(t).data("settings").resultsLimit&&(r=r.slice(0,e(t).data("settings").resultsLimit)),e.each(r,function(r,s){var o=e(t).data("settings").resultsFormatter(s);o=W(o,s[e(t).data("settings").propertyToSearch],n),o=e(o).appendTo(i),r%2?o.addClass(e(t).data("settings").classes.dropdownItem):o.addClass(e(t).data("settings").classes.dropdownItem2),r===0&&V(o),e.data(o.get(0),"tokeninput",s)}),F(),e(t).data("settings").animateDropdown?i.slideDown("fast"):i.show()}else e(t).data("settings").noResultsText&&(E.html("<p>"+T(e(t).data("settings").noResultsText)+"</p>"),F())}function V(n){n&&(y&&J(e(y)),n.addClass(e(t).data("settings").classes.selectedDropdownItem),y=n.get(0))}function J(n){n.removeClass(e(t).data("settings").classes.selectedDropdownItem),y=null}function K(){var n=d.val();n&&n.length&&(m&&D(e(m),r.AFTER),n.length>=e(t).data("settings").minChars?(I(),clearTimeout(h),h=setTimeout(function(){Q(n)},e(t).data("settings").searchDelay)):j())}function Q(n){var r=n+G(),i=c.get(r);if(i)e.isFunction(e(t).data("settings").onCachedResult)&&(i=e(t).data("settings").onCachedResult.call(v,i)),X(n,i);else if(e(t).data("settings").url){var s=G(),o={};o.data={};if(s.indexOf("?")>-1){var u=s.split("?");o.url=u[0];var a=u[1].split("&");e.each(a,function(e,t){var n=t.split("=");o.data[n[0]]=n[1]})}else o.url=s;o.data[e(t).data("settings").queryParam]=n,o.type=e(t).data("settings").method,o.dataType=e(t).data("settings").contentType,e(t).data("settings").crossDomain&&(o.dataType="jsonp"),o.success=function(i){c.add(r,e(t).data("settings").jsonContainer?i[e(t).data("settings").jsonContainer]:i),e.isFunction(e(t).data("settings").onResult)&&(i=e(t).data("settings").onResult.call(v,i)),d.val()===n&&X(n,e(t).data("settings").jsonContainer?i[e(t).data("settings").jsonContainer]:i)},e.ajax(o)}else if(e(t).data("settings").local_data){var f=e.grep(e(t).data("settings").local_data,function(r){return r[e(t).data("settings").propertyToSearch].toLowerCase().indexOf(n.toLowerCase())>-1});c.add(r,f),e.isFunction(e(t).data("settings").onResult)&&(f=e(t).data("settings").onResult.call(v,f)),X(n,f)}}function G(){var n=e(t).data("settings").url;return typeof e(t).data("settings").url=="function"&&(n=e(t).data("settings").url.call(e(t).data("settings"))),n}function Y(e){setTimeout(function(){e.focus()},50)}if(e.type(s)==="string"||e.type(s)==="function"){e(t).data("settings").url=s;var u=G();e(t).data("settings").crossDomain===undefined&&typeof u=="string"&&(u.indexOf("://")===-1?e(t).data("settings").crossDomain=!1:e(t).data("settings").crossDomain=location.href.split(/\/+/g)[1]!==u.split(/\/+/g)[1])}else typeof s=="object"&&(e(t).data("settings").local_data=s);e(t).data("settings").classes?e(t).data("settings").classes=e.extend({},n,e(t).data("settings").classes):e(t).data("settings").theme?(e(t).data("settings").classes={},e.each(n,function(n,r){e(t).data("settings").classes[n]=r+"-"+e(t).data("settings").theme})):e(t).data("settings").classes=n;var f=[],l=0,c=new e.TokenList.Cache,h,p,d=e('<input type="text"  autocomplete="off">').css({outline:"none"}).attr("id",e(t).data("settings").idPrefix+t.id).focus(function(){if(e(t).data("settings").disabled)return!1;(e(t).data("settings").tokenLimit===null||e(t).data("settings").tokenLimit!==l)&&q(),b.addClass(e(t).data("settings").classes.focused)}).blur(function(){j(),e(this).val(""),b.removeClass(e(t).data("settings").classes.focused),e(t).data("settings").allowFreeTagging?A():e(this).val(""),b.removeClass(e(t).data("settings").classes.focused)}).bind("keyup keydown blur update",k).keydown(function(n){var s,o;switch(n.keyCode){case i.LEFT:case i.RIGHT:case i.UP:case i.DOWN:if(!e(this).val())s=w.prev(),o=w.next(),s.length&&s.get(0)===m||o.length&&o.get(0)===m?n.keyCode===i.LEFT||n.keyCode===i.UP?D(e(m),r.BEFORE):D(e(m),r.AFTER):n.keyCode!==i.LEFT&&n.keyCode!==i.UP||!s.length?(n.keyCode===i.RIGHT||n.keyCode===i.DOWN)&&o.length&&_(e(o.get(0))):_(e(s.get(0)));else{var u=null;n.keyCode===i.DOWN||n.keyCode===i.RIGHT?u=e(y).next():u=e(y).prev(),u.length&&V(u)}return!1;case i.BACKSPACE:s=w.prev();if(!e(this).val().length)return m?(H(e(m)),v.change()):s.length&&_(e(s.get(0))),!1;e(this).val().length===1?j():setTimeout(function(){K()},5);break;case i.TAB:case i.ENTER:case i.NUMPAD_ENTER:case i.COMMA:if(y)M(e(y).data("tokeninput")),v.change();else{if(e(t).data("settings").allowFreeTagging){if(e(t).data("settings").allowTabOut&&e(this).val()==="")return!0;A()}else{e(this).val("");if(e(t).data("settings").allowTabOut)return!0}n.stopPropagation(),n.preventDefault()}return!1;case i.ESCAPE:return j(),!0;default:String.fromCharCode(n.which)&&setTimeout(function(){K()},5)}}),v=e(t).hide().val("").focus(function(){Y(d)}).blur(function(){d.blur()}),m=null,g=0,y=null,b=e("<ul />").addClass(e(t).data("settings").classes.tokenList).click(function(t){var n=e(t.target).closest("li");n&&n.get(0)&&e.data(n.get(0),"tokeninput")?P(n):(m&&D(e(m),r.END),Y(d))}).mouseover(function(n){var r=e(n.target).closest("li");r&&m!==this&&r.addClass(e(t).data("settings").classes.highlightedToken)}).mouseout(function(n){var r=e(n.target).closest("li");r&&m!==this&&r.removeClass(e(t).data("settings").classes.highlightedToken)}).insertBefore(v),w=e("<li />").addClass(e(t).data("settings").classes.inputToken).appendTo(b).append(d),E=e("<div>").addClass(e(t).data("settings").classes.dropdown).appendTo("body").hide(),S=e("<tester/>").insertAfter(d).css({position:"absolute",top:-9999,left:-9999,width:"auto",fontSize:d.css("fontSize"),fontFamily:d.css("fontFamily"),fontWeight:d.css("fontWeight"),letterSpacing:d.css("letterSpacing"),whiteSpace:"nowrap"});v.val("");var x=e(t).data("settings").prePopulate||v.data("pre");e(t).data("settings").processPrePopulate&&e.isFunction(e(t).data("settings").onResult)&&(x=e(t).data("settings").onResult.call(v,x)),x&&x.length&&e.each(x,function(e,t){O(t),C()}),e(t).data("settings").disabled&&N(!0),e.isFunction(e(t).data("settings").onReady)&&e(t).data("settings").onReady.call(),this.clear=function(){b.children("li").each(function(){e(this).children("input").length===0&&H(e(this))})},this.add=function(e){M(e)},this.remove=function(t){b.children("li").each(function(){if(e(this).children("input").length===0){var n=e(this).data("tokeninput"),r=!0;for(var i in t)if(t[i]!==n[i]){r=!1;break}r&&H(e(this))}})},this.getTokens=function(){return f},this.toggleDisabled=function(e){N(e)};var R=new RegExp("[.\\\\+*?\\[\\^\\]$(){}=!<>|:\\-]","g")},e.TokenList.Cache=function(t){var n=e.extend({max_size:500},t),r={},i=0,s=function(){r={},i=0};this.add=function(e,t){i>n.max_size&&s(),r[e]||(i+=1),r[e]=t},this.get=function(e){return r[e]}}}(jQuery);