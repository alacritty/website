# Alacritty Website

This is the source code of the Alacritty terminal emulator website.

## Changelog generation

New changelog entries are generated from Alacritty's changelog using the
`convert_changelog.sh` script. After the generation additional information like
images can be added and the new changelog needs to be appended to the
`changelog.html` manually.

The following script will generate a changelog for version 1.2.3 from the
`partial_changelog` file. To do so, the `changelog_template.html` must be inside
the working directory.

```sh
convert_changelog.sh partial_changelog 1.2.3
```

The `partial_changelog` file must contain the individual changelog entries and
section headings, without the version heading. A valid source file should look
like this:

```
### Packaging

- Minimum Rust version has been bumped to 1.46.0

### Added

- Support for `ipfs`/`ipns` URLs
- Mode field for regex hint bindings
```

## Configuration docs generation

The config documentation pages are automatically generated from Alacritty's
`.scd` files, the following will generate configuration information
for 1.2.3 release:

```sh
# Replace `<…>` with the path to your Alacritty directory.
update_config.sh <…>/alacritty/extra/man 1.2.3
```

After the generation the new releases needs to be appended to the
`select_release.js` manually as well as links pointing to the latest release.
