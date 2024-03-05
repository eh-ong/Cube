var currentPath = location.pathname;
var links = document.querySelectorAll('.asidelink');

for (var i = 0; i < links.length; i++) {
    if (links[i].getAttribute('href') === currentPath) {
        links[i].classList.add('active');
        var parentH4 = links[i].closest('.collaps').previousElementSibling;
        if (parentH4 && parentH4.tagName === 'H4') {
            parentH4.classList.add('active');
        }
    }
}

function collaps(element) {
    var content = element.nextElementSibling;
    content.style.display = (content.style.display === 'none' || content.style.display === '') ? 'block' : 'none';
    element.classList.toggle('active');
}