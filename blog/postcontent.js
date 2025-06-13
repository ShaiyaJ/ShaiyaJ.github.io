const POSTCONTENT_COMPONENT = ``;

const POSTCONTENT_ELEMENT = new DOMParser().parseFromString(POSTCONTENT_COMPONENT, "text/html");

class Postcontent extends HTMLElement {
    constructor() {
        super();
    }

    connectedCallback() {
        fetchPostContent().then(() => {
            Array.from(POSTCONTENT_ELEMENT.body.childNodes).forEach(node => {
                this.appendChild(node.cloneNode(true));
            });
        });
    }
}

customElements.define("shaiya-postcontent", Postcontent, { extends: "article" });


async function fetchPostContent() {
    // Parse URL
    const main = document.getElementById("main");
    const loc = window.location.search.substring(1).replaceAll(":", "/");

    // Content
    try {
        await fetch(`https://raw.githubusercontent.com/ShaiyaJ/ShaiyaJ.github.io/refs/heads/master/blog/blogcontent/${loc}`)
            .then(res => {
                return res.text();
            }).then(text => {
                const postraw_element = new DOMParser().parseFromString(text, "text/html");

                Array.from(postraw_element.body.childNodes).forEach(node => {
                    POSTCONTENT_ELEMENT.body.appendChild(node.cloneNode(true));
                });
            });
    } catch (err) {
        console.error("Failed to grab post contents");
        console.error(err);
    }
}
