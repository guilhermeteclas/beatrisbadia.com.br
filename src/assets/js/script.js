const tham = document.querySelector(".tham");
const menu = document.querySelector("#menu-mobile");
const links = document.querySelectorAll("#menu-mobile > li > a");

function toggleMenuMobile() {
    tham.classList.toggle('tham-active');
    menu.classList.toggle('hidden');
}

tham.addEventListener('click', () => {
    toggleMenuMobile();
});

links.forEach(function(button) {
    button.addEventListener("click", function() {
      toggleMenuMobile();
    });
  });

