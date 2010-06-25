$.expr[":"].econtains = function(obj, index, meta, stack){
return (obj.textContent || obj.innerText || $(obj).text() || "").toLowerCase() == meta[3].toLowerCase();
}
