<template>
  <router-view />
</template>

<script>
  export default {
    name: 'App',
    mounted(){
      if(localStorage.getItem("token")) {
        this.$router.replace("/");
      }else{
        this.$router.replace("/login");
      }
    }
  }

  
</script>
<style lang="scss">
@import url('https://fonts.googleapis.com/css2?family=Prompt:wght@100;300&display=swap');
  #app, span, div{
    font-family: 'Prompt', sans-serif;
  }

</style>

