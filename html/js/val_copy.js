window.addEventListener('message', (event) => {
    if (event.data.action === 'copyToClipboard') {
        copyToClipboard(event.data.value);
    }
});

function copyToClipboard(value) {
    const el = document.createElement('textarea');
    el.value = value;
    el.setAttribute('readonly', '');
    el.style.position = 'absolute';
    el.style.left = '-9999px';
    document.body.appendChild(el);
    el.select();
    document.execCommand('copy');
    document.body.removeChild(el);
}
