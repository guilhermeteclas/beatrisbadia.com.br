/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{html,js}"],
  theme: {
    fontFamily: {
      sans: ['Lato', 'sans-serif'],
    },
    extend: {
      fontFamily: {
        lora: 'Lora, ui-serif',
        lato: 'Lato, ui-serif',
      },
      colors: {
        'lilac': '#846b8f',
        'body': '#54524d',
      },
      backgroundImage: {
        'butterfly': "url('../images/butterfly.jpeg')",
        'butterfly-square': "url('../images/butterfly-square.png')",
        'flowers': "url('../images/flowers.jpg')",
      }
    },
  },
  plugins: [require('tailwind-hamburgers')],
}

