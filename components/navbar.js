const NAV_COMPONENT = `
<a href="/">Home</a>
<a href="/notes">Notes</a>
<a href="/portfolio">Portfolio</a>
<a href="/contact">Contact</a>
<a href="https://github.com/ShaiyaJ">Github</a>
`;
const NAV_ELEMENT = new DOMParser().parseFromString(NAV_COMPONENT, "text/html");

class Navbar extends HTMLElement {
    constructor() {
        super();
    }

    connectedCallback() {
        Array.from(NAV_ELEMENT.body.childNodes).forEach(node => {
            this.appendChild(node.cloneNode(true));
        });
    }
}

customElements.define("shaiya-navbar", Navbar, { extends: "nav" });
