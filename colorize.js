var cols = ["#cc0000", "blue", "green", "purple", "brown"];
var ncols = cols.length;

function colorChar(c) {
    var col = Math.floor(Math.random() * ncols);
    return /\s/.test(c) && c || "<span style='color:" + cols[col] + ";'>" + c + "</span>";
}

function colorize(s) {
    return s.split("").map(colorChar).join("");
}

function colorizeAll(node) {
    if (node === undefined) {
	document.body.innerHTML = colorizeAll(document.body).innerHTML;
	return
    }
    var colorized = document.createElement('div');
    for (var j = 0; j < node.childNodes.length; j++) {
	var n = node.childNodes[j];
	if (n.nodeType == Node.TEXT_NODE) {
            if (! /^\s*$/.test(n.nodeValue)) {
                var temp = document.createElement("span");
                temp.innerHTML = colorize(n.nodeValue);
                colorized.appendChild(temp);
            } else {
                colorized.appendChild(n.cloneNode(true));
            }
	} else {
	    var temp = n.cloneNode(true);
	    temp.innerHTML = colorizeAll(temp).innerHTML;
	    colorized.appendChild(temp);
	}
    }
    return colorized;
}
