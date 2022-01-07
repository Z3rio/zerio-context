let ButtonsData = [];
let Buttons = [];
let Button = [];

const OpenMenu = (data) => {
    DrawButtons(data)
    $("#container").animate({
        "right": "2vh"
    }, 250)
}

const CloseMenu = () => {
    ButtonsData = [];
    Buttons = [];
    Button = [];
    $("#container").animate({
        "right": "-50%"
    }, 400)
    setTimeout(function() {
        for (let i = 0; i < ButtonsData.length; i++) {
            // let id = ButtonsData[i].id
            $(".button").remove();
        }
    }, 400)
};

const DrawButtons = (data) => {
    ButtonsData = data
    for (let i = 0; i < ButtonsData.length; i++) {
        let header = ButtonsData[i].header
        let message = ButtonsData[i].txt
        // let id = ButtonsData[i].id
        let element

        element = $(`
            <div class="button" id=`+i+`>
              <div class="header" id=`+i+`>`+header+`</div>
              <div class="txt" id=`+i+`>`+message !== undefined ? message : ""+`</div>
            </div>`
        );
        $('#buttons').append(element);
        Buttons[i] = element
        if (ButtonsData[i].params) {
            Button[i] = ButtonsData[i].params
        }
    }
};

$(document).click(function(event){
    let $target = $(event.target);
    if ($target.closest('.button').length && $('.button').is(":visible")) {
        let id = event.target.id;
        if (!Button[id]) return
        PostData(id)
    }
})

const PostData = (id) => {
    $.post(`https://zerio-context/dataPost`, JSON.stringify(Button[id]))
    return CloseMenu();
}

const CancelMenu = () => {
    $.post(`https://zerio-context/cancel`)
    return CloseMenu();
}

window.addEventListener("message", (evt) => {
    const data = evt.data
    const info = data.data
    const action = data.action
    switch (action) {
        case "OPEN_MENU":
            return OpenMenu(info);
        case "CLOSE_MENU":
            return CloseMenu();
        default:
            return;
    }
})

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESCAPE
            CancelMenu()
            break
        case 8: // BACKSPACE
            CancelMenu()
            break
    }
})
