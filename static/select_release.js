const version_pattern = 'v[0-9]+\.[0-9]+\.[0-9]+'
const select = `
<select id="pick-version" onchange="window.location.pathname = window.location.pathname.replace(new RegExp('${version_pattern}', ''), this.options[this.selectedIndex].value)">\
        <option value='v0.13.2'>v0.13.2</option>\
</select>
`
const picker = `<div class="pick-release">${select}</div>`

// Add picker into the document.
document.write(picker);

// Select the right version inside our version picker.
document.getElementById("pick-version").value = window.location.pathname.match(version_pattern)[0];
