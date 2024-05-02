var num = 1;
document.getElementById('add').addEventListener("click",addInput);
function addInput(){
var newInput = '<input type="text" placeholder="Приходи:" class="type-1" name="input'+num+'"/><br> ';
   document.getElementById('newField').innerHTML += newInput;  
   num++;
var newInput = '<input type="text" placeholder="Разходи:" class="type-1" name="input'+num+'"/><br> ';
   document.getElementById('newField').innerHTML += newInput;  
   num++;
}