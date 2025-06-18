const POSTLIST_COMPONENT = ``;

const POSTLIST_ELEMENT = new DOMParser().parseFromString(POSTLIST_COMPONENT, "text/html");

class Postlist extends HTMLElement {
    constructor() {
        super();
    }

    connectedCallback() {
        fetchPosts().then( () => {
            Array.from(POSTLIST_ELEMENT.body.childNodes).forEach(node => {
                this.appendChild(node.cloneNode(true));
            });
        });
    }
}

customElements.define("shaiya-postlist", Postlist, { extends: "nav" });





async function fetchPosts(path = "blog/blogcontent", parentElement = POSTLIST_ELEMENT.body) {
    const API_URL = `https://api.github.com/repos/ShaiyaJ/ShaiyaJ.github.io/contents/${path}`;

    try {
        const response = await fetch(API_URL);
        if (!response.ok) {
            console.error(`Failed to fetch ${path}: ${response.status}`);
            return;
        }

        const items = await response.json();

        for (const item of items) {
            if (item.type === "file") {
                const link = document.createElement("a");

                // URL info
                const path = item.path
                    .split("/").slice(2)
                    .join(":");

                link.href = `./?${path}`;

                // Styling
                link.textContent = item.name;
                link.style.display = "block";
                link.classList.add("padded-dir");

                // HTMX
                link.setAttribute("hx-trigger", "click");
                link.setAttribute("hx-get", `./blogcontent/${path}`);
                link.setAttribute("hx-target", "#main");
                link.setAttribute("hx-push-url", "true");

                // Append
                parentElement.appendChild(link);

            } else if (item.type === "dir") {
                const details = document.createElement("details");
                details.classList.add("padded-dir");

                const summary = document.createElement("summary");
                summary.textContent = item.name;

                details.appendChild(summary);

                parentElement.appendChild(details);

                // Recurse into subdirectory
                await fetchPosts(item.path, details);
            } else {
                console.error(`Unknown item type: ${item.name}`);
            }
        }

    } catch (err) {
        console.error(`Error loading path ${path}:`, err);
    }
}

// TODO: perhaps have this view be a "organised" one, then have another be a "chronological" one
