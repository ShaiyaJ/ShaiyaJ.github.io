const POSTLIST_COMPONENT = `
<h1>POSTLIST</h1>
`;

const POSTLIST_ELEMENT = new DOMParser().parseFromString(FOOTER_COMPONENT, "text/html");

class Postlist extends HTMLElement {
    constructor() {
        super();
    }

    connectedCallback() {
        Array.from(POSTLIST_ELEMENT.body.childNodes).forEach(node => {
            this.appendChild(node.cloneNode(true));
        });
    }
}

customElements.define("shaiya-postlist", Postlist, { extends: "div" });
