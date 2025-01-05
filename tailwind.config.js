module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require('daisyui')
  ],
  daisyui: {
    themes: [
      "light"
    ],
  },
  theme: {
    extend: {
      colors: {
        theme: "#E07900",
        point: "#FFE8AC"
      },
      width: {
        '96': '24rem'
      }
    }
  }
}
