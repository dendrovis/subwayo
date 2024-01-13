/*
% Author :             Sam Jian Shen 
% Class :              TS4
% Assessment Title :   Subway Sandwich Interactor 
% Assignment Index :   Lab 3, Assignment - 3 
% Module Code :        CZ3005
% Version :            0.1 
*/
// Voice variables
var voice;
var readText = "";
var arrayToSpeech = "";
// Respond and Prompt variables
var step = -1;
var array,ar,arOp, tempArr, words,wordsOp = [];
var str, opStr = "";
var i,j = 0;
var count, countArr, cnt = 0;
var pengine = new Pengine({
    ask: 'run',
    onprompt: handlePrompt,
    onoutput: handleOutput,
    onsuccess: handleSuccess,
    onfailure: handleFailure,
    onerror: handleError,
});

// Prompt output and number of outputs variables
var outputs = [];
var countOp = 0;

// Prompt handler , it consist of queries messages, generate html code dynamically base on prompt data
function handlePrompt() {
    // Display Queries Text In Sequence
     if (step == -1) {
        $("#msg").html('');
        $("#msg").append('<button class = inibtn type="button" onclick="pengine.respond(\''    +'start' +    '\')">Start</button>');
        step++;
        return;
     }
     if (step == 0) {
        readText = "Welcome to Subway eatfresh, please pick a classify sandwich!";
     } 
     if (step == 1) {
        readText = "Do you have any perferences?";
     }
     if (step == 2 && jQuery.inArray( 'meal', outputs) != -1) {
        readText = "Please pick a classify meal.";
     }
     if (step == 2 && jQuery.inArray( 'custom', outputs) != -1) {
        readText = "Which sandwich bread options would you like to pick?";
     }
     else if (step == 3 && jQuery.inArray( 'meal', outputs) != -1){
        readText = "Which promotion meal would like to pick?";
        step = 5;
     }
     if (step == 3 && jQuery.inArray( 'vegan', outputs) == -1) {
        readText = "Which sandwich meat options would you like to pick?";
     }
     else if (step == 3) {
         step++;
     }
     if (step == 4 && jQuery.inArray( 'custom', outputs) != -1) {
        readText = "Which sandwich salad options would you like to pick?";
     }
     if (step == 5 && jQuery.inArray( 'custom', outputs) != -1) {
        readText = "Which sandwich sauce options would you like to pick?";
     }
     else if (step == 5 && jQuery.inArray( 'promotion', outputs) != -1) {
        readText = "Which promotion meal would like to pick?";
     }
     else if (step == 5 && jQuery.inArray( 'classic', outputs) != -1) {
        readText = "Which classic meal would like to pick?";
     }
     if (step == 6) {
        readText = "Please choose your sandwich size?";
     }
     if (step == 7) {
        readText = "Do you want to add any ala-carte?";
     }
     if (step == 8) {
        readText = "Your order as follows. Please check and confirm.";
     }
     if (step == 9) {
        readText = "Which payment mode would you like to made?";
     }
    $("#msg").html("<h1>" + readText + "</h1>");
    array = convertStringToArray(this.data);
    words = convertStandardWord(array);
    // Display Options available (include images and text derived from prompt data) and conversion to speech 
    arrayToSpeech = ""; //Clear voice text
    $("#p").html('');   //Clear div of text
    $("#fp").html('');  //Clear div of images
    if(step != 8 ) {
        // Display Image and Text Form Options base on their number of options
        if(count == 1){
            i = 0;
            $("#fp").append('<img class = menu src="/apps/assets/options/'+  array[i]  +'.jpg" alt="'+   array[i]  +'" onclick="pengine.respond('+ '\''  +  array[i] + '\''+  ')">');
            $("#p").append('<h1 class = one>' + words[i] + '</h1>');
            arrayToSpeech = arrayToSpeech.concat(words[i]);
        }
        else if(count == 2 ){
            for(i=0; i<count; i++) {
                    $("#fp").append('<img class = menu src="/apps/assets/options/'+  array[i]  +'.jpg" alt="'+   array[i]  +'" onclick="pengine.respond('+ '\''  +  array[i] + '\''+  ')">');
                    $("#p").append('<div class = two'+ (i+1) +'><h1 class = two'+ (i+1) +'_S>' + words[i] + '</h1></div>');
                    if(count-1 != i) 
                    {
                        arrayToSpeech = arrayToSpeech.concat(words[i]);
                        arrayToSpeech = arrayToSpeech.concat(" or ");
                    }
                    else{
                        arrayToSpeech = arrayToSpeech.concat(words[i]);
                        arrayToSpeech = arrayToSpeech.concat(".");
                    }
                }
            }
        else if(count == 3){
            for(i=0; i<count; i++) {
                $("#fp").append('<img class = menu src="/apps/assets/options/'+  array[i]  +'.jpg" alt="'+   array[i]  +'" onclick="pengine.respond('+ '\''  +  array[i] + '\''+  ')">');
                $("#p").append('<div class = three'+ (i+1) +'><h1 class = three'+ (i+1) +'_S>' + words[i] + '</h1></div>');
                if(count-1 != i)
                {
                    arrayToSpeech = arrayToSpeech.concat(words[i]);
                    arrayToSpeech = arrayToSpeech.concat(" or ");
                }
                else{
                    arrayToSpeech = arrayToSpeech.concat(words[i]);
                    arrayToSpeech = arrayToSpeech.concat(".");
                }
            }
        }
        else if(count == 4){
            for(i=0; i<count; i++) {
                $("#fp").append('<img class = menu src="/apps/assets/options/'+  array[i]  +'.jpg" alt="'+   array[i]  +'" onclick="pengine.respond('+ '\''  +  array[i] + '\''+  ')">');
                $("#p").append('<div class = four'+ (i+1) +'><h1 class = four'+ (i+1) +'_S>' + words[i] + '</h1></div>');
                if(count-1 != i)
                {
                    arrayToSpeech = arrayToSpeech.concat(words[i]);
                    arrayToSpeech = arrayToSpeech.concat(" or ");
                }
                else{
                    arrayToSpeech = arrayToSpeech.concat(words[i]);
                    arrayToSpeech = arrayToSpeech.concat(".");
                }
            }
        }
        else{
            alert('oh no need optimization');
        }
        readText = readText.concat("Such as ");
        readText = readText.concat(arrayToSpeech);
    }
    else {
        // Display yes and no button when prompt for confirmation respond
        $("#resultD").append('<button class = leftbtn type="button" onclick="pengine.respond(\''    +'yes' +    '\')">Yes</button>');
        $("#resultD").append('<button class = rightbtn type="button" onclick="pengine.respond(\''   +'no'+      '\')">No</button>');
    }
    // Computerize the speech and invoke voice function (textToSpeech)
    textToSpeech(readText);
    step++;
}
// Return True (When program finish prompting user and all prompt is true)
function handleSuccess() {
    //Clear dynamic div elements
    $("#p").html('');   
    $("#fp").html('');  
    $("#msg").html('');  
    readText = "Your sandwich is preparing. Hope you enjoy our service and have a nice day!";
    $("#msg").append("<h1>" + readText + "</h1>");
    textToSpeech(readText);
    setTimeout(
        function() 
        {
            location.reload();                                                  //Refresh the page
        }, 4000);                                                               //Delay for 4 second for speech to finish execute
    //$("#suc").html("<h1> Return True : " + this.data + "</h1>");              //for debug purpose
}
// Return False (When user select 'no' option when prompt for confirmation)
function handleFailure() {
    //$("#msg").html("<h1> Return false : " + this.data + "</h1>");             //for debug purpose
    location.reload();
}
// Return Error (Bug is discovered here)
function handleError() {
    $("#err").html("<h4> Error : " + this.data + "</h4>");
}
//Return Output after respond the prompt
function handleOutput() {
    var eachVal = 0;
    var totalSum = 0;
    var classify = "";
    $("#result").html('');  //clear element
    $("#resultD").html(''); //clear element
    // Display Invoice In Proper manner base on data retrived from prolog
    if(step == 8)
    {
        opStr = this.data.toString();
        arOp = opStr.split(',');
        countArr = arOp.length;
        arOp = filterOp(arOp,countArr);
        countArr = arOp.length;
        
        wordsOp = convertStandardWord(arOp);
        for(i = 0; i < countArr; i++){
            if(i == countArr-4){ //last element of food before total sum
                totalSum = parseFloat(wordsOp[i+2]);
                totalSum = totalSum.toFixed(2); //round to 2 decimal place
                $("#result").append('<h1 class = "result_last" > ' + arOp[i+1] + ' Price   &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;         $' +  totalSum +'</h1>');
                break;
            } 
            else if(i % 3 == 0){
                eachVal = parseFloat(wordsOp[i+2])
                eachVal = eachVal.toFixed(2); //round to 2 decimal place
                //Meal Option is Choose
                if(arOp[countArr-1] == 8){ 
                    if(arOp[i] == 1){
                        classify = "Meal";
                    }
                    if(arOp[i] == 2){
                        classify = "Top Up";
                    }
                    if(arOp[i] == 3){
                        classify = "Sides";
                    }
                    
                }
                //Custom Option is Choose
                else{                       
                    if(arOp[i]  == 1){
                        classify = "Bread";
                    }
                    if(arOp[i] == 2){
                        classify = "Salad";
                    }
                    if(arOp[i] == 3){
                        classify = "Sauce";
                    }
                    if(arOp[i] == 4){
                        classify = "Meat";
                    }
                    if(arOp[i] == 5){
                        classify = "Top Up";
                    }
                    if(arOp[i] == 6){
                        classify = "Sides";
                    }
                }
                // Display Invoice
                $("#result").append('<h1 class = "result" > ' + arOp[i]  +'. +$' +  eachVal + ' (' + classify +  '&emsp;: '   +  wordsOp[i+1] + ')</h1>');
            }
        }   
    }
    else
    {
        //$("#op").html("<h1> Output : " + this.data + "</h1>"); //for debug purpose
    }
    // To Show Credential Data is being process
    if (step == 10){
        $("#msg").html("<h1> Processing Please Wait </h1>"); 
    }
    // Keep a copy of user selected options during prompting
    outputs[countOp] = this.data;
    countOp++;
}
// Convert String to Array
function convertStringToArray(s){   
     s = s.slice(0, -1);
     s = s.substring(1);
     a = s.split(',');
     count = a.length;
     return a;
}
// Generate voice
function textToSpeech(str) {
    // Invoke speech object
	voice = new SpeechSynthesisUtterance();
	voice.rate = 1;
	voice.pitch = 0.5;
	voice.text = str;
    // Speak Operation
    window.speechSynthesis.speak(voice); //To cancel the current voice running
    window.speechSynthesis.cancel();     //Invoke cancel
    window.speechSynthesis.speak(voice); //Invoke next voice in the queue
}
// Convert to proper wording by remove all existing '_'
function convertStandardWord(a){
    str = a.toString();
    str = str.replace(/_/g, " ");
    a = str.split(',');
    return a;
}
// Convert Output for Invoice Display Format
function filterOp(aOp,countA){
    ar = [];
    j = 1;
    for(i = 0;i < countA;i++){
        if(i % 2 == 0){                     // Every even number and remove
            ar.push(j);                     // Indexing Label
            ar.push(aOp[i]);                // The food name
            ar.push(aOp[i+1]);              // The value of the food
            j++
        }
    }
    ar.push(countA);                        //Set last array as the total number of origin //14 = custom, 8 = meal
    return ar;
}