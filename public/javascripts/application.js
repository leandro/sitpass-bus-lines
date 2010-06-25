// INI.core extensions
$.expr[':'].icontains = function(obj, index, meta, stack){
return (obj.textContent || obj.innerText || jQuery(obj).text() || '').toLowerCase().indexOf(meta[3].toLowerCase()) >= 0;
};
// END.core extensions

$(function () {

  (function(jq) {
    if(jq.length < 1) return;
    var _default_val = 'Filtragem rápida';
    jq.attr('autocomplete', 'off');
    jq.bind('focus', function(ev) {
      if(jq.val() == _default_val) { 
        jq.val('');
        jq.removeClass('filter-inactive');
      }
      jq.addClass('filter-focused');
    }).bind('blur', function(ev) {
      if(!jQuery.trim(jq.val())) {
        jq.val(_default_val);
        jq.addClass('filter-inactive');
        $('ul.linhas li').show();
      }
      jq.removeClass('filter-focused');
    }).bind('keyup', function(ev) {
      if(!jQuery.trim($(this).val())) {
        $('ul.linhas li').show();
        return true;
      }
      var els = $('ul.linhas li:icontains(' + $(this).val() + ')');
      $('ul.linhas li').show().not(els).hide();
    });
  })($('#line-filter'));

});
