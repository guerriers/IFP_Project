<template>
  <v-app>
    <dashboard-core-app-bar />

    <dashboard-core-drawer />

    <dashboard-core-view />

  </v-app>
</template>

<script>
import Axios from 'axios';
import { mapState, mapMutations } from "vuex";

  export default {
    name: 'DashboardIndex',

    components: {
      DashboardCoreAppBar: () => import('./components/core/AppBar'),
      DashboardCoreDrawer: () => import('./components/core/Drawer'),
      DashboardCoreView: () => import('./components/core/View'),
    },

    data: () => ({
      expandOnHover: false,
    }),
    mounted(){
          const config = {
            headers: {
              Authorization:`Bearer ${localStorage.getItem("token")}`
            }
          };
          Axios.get(`${process.env.VUE_APP_APIURL}/api/user/userone`,config)
          .then((response) => {
            let datauser = response.data.data;
            this.set_datauser(datauser);
          })
    }, 
    computed: {
    ...mapState(["datauser"]),
    },
    methods:{
      ...mapMutations({
        set_datauser:"SET_DATAUSER",
      })
    }
  }
</script>

<style lang="scss">

    body{
      padding: 0 !important;
    }
</style>
