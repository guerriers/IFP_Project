<template>
    <v-card-title>
        <div class="haderpeng">
            <span>ข้อมูลของฉัน</span><br>
            <span class="subtitle">จัดการข้อมูลส่วนตัวคุณเพื่อความปลอดภัยของบัญชีผู้ใช้นี้</span>
        </div>
        <v-row class="edit">
            <v-col md="3" cols="12 haderlist">
                <label for="">ชื่อผู้ช้งาน</label>
            </v-col>
            <v-col md="8" cols="12">
                <label for="">{{datauser.userName}}</label>
            </v-col>
            <v-col md="3" cols="12 haderlist">
                <label for="">ชื่อร้านค้า</label>
            </v-col>
            <v-col md="8" cols="12">
                <v-text-field
                v-model="datauser.tbl_userdetail.name"
                ></v-text-field>
            </v-col>
            <v-col md="3" cols="12 haderlist">
                <label for="">อีเมล์</label>
            </v-col>
            <v-col md="8" cols="12">
                <label for="">{{datauser.tbl_userdetail.email}}</label>
            </v-col>
            <v-col md="3" cols="12 haderlist">
                <label for="">ที่อยู่</label>
            </v-col>
            <v-col md="8" cols="12">
                <v-textarea
                auto-grow
                rows="1"
                v-model="datauser.tbl_userdetail.address"
                ></v-textarea>
            </v-col>
            <v-col md="3" cols="12 haderlist">
                <label for="">รายละเอียดร้าน</label>
            </v-col>
            <v-col md="8" cols="12">
                <v-textarea
                auto-grow
                rows="1"
                v-model="datauser.tbl_userdetail.detail"
                ></v-textarea>
            </v-col>

            <v-col cols="12" class="text-right">
            <v-btn
                color="rgb(255, 187, 41)"
                class="mr-0"
                @click="save()"
            >
                บันทึก
            </v-btn>
            </v-col>
        </v-row>
        </v-card-title>
</template>
<script>
import Axios from 'axios'
import { mapState, mapMutations } from "vuex";
export default {
name:'Peofile',
  data() {
    return {
      show1: "",
      update: false,
      profile:{
          name: "ceoball0"
      },
      password: "Password",
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
    save(){
        const config = {
            headers: {
                Authorization:`Bearer ${localStorage.getItem("token")}`
            }
        };
        Axios.put(`${process.env.VUE_APP_APIURL}/api/user/profile`,this.datauser.tbl_userdetail,config)
        .then(response => {
             this.$swal({
                title: "สำเร็จ",
                text: "ทำการแก้ไขข้อมูลสำเร็จ",
                icon: "success"
            });
        })
    }
  },
};
</script>
<style lang="scss" scoped>
    .haderpeng{
      padding: 15px;
      border-bottom: 1px solid rgba(0, 0, 0, 0.11);
      width: 100%;

        .subtitle{
          font-size: 1rem;
        }
    }

    .edit{
      margin: 20px auto;
      font-size: 14px;

      .col-12 {
         text-align: left;
      } 

      .col-md-3{
        text-align: right;
      }
      .haderlist{
        color: #868686;
        font-size: 14px;
      }

      .v-input{
        height: 100%;
        font-size: 14px;
      }

      .v-text-field {
        padding: 0;
        margin: 0;
      }

    .col-xl, .col-xl-auto, .col-xl-12, .col-xl-11, .col-xl-10, .col-xl-9, .col-xl-8, .col-xl-7, .col-xl-6, .col-xl-5, .col-xl-4, .col-xl-3, .col-xl-2, .col-xl-1, .col-lg, .col-lg-auto, .col-lg-12, .col-lg-11, .col-lg-10, .col-lg-9, .col-lg-8, .col-lg-7, .col-lg-6, .col-lg-5, .col-lg-4, .col-lg-3, .col-lg-2, .col-lg-1, .col-md, .col-md-auto, .col-md-12, .col-md-11, .col-md-10, .col-md-9, .col-md-8, .col-md-7, .col-md-6, .col-md-5, .col-md-4, .col-md-3, .col-md-2, .col-md-1, .col-sm, .col-sm-auto, .col-sm-12, .col-sm-11, .col-sm-10, .col-sm-9, .col-sm-8, .col-sm-7, .col-sm-6, .col-sm-5, .col-sm-4, .col-sm-3, .col-sm-2, .col-sm-1, .col, .col-auto, .col-12, .col-11, .col-10, .col-9, .col-8, .col-7, .col-6, .col-5, .col-4, .col-3, .col-2, .col-1{
      padding: 5px 10px !important;
        }
    }

</style>