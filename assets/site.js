(function () {
  const toast = document.querySelector(".toast");

  function showToast(message) {
    if (!toast) return;
    toast.textContent = message;
    toast.hidden = false;
    window.clearTimeout(showToast.timer);
    showToast.timer = window.setTimeout(function () {
      toast.hidden = true;
    }, 1700);
  }

  async function copyText(text) {
    if (navigator.clipboard && window.isSecureContext) {
      await navigator.clipboard.writeText(text);
      return;
    }

    const textarea = document.createElement("textarea");
    textarea.value = text;
    textarea.setAttribute("readonly", "");
    textarea.style.position = "fixed";
    textarea.style.left = "-9999px";
    document.body.appendChild(textarea);
    textarea.select();
    document.execCommand("copy");
    document.body.removeChild(textarea);
  }

  document.addEventListener("click", async function (event) {
    const button = event.target.closest("[data-copy]");
    if (!button) return;

    const id = button.getAttribute("data-copy");
    const source = document.getElementById(id);

    if (!source) {
      showToast("Copy source not found");
      return;
    }

    try {
      await copyText(source.innerText);
      const old = button.textContent;
      button.textContent = "Copied";
      showToast("Copied to clipboard");
      window.setTimeout(function () {
        button.textContent = old;
      }, 1400);
    } catch (error) {
      showToast("Copy failed");
    }
  });
})();
