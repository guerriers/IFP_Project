<template>
  <v-container>
    <v-row justify="center">
      <v-col cols="12" md="8">
        <base-material-card
          color="info"
          title="แก้ไขข้อมูลส่วนตัว"
          icon="mdi mdi-account-edit"
        >
          <router-view/>
        </base-material-card>
      </v-col>

      <v-col cols="12" md="4">
        <v-card class="v-card-profile">
          <div class="img">
            <img
            :src="`http://maims.cmtc.ac.th:3000/profile/${datauser.tbl_userdetail.img}`"
            >
            <!-- <input type="file" >
            <v-btn
              small
              @click="onButtonClick()"
              :loading="show1"
            >
              เปลี่ยนรูป
            </v-btn> -->
          </div>
          <v-card-text>
            <h4
              class="display-2 font-weight-light mb-3 black--text text-center"
            >
              {{datauser.tbl_userdetail.name}}
            </h4>
            <p class="my-5">
            รายละเอียดร้าน<br>
            {{datauser.tbl_userdetail.detail}}
            </p>
          </v-card-text>
        </v-card>
        <div class="serial">
          <div class="addserial">
            <!-- <v-card class="my-5  pa-3 d-flex justify-center">
              <v-col
              cols="12"
              class="d-flex  justify-md-space-between align-center"
              >
                <v-col 
                  cols="12"
                  md="8"
                >
                <v-text-field
                label="Add Serial"
                single-line
              ></v-text-field>
                </v-col>
                  <vs-button color="success" type="filled">Success</vs-button>
              </v-col>
            </v-card> -->
          </div>
          <div class="showserial" v-for="serial in datauser.tbl_userserials" :key="serial.id" >
            <v-card class="my-5  pa-3 ">
               <label for="">ชื่อ: {{serial.name}}</label><br>
               <label for="">รห้สเครื่อง: {{serial.serial}}</label>
            </v-card>
          </div>
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapState, mapMutations } from "vuex";
import Axios from 'axios';

export default {
  data() {
    return {
      show1: false,
      selectedFile:null,
      password: "Password",
      search:"ifp_2020",
      rules: {
        required: (value) => !!value || "Required.",
        min: (v) => v.length >= 8 || "Min 8 characters",
        emailMatch: () => `The email and password you entered don't match`,
      },
    };
  },
  computed: {
  ...mapState(["datauser"]),
  },
  methods: {
      onButtonClick() {
      this.show1 = true
      window.addEventListener('focus', () => {
        this.show = false
      }, { once: true })

      this.$refs.uploader.click()
    },
    onFileChanged(e) {
      this.selectedFile = e.target.files[0]
    }
  },
};
</script>
<style lang="scss" scoped>
.container {
  padding-left: 50px !important;
  padding-right: 50px !important;

  .v-card-profile{

    .img{
      display: flex;
      flex-direction: column;
      justify-content: center;
      button{
        margin: auto !important;
        width: 20%;
        text-align: center;
      }
      img{
        object-fit: cover;
        height: 100px;
        width: 100px;
        border-radius: 100%;
        margin: 20px auto;
      }
    }
  }

}

.addserial{
  .v-card{
    align-items: center;
    height: 50px;

    .vs-button{
      width: 100%;
    }

    .col-xl, .col-xl-auto, .col-xl-12, .col-xl-11, .col-xl-10, .col-xl-9, .col-xl-8, .col-xl-7, .col-xl-6, .col-xl-5, .col-xl-4, .col-xl-3, .col-xl-2, .col-xl-1, .col-lg, .col-lg-auto, .col-lg-12, .col-lg-11, .col-lg-10, .col-lg-9, .col-lg-8, .col-lg-7, .col-lg-6, .col-lg-5, .col-lg-4, .col-lg-3, .col-lg-2, .col-lg-1, .col-md, .col-md-auto, .col-md-12, .col-md-11, .col-md-10, .col-md-9, .col-md-8, .col-md-7, .col-md-6, .col-md-5, .col-md-4, .col-md-3, .col-md-2, .col-md-1, .col-sm, .col-sm-auto, .col-sm-12, .col-sm-11, .col-sm-10, .col-sm-9, .col-sm-8, .col-sm-7, .col-sm-6, .col-sm-5, .col-sm-4, .col-sm-3, .col-sm-2, .col-sm-1, .col, .col-auto, .col-12, .col-11, .col-10, .col-9, .col-8, .col-7, .col-6, .col-5, .col-4, .col-3, .col-2, .col-1{
      padding: 0px 10px !important;
    }

    input{
      font-size: 18px;
    }
  }
}
</style>
