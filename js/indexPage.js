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

    // Navbar shrink function
    var navbarShrink = function () {
        const navbarCollapsible = document.body.querySelector('#mainNav');
        if (!navbarCollapsible) {
            return;
        }
        if (window.scrollY === 0) {
            navbarCollapsible.classList.remove('navbar-shrink')
        } else {
            navbarCollapsible.classList.add('navbar-shrink')
        }

    };

    // Shrink the navbar 
    navbarShrink();

    // Shrink the navbar when page is scrolled
    document.addEventListener('scroll', navbarShrink);

    // Activate Bootstrap scrollspy on the main nav element
    const mainNav = document.body.querySelector('#mainNav');
    if (mainNav) {
        new bootstrap.ScrollSpy(document.body, {
            target: '#mainNav',
            offset: 74,
        });
    };

    // Collapse responsive navbar when toggler is visible
    // const navbarToggler = document.body.querySelector('.navbar-toggler');
    // const responsiveNavItems = [].slice.call(
    //     document.querySelectorAll('#navbarResponsive .nav-link')
    // );
    // responsiveNavItems.map(function (responsiveNavItem) {
    //     responsiveNavItem.addEventListener('click', () => {
    //         if (window.getComputedStyle(navbarToggler).display !== 'none') {
    //             navbarToggler.click();
    //         }
    //     });
    // });


    // Initial Call to reportWindowSize to swap elements for load on desktop
    reportWindowSize();
    // Register event for subsequent changes
    // Change dropdown menu links' data-bs-toggle property from "collapse" (mobile) to "dropdown" (desktop)
    window.addEventListener('resize', reportWindowSize);
    function reportWindowSize() {
        console.log("Window Resized");
        const mobileMenu = document.getElementById("navbar-links-menu");
        var links = mobileMenu.querySelectorAll("a.nav-link.dropdown-toggle");
        for (i = 0; i < links.length; i++){
            let width = screen.width;
            if(width <= 992)
            {
                links[i].setAttribute('data-bs-toggle', 'collapse')
            }
            else
            {
                links[i].setAttribute('data-bs-toggle', 'dropdown')
            }

        }
    }

});