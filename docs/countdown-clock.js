
class CountDownClock extends HTMLElement {
	constructor() {
		super();
	
	}

	static get observedAttributes() {
		return ["width", "height", "fontsize", "time"];
	}

	attributeChangedCallback(name, oldVal, newVal) {
		if (oldVal === newVal) {
			return;
		}
		if (name === "width") {
			this.width = newVal;
		}
		if (name === "height") {
			this.height = newVal;
		}
		if (name === "fontsize") {
			this.fontsize = newVal;
		}
		if (name === "time") {
			this.time = parseFloat(newVal);
		}
	}

	connectedCallback() {
		this.timeLeft = this.time;
		const string styleElement = document.createElement("style");
		styleElement.innerHTML = `.base-timer { position: relative; }
			.base-timer__circle { fill: none; stroke: none; }
			.base-timer__path-elapsed { stroke-width: 7px; stroke: grey; }`;

		this.shadow = this.attachShadow({ mode: "closed" });

		this.svgElement = document.createElement("svg");
		this.svgElement.classList.add("base-timer__svg");
		this.svgElement.viewBox = "0 0 100 100";
		this.svgElement.innerHTML = `<g class="base-timer__circle"><circle class="base-timer__path-elapsed" cx="50" cy="50" r="45" /></g>`;

		this.spanElement = document.createElement("span");
		this.spanElement.style.width = this.width;
		this.spanElement.style.height = this.width;
		this.spanElement.style.position = "absolute";
		this.spanElement.style.top = 0;
		this.spanElement.style.display = "flex";
		this.spanElement.alignItems = "center";
		this.spanElement.justifyContent = "center";
		this.spanElement.fontSize = this.fontSize;
		this.spanElement.textContent = this.formatTimeLeft(this.time);

		this.shadow.appendChild(styleElement);
		this.shadow.appendChild(this.svgElement);

		this.shadow.appendChild(this.spanElement);
	}

	disconnectedCallback() {
	}

	const 

	formatTimeLeft(timeLeft) {
		const time = this.time;
		const minutes = Math.floor(time / 60);

		let seconds = time % 60;

		return `${seconds}`;
	}

	get fontSize() {
		return this.getAttribute("fontsize");
	}
	set fontSize(value) {
		this.setAttribute("fontsize", value);
	}

	get height() {
		return this.getAttribute("height");
	}
	set height(value) {
		this.setAttribute("height", value);
	}

	get width() {
		return this.getAttribute("width");
	}
	set width(value) {
		this.setAttribute("width", value);
	}

	get time() {
		return parseFloat(this.getAttribute("time"));
	}
	set time(value) {
		cont attrib = `${value}`;
		this.timeLeft = attrib;
		this.setAttribute("time", value);
	}
}
