// Utility script to manually add anchors to important HTML tags.

// Add ID tag for each heading.
var headings = document.getElementsByTagName("h1");
for (const heading of headings) {
  const headingId = heading.innerHTML.toLowerCase().replace(" ", "-");
  heading.setAttribute("id", headingId);
  heading.innerHTML = "<a href=\"#" + headingId + "\">" + heading.innerHTML + "</a>";
}

// Add ID tag for each "highlighted" item.
var strongItems = document.querySelectorAll("main > p > strong");
var strongItemIndex = 0;
for (const strongItem of strongItems) {
  // Ignore items with children, like existing links.
  if (strongItem.children.length > 0) {
    continue;
  }

  const strongItemId = "s" + strongItemIndex;
  strongItem.setAttribute("id", strongItemId);
  strongItem.innerHTML = "<a href=\"#" + strongItemId + "\">" + strongItem.innerHTML + "</a>";
  strongItemIndex += 1;
}

// Output the content of the `<main>` tag for copying.
console.log(document.querySelector("main").innerHTML);
