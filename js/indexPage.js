/*!
* Start Bootstrap - Agency v7.0.11 (https://startbootstrap.com/theme/agency)
* Copyright 2013-2022 Start Bootstrap
* Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-agency/blob/master/LICENSE)
*/
//
// Scripts
// 

// Home page navbar (index.html)
window.addEventListener('DOMContentLoaded', event => {
    toggleModal();
});
    

function toggleModal(){

    // Check if URL includes CCAT first before cookie
    var link = window.location.href;

    let modalName = link.substring(link.lastIndexOf("#")+1);
    console.log(modalName);
    var modalID;
    switch(modalName){
        case "ccat-acquisition-news":
            modalID = "ccat-acquisition-news";
            break;
        case "bugeye-acquisition-news":
            modalID = "bugeye-acquisition-news";
        default:
            break;
    }
    if(modalID != null){
        let myModal = new bootstrap.Modal(document.getElementById(modalID), {});
        myModal.show();
        return;
    }
    

    // // If no CCAT, its the base URL and check for cookies
    // var bugeye = getCookie("show-bugeye");
    // // if its null add it and show the modal
    // if (bugeye == null){
    //     let myModal = new bootstrap.Modal(document.getElementById('bugeye-acquisition-news'), {});
    //     myModal.show();
    //     document.cookie += "show-bugeye=false; max-age=31536000"; // set for 1 yr
    // }

}


function getCookie(name) {
    var dc = document.cookie;
    var prefix = name + "=";
    var begin = dc.indexOf("; " + prefix);
    if (begin == -1) {
        begin = dc.indexOf(prefix);
        if (begin != 0) return null;
    }
    else
    {
        begin += 2;
        var end = document.cookie.indexOf(";", begin);
        if (end == -1) {
        end = dc.length;
        }
    }
    // because unescape has been deprecated, replaced with decodeURI
    //return unescape(dc.substring(begin + prefix.length, end));
    return decodeURI(dc.substring(begin + prefix.length, end));
} 
