import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)


export default new Vuex.Store({
    state: {
        drawer: null,
        datauser: null,
        serial: null,
        datasensorme: null
    },
    getters: {
        getdatauser(state) {
            return state.datauser
        }
    },

    mutations: {
        SET_DRAWER(state, payload) {
            state.drawer = payload
        },
        SET_DATAUSER(state, payload) {
            state.datauser = payload
        },
        SET_DATASENSOR(state, payload) {
            state.datasensorme = payload
        },
        SET_SERIAL(state, payload) {
            state.serial = payload
        },
    },
    actions: {

    },
})