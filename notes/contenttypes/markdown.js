class Markdown extends HTMLElement {
    constructor() {
        super();
    }

    connectedCallback() {
        // Fix for innerHTML found at https://stackoverflow.com/questions/53806938/how-to-access-content-text-in-html-custom-element
        setTimeout( () => {
            const parsed = parseMarkdownContent(this.innerHTML)
            this.innerHTML = "";

            parsed.forEach(node => {;
                this.appendChild(node.cloneNode(true));
            });
        });
    }
}

customElements.define("shaiya-markdown", Markdown, { extends: "section" });


function parseMarkdownContent(text) {
    console.log(text);
    let cols = 0;           // Resets every \n

    let nodeList = [];
    let currentString = ""; // Used to store single chars for markdown elements that take multiple chars (e.g. <h2> element "##")

    for (let i = 0; i <= text.length; i++) {
        const chr = text.charAt(i);

        // If you are at the beginning of a new line, search for a new opening tag
        if (cols === 0) {

            // These "new line" markdown element are closed with a space (e.g. "# Title")
            // The check for new line catches the case in which there is a single <p> with 1 word in it.
            if (chr === ' ' || chr === '\n' || i === text.length) {

                // Match against current string
                switch (currentString) {
                    case "":                // Special case for trailing spaces and newlines (when embedding in innerHTML)
                        currentString = "";
                        break;

                    case '#':
                        nodeList.push(document.createElement("h1"));
                        break;

                    case '##':
                        nodeList.push(document.createElement("h2"));
                        break;

                    case '###':
                        nodeList.push(document.createElement("h3"));
                        break;

                    default:
                        nodeList.push(document.createElement("p"));
                        nodeList[nodeList.length-1].innerText = currentString + ' ';    // Preserve content
                        break;
                }

                // Update cols
                cols = currentString.length;

                // Clear current string after matching
                currentString = "";

            } else {

                // If the element isn't being closed, append to currentString
                currentString += chr;

            }

        } else {

            // Otherwise, if you aren't at the beginning of a new line, add to last element in nodelist
            nodeList[nodeList.length-1].innerText += chr;
            cols += 1;

        }

        // Set cols to 0 if it is a new line
        if (chr === '\n') 
            cols = 0;
    }

    return nodeList;
}
