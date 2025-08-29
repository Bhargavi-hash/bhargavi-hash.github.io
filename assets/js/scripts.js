document.addEventListener("DOMContentLoaded", () => {
  const toggleButton = document.getElementById('mode-toggle');
  const body = document.body;

  // 1. Load saved theme or default to dark
  const savedTheme = localStorage.getItem('theme');
  if (savedTheme === 'dark' || !savedTheme) {
    body.classList.add('dark');
    toggleButton.textContent = '☀️';
    localStorage.setItem('theme', 'dark'); // ensure persistence
  } else {
    body.classList.remove('dark');
    toggleButton.textContent = '🌙';
  }

  // 2. Toggle theme on button click
  toggleButton.addEventListener('click', () => {
    body.classList.toggle('dark');

    if (body.classList.contains('dark')) {
      toggleButton.textContent = '☀️';
      localStorage.setItem('theme', 'dark');
    } else {
      toggleButton.textContent = '🌙';
      localStorage.setItem('theme', 'light');
    }
  });
});
