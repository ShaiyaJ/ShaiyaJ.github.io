const POSTCONTENT_COMPONENT = ``;

class Postcontent extends HTMLElement {
    constructor() {
        super();
    }
    
    loadPost() {
        fetchPostContent().then(raw => {
            this.textContent = "";
            
            if (raw === undefined) {
                raw = "";
            }
            
            let POST_DOM = new DOMParser().parseFromString(raw, "text/html");
            
            Array.from(POST_DOM.body.childNodes).forEach(node => {
                console.log(this);  
                this.appendChild(node.cloneNode(true));
            });
        });    
    }

    connectedCallback() {
        this.loadPost();
        window.addEventListener("popstate", () => this.loadPost());
        window.addEventListener("pushstate", () => this.loadPost());
    }
}

customElements.define("shaiya-postcontent", Postcontent, { extends: "article" });


async function fetchPostContent() {
    // Parse URL
    const main = document.getElementById("main");
    const loc = window.location.search.substring(1).replaceAll(":", "/");

    if (loc === "")
        return;

    // Content
    return await fetch(`https://raw.githubusercontent.com/ShaiyaJ/ShaiyaJ.github.io/refs/heads/master/notes/content/${loc}`)
        .then(res => {
            return res.text();
        }).then(textres => {
            return textres;
        });
}
