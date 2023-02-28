import Vue from 'vue'
import Vuetify from 'vuetify/lib'
import i18n from '@/i18n'
import '@/sass/overrides.sass'
import '@fortawesome/fontawesome-free/css/all.css'

Vue.use(Vuetify)

const theme = {
    primary: '#629d25',
    secondary: '#9C27b0',
    info: '#629d25',
    white: '#ffffff',
    black: '#000000',
}

export default new Vuetify({
    icons: {
        iconfont: 'fa',
    },
    lang: {
        t: (key, ...params) => i18n.t(key, params),
    },
    theme: {
        themes: {
            dark: theme,
            light: theme,
        },
    },
})