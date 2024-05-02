var answers = { 1:'b' , 2:'e' , 3:'g' };
function checkQuestions() {
var form_elements = document.question_form.elements.length;

for ( var i = 0; i < form_elements; i++ ){
  var type = question_form.elements[i].type;
    if ( type == "radio" ){
      var quest = question_form.elements[i];
  //if ( quest.checked ) {
       var question_index = parseInt(quest.name.split('_')[1]);
        //}
    if ( quest.value == answers[question_index] ) {
          //quest.parentNode.style.border = '1px solid green';
        quest.parentNode.style.color = 'green';} 
    else {
        //quest.parentNode.style.border = '1px solid red';
        quest.parentNode.style.color = 'red';
          }
       }
    }
 }
