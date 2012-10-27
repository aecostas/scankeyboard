Qt.include("phrases.js")

var alphabet=["_", "a","b","c","d","e","f","g","h","i","j","k","l","m","n" ,"o" ,"p","r","s","t","u" ,"v","w","x","y","z"]

var current_pos=0;
var current_phrase=0
var current_user=-1;
var steps_per_character=0;
var steps_per_user=0;

/// start of selection time
var start_time;

/// Selections time per character and phrase
var selection_time;

function init() {
    selection_time = new Array(phrases.length)
    for (var i=0; i < phrases.length; i++) {
        selection_time[i] = new Array()
    }// for
}// init

function timeout() {
    var second_pos;
    var third_pos;
    current_pos = (current_pos+1) % alphabet.length

    second_pos= (current_pos+1) % alphabet.length
    third_pos= (current_pos+2) % alphabet.length

    celda1.charText = alphabet[current_pos]
    celda2.charText = alphabet[second_pos]
    celda3.charText = alphabet[third_pos]

    start_time=new Date()
}


function select(element, key) {

    if (page.state==="login") {

        if (displayText.state=="init") {
            displayText.text=""
            displayText.state="ready"
        }

        if (key === Qt.Key_Return) {
            if (login(displayText.text) === true) {
                page.state="keyboard"
                loginscreen.visible=false;
                displayText.text="<Your name>"
                keyboardRectangle.visible = true
                idtimeout.running=true
                page.focus=true

            }

        }// if key == return

    } else if (page.state==="keyboard"){

        var current_date=new Date();
        var gap = current_date.getTime() - start_time.getTime();

        // almacenar tiempo en que pulso la tecla
        // (habria que almacenar solo si es pulsacion corta -> HACERLO EN EL RELEASE)
        selection_time[current_phrase][selection_time[current_phrase].length] = gap

        console.log("Primera: "+selection_time[0])
        console.log("Segunda: "+selection_time[1])
        console.log("Tercera: "+selection_time[2])

        if (current_pos !== -1) {
            element.text = element.text+alphabet[current_pos]

            if (alphabet[current_pos] ===  phrases[current_phrase][element.text.length - 1] ) {
                //element.text = element.text+alphabet[current_pos]
            } else {
               //   element.text = element.text+"<span style=\"color:'red'\">"+alphabet[current_pos]+"</span>"
                console.log("[Error] Expected: "+phrases[current_phrase][element.text.length - 1]+"  Given: "+alphabet[current_pos]);
            }

            if (element.text.length === phrases[current_phrase].length) {
                if (current_phrase === phrases.length-1) {
                    page.state="login"
                    displayText.state="init"
                    loginscreen.visible=true
                    idtimeout.stop()
                    displayText.focus = true
                    current_phrase = 0

                    for (var i=0;i<selection_time.length; i++) {
                        selection_time[i] = new Array();
                    }

                } else {
                    current_phrase = current_phrase + 1
                }

                current_pos=-1
                sampleText.text = phrases[current_phrase]
                element.text = ""
            }

        } else {

            element.text = element.text+alphabet[0]

        }
        current_pos=-1

        idtimeout.stop()
        timeout()
        idtimeout.start()
    }// if page.state == keyboard

}


function login(name) {

    console.log("Login with name: "+name)
    var db = openDatabaseSync("keyboard", "1.0", "The Example QML SQL!", 1000000);
    var text= "?"
    var rvalue = false;

    db.transaction(
        function(tx) {

             var result = tx.executeSql('CREATE TABLE IF NOT EXISTS Users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)');

             var rs = tx.executeSql('SELECT * FROM Users where name="'+name+'"');

             if (rs.rows.length === 0) {
                 rs =  tx.executeSql('insert into Users (name) values ("'+name+'")');
                 console.log("Inserted id: " + rs.insertId);
                 rvalue=true;
                 current_user = rs.insertId;
             }

        }// function tx
    )

    return rvalue;
}

