var pages = ["productivity-hacks", "pricing-scale", "skrivetips", "presentation-evaluation-notes"]
var page = require('webpage').create()
page.viewportSize = {width: 900, height: 600}
page.clipRect = {top: 0, left: 0, width: 900, height: 600}

var next = function() {
    if(pages.length === 0) {
        phantom.exit();
    }
    var name = pages.pop();
    page.open("http://localhost:3000/" + name, function() {
        page.render("phantom-" + name + ".png")
        next();
    });
}
next()
