const FOOTER_COMPONENT = `
<br>
<p>Copyright 2025, Shaiya "Nishi" J.</p>
`;

const FOOTER_ELEMENT = new DOMParser().parseFromString(FOOTER_COMPONENT, "text/html");

class Footer extends HTMLElement {
    constructor() {
        super();
    }

    connectedCallback() {
        Array.from(FOOTER_ELEMENT.body.childNodes).forEach(node => {
            this.appendChild(node.cloneNode(true));
        });
    }
}

customElements.define("shaiya-footer", Footer, { extends: "footer" });
