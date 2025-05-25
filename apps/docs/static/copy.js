// This script enables copy-to-clipboard for the install command
// and provides feedback by changing the icon color temporarily.

window.addEventListener('DOMContentLoaded', () => {
  const copyBtn = document.getElementById('copy-install');
  const code = document.getElementById('install-script');
  if (!copyBtn || !code) return;
  copyBtn.addEventListener('click', () => {
    navigator.clipboard.writeText(code.textContent.trim());
    copyBtn.classList.add('text-green-500');
    setTimeout(() => copyBtn.classList.remove('text-green-500'), 1000);
  });
});
