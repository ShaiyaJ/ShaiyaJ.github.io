class Postlist extends HTMLElement {
    constructor() {
        super();
    }

    connectedCallback() {
        populatePosts("", this);
    }
}

customElements.define("shaiya-postlist", Postlist, { extends: "nav" });



async function populatePosts(path = "", parentElement = null) {
    if (parentElement === null)
        parentElement = document.createElement("div");

    await fetch(`https://api.github.com/repos/ShaiyaJ/ShaiyaJ.github.io/contents/notes/content/${path}`)
        .then(res => {
            return res.json();
        }).then(items => {
            for (const item of items) {
                if (item.type === "file") {
                    const link = document.createElement("a");

                    // URL info
                    const path = item.path
                        .split("/").slice(2)
                        .join(":");

                    link.href = "#";
                    
                    link.onclick = (e) => {
                        history.pushState({}, "", `?${path}`);
                        window.dispatchEvent(new Event("pushstate"));
                        e.preventDefault();
                    };

                    // Styling
                    link.textContent = item.name;
                    link.style.display = "block";
                    link.classList.add("padded-dir");

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
                    return populatePosts(item.path, details);
                }
            }
        });
}

// TODO: perhaps have this view be a "organised" one, then have another be a "chronological" one
