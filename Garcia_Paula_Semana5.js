//1
var menu = document.getElementById("page-menu-wrap");
menu.style.backgroundColor = "#3e5de8";

//2
var menuTitle = document.getElementsByClassName("menu-title");
menuTitle.item(0).innerHTML = "Paula García!";

//3
var sliderImage =  document.getElementById("slider");
sliderImage.innerHTML = '<img src="https://pmcvariety.files.wordpress.com/2017/09/coco1.jpg?w=1000&h=563&crop=1" width=100%>';

//4
document.querySelector("header.full-header img").src = "http://goodsamfrc.org/wp-content/uploads/2017/08/Coco_Logo_onWte.gif";

//5
var submenus = document.querySelectorAll('.one-page-menu ul li a');
for (var i =0; i <submenus.length; i++) { submenus[i].style.color = "#f9cc36"}


//6
$('.switcher-trigger').remove();

//7
sliderImage.addEventListener("click", function myFunction() {
    alert("No has visto Coco!!??");
} );


//8
var btn = $("[href='/?page=calendario_electoral']");
btn.click(function(event){
    event.preventDefault(); btn.css("background-color", function getRandomColor() {
  var letters = '0123456789ABCDEF';
  var color = '#';
  for (var i = 0; i < 6; i++) {
    color += letters[Math.floor(Math.random() * 16)];
    }
  return color;
  });
});

//9
//---------get label text
var label = document.getElementsByTagName('label')[0].firstChild.data;

//---------get cedulaInput
var cedulaInput =  document.getElementById("phone");


//10
$("input").blur(function(){
    alert("This input field has lost its focus.");
});
