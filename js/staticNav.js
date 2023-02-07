//
// Scripts
// 

// Register event for subsequent changes
// Change dropdown menu links' data-bs-toggle property from "collapse" (mobile) to "dropdown" (desktop)
window.addEventListener('resize', reportWindowSize);
function reportWindowSize() {
    // console.log("Window Resized");
    const mobileMenu = document.getElementById("mainNav");
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

// this call is necessary for keeping mobile menu from collapsing
reportWindowSize();

window.addEventListener('DOMContentLoaded', event => {
    reportWindowSize();

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
    const navbarCollapsible = document.body.querySelector('#mainNav');
    if(navbarCollapsible.nextElementSibling.nodeName == 'HEADER') {
        navbarShrink();
        
        // Shrink the navbar when page is scrolled
        document.addEventListener('scroll', navbarShrink);
    } else {
        navbarCollapsible.classList.add('navbar-shrink')
    }


    // Activate Bootstrap scrollspy on the main nav element
    const mainNav = document.body.querySelector('#mainNav');
    if (mainNav) {
        new bootstrap.ScrollSpy(document.body, {
            target: '#mainNav',
            offset: 74,
        });
    };

    // Collapse responsive navbar when toggler is visible
    const navbarToggler = document.body.querySelector('.navbar-toggler');
    const responsiveNavItems = [].slice.call(
        document.querySelectorAll('#navbarResponsive .nav-link')
    );
    responsiveNavItems.map(function (responsiveNavItem) {
        responsiveNavItem.addEventListener('click', () => {
            if (window.getComputedStyle(navbarToggler).display !== 'none') {
                navbarToggler.click();
            }
        });
    });

});
