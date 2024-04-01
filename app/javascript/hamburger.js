document.addEventListener('turbo:load', () => {
  const button = document.getElementById('button');
  const bars = document.getElementById('bars');
  const xmark = document.getElementById('xmark');
  const menu = document.getElementById('menu');

  button.addEventListener('click', event => {
    bars.classList.toggle('hidden');
    xmark.classList.toggle('hidden');
    menu.classList.toggle('translate-x-full');
  });
});