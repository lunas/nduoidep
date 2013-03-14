/*
  Adapt.js licensed under GPL and MIT.

  Read more here: http://adapt.960.gs
*/
// Closure.
(function(e,t,n,r){function h(e,t){c.href=i,s=i,u&&u(e,t)}function p(){clearInterval(o);var n=e.innerWidth||t.documentElement.clientWidth||t.body.clientWidth||0,u,p,d,v,m,g,y=l,b=l-1;while(y--){u=f[y].split("="),p=u[0],g=u[1]?u[1].replace(/\s/g,""):y,m=p.match("to"),d=m?parseInt(p.split("to")[0],10):parseInt(p,10),v=m?parseInt(p.split("to")[1],10):r;if(!v&&y===b&&n>d||n>d&&n<=v){i=a+g;break}i=""}s?s!==i&&h(y,n):(h(y,n),a&&(t.head||t.getElementsByTagName("head")[0]).appendChild(c))}function d(){clearInterval(o),o=setInterval(p,100)}if(!n)return;var i,s,o,u=typeof n.callback=="function"?n.callback:r,a=n.path?n.path:"",f=n.range,l=f.length,c=t.createElement("link");c.rel="stylesheet",p(),n.dynamic&&(e.addEventListener?e.addEventListener("resize",d,!1):e.attachEvent?e.attachEvent("onresize",d):e.onresize=d)})(this,this.document,ADAPT_CONFIG);