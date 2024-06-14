// JS to programatically open modals based on link click

window.addEventListener('DOMContentLoaded', event => {
    toggleModal();
});

addEventListener("hashchange", (event) => {
    setTimeout(function(){
        toggleModal();
    }, 400);
});


function toggleModal(){
    var link = window.location.href;

    let modalName = link.substring(link.lastIndexOf("#")+1);
    var modalID;
    switch(modalName){
        case "engineering-tools":
            modalID = "EngTool";
            break;
        case "mechanical-fabrication":
            modalID = "MechFab";
            break; 
        case "electrical-fabrication":
            modalID = "ElecFabCap";
            break; 
        case "additive-manufacturing":
            modalID = "AddManufact";
            break; 
        case "facilities":
            modalID = "FacilitiesModal";
            break;
        default:
            break;
    }
    if(modalID != null){
        let myModal = new bootstrap.Modal(document.getElementById(modalID), {});
        myModal.show();
    }
}