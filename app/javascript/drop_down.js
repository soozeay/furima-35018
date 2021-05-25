document.addEventListener('DOMContentLoaded', function(){
  const $pullDownButton = document.getElementById("js-list");
  const $pullDownValue = document.getElementById("js-category-header");
  const $pullDownParents = document.getElementById("js-pull-down");
  const $pullDownChild = document.querySelectorAll(".js-contents");

  $pullDownButton.addEventListener('mouseover', function(){
    $pullDownParents.setAttribute("style", "display:block;")
  });

  $pullDownButton.addEventListener('mouseout', function(){
    $pullDownParents.removeAttribute("style", "display:block;")
  });

  const $Elements = document.querySelectorAll('[hovercolor]');
  $Elements.forEach((e)=>{ 
    e.addEventListener('mouseover',function(){
        this.style.color = this.getAttribute('hovercolor');
    });

    e.addEventListener('mouseout',function(){
        this.style.color = "";
    });
  });
});