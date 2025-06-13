const POSTCONTENT_COMPONENT = `
<h1>CONTENT</h1>
`;

const POSTCONTENT_ELEMENT = new DOMParser().parseFromString(FOOTER_COMPONENT, "text/html");

class Postcontent extends HTMLElement {
    constructor() {
        super();
    }

    connectedCallback() {
        Array.from(POSTCONTENT_ELEMENT.body.childNodes).forEach(node => {
            this.appendChild(node.cloneNode(true));
        });
    }
}

customElements.define("shaiya-postcontent", Postcontent, { extends: "div" });
