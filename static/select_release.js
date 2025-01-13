const versions = [
  '0.15.0',
  '0.14.0',
  '0.13.2',
];

// Regex for finding the version in the URL.
let regexp = /[0-9]+\.[0-9]+\.[0-9]+/;

function createVersionDropdown() {
    let main = document.getElementsByTagName('main')[0];

    // Create root version selector element.
    const container = document.createElement('div');
    container.id = 'pick-version';
    main.prepend(container);

    // Create "Version:" label.
    const label = document.createElement('p');
    label.textContent = 'Version:';
    container.append(label);

    // Create dropdown element.
    const select = document.createElement('select');
    select.onchange = event => {
        let version = versions[event.target.selectedIndex];
        let newPath = '/releases/' + version + '/';
        window.location.pathname = window.location.pathname.replace(/.*\//, newPath);
    };
    container.append(select);

    // Get URL's version from path.
    const currentVersion = window.location.pathname.match(regexp)?.[0];

    // Add a dropdown entry for each version.
    for (let i = 0; i < versions.length; i++) {
        const version = versions[i];

        const option = document.createElement('option');
        option.value = version;
        option.innerHTML = version;
        select.append(option);

        // Select the URL's version by default.
        if (version === currentVersion) {
            select.selectedIndex = i;
        }
    }
}

window.onload = createVersionDropdown;
