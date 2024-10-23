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

To ensure consistent formatting, all codeblocks (`` ` ``) should also be
replaced by `<code>…</code>` or `<kbd>…</kbd>` depending on their content.

## Configuration docs generation

The config documentation pages are automatically generated from Alacritty's
`.scd` files, the following will generate configuration information
for 1.2.3 release:

```sh
# Replace `<…>` with the path to your Alacritty directory.
update_config.sh <…>/alacritty/extra/man 1.2.3
```

To add the HTML anchors to each generated manpage you then have to open every
generated file in your browser, execute `add_anchors.js` in your browsec
console, and replace the contents of the `main` tag in the output HTML file with
the output logged when executing the script.

To ensure all other pages point to the latest version correctly, you also need
to update the symlinks in the `static` directory:

```sh
ln -sf releases/1.2.3/cmd-alacritty.html static/
ln -sf releases/1.2.3/cmd-alacritty-msg.html static/
ln -sf releases/1.2.3/config-alacritty.html static/
ln -sf releases/1.2.3/config-alacritty-bindings.html static/
```
