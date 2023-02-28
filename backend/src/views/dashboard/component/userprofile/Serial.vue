<template>
    <v-card-title>
        <div class="haderpeng">
            <span>รห้สซีเรียล</span><br>
            <span class="subtitle">จัดการรห้สซีเรียลเพื่อไม่ให้สบสนในการจำรห้สซีเรียล</span>
        </div>
        <v-row class="edit">
            <v-col
            cols="12"
            class="addbank"
            >
                <v-btn
                medium
                color="primary"
                @click="dialog = true"
                >
                <v-icon
                    size="18px"
                    color="#ffffff"
                >
                    mdi-plus
                </v-icon>
                เพิ่มรห้สซีเรียล
                </v-btn>
            </v-col>
            <div class="haderpeng" v-for="serial in datauser.tbl_userserials" :key="serial.id" >
            <v-card class="my-5  pa-3 showserial ">
                <v-col cols="12" md="9">
                    <div class="data">
                        <label for="">ชื่อ: {{serial.name}}</label><br>
                        <label for="">รห้สเครื่อง: {{serial.serial}}</label>
                    </div>
                </v-col>
                <v-col cols="12" md="3" class="active">
                    <v-icon @click="editItem(serial)" color="#FFBB29" >mdi-pencil</v-icon>
                    <v-icon @click="del(serial)" color="#FF6347" >mdi-delete</v-icon>
                </v-col>
            </v-card>
          </div>
            <v-dialog
                v-model="dialog"
                max-width="450"
            >
            <v-card>
                <div class="add">
                    <v-card-title class="headline">
                        <span>{{ formTitle }}</span>
                    </v-card-title>
                    <v-card-text>
                            <v-container>
                            <v-form
                                ref="form"
                                @submit.prevent="save"
                            >       
                                <v-text-field
                                    v-model="serial.name"
                                    label="ชื่่อเครื่่อง"
                                    :rules="[rules.name]"
                                    required
                                    prepend-icon="mdi-tree"
                                ></v-text-field>
                                <v-text-field
                                    v-model="serial.serial"
                                    label="รห้สซีเรียล"
                                    type="text"
                                    :rules="[rules.serial]"
                                    required
                                    prepend-icon="mdi-cash"
                                    :disabled="this.editedIndex > -1 ? true : false "
                                ></v-text-field>
                                    <v-col
                                        cols="12"
                                        align="center"
                                    >
                                    <v-btn
                                        depressed
                                        color="success"
                                        type="submit"
                                    >
                                        บันทึกข้อมูล
                                    </v-btn>

                                    <v-btn
                                        depressed
                                        color="error"
                                        @click="close"
                                    >
                                        ย้อนกลับ
                                    </v-btn>
                                    </v-col>
                            </v-form>
                            </v-container>
                    </v-card-text>
                </div>
            </v-card>
            </v-dialog>
        </v-row>
        </v-card-title>
</template>
<script>
import Axios from 'axios'
import { mapState, mapMutations } from "vuex";
export default {
name:'Backaccount',
  data() {
    return {
      dialog: false,
      editedIndex: -1,
      password: "Password",
      serial:{
          name:'',
          serial:''
      },
      rules: {
          name: v => !!v || 'กรุณาใส่ชื่อเครื่่อง',
          serial: v => !!v || 'กรุณาใส่รห้สซีเรียล'
      },
    };
  },
  computed: {
  ...mapState(["datauser"]),
    formTitle () {
        return this.editedIndex === -1 ? 'เพิ่มรห้สซีเรียล' : 'แก้ไขข้อมูลซีเรียล'
    },
  },
  methods: {
      editItem (serial) {
        this.editedIndex = this.datauser.tbl_userserials.indexOf(serial);
        this.serial = Object.assign({},serial);
        this.dialog = true;   
      },

      close () {
        this.$nextTick(() => {
            this.editedIndex = -1
            this.dialog = false
            this.$refs.form.reset()
          
        })
      },

      save(){
        const config = {
        headers: {
                Authorization:`Bearer ${localStorage.getItem("token")}`,
            }
        };
          if(this.$refs.form.validate()){
              if(this.editedIndex > -1){
                Axios.put(`${process.env.VUE_APP_APIURL}/api/user/serial`,this.serial,config)
                .then(response => {
                    this.$swal({
                        title: "สำเร็จ",
                        text: "ทำการแก้ไขข้อมูลสำเร็จ",
                        icon: "success"
                    });
                    Object.assign(this.datauser.tbl_userserials[this.editedIndex], this.serial)
                    this.close()
                })
                .catch(err => {
                    this.$swal({
                        title: "ไม่สำเร็จ",
                        text: "ทำการแก้ไขข้อมูลไม่สำเร็จ",
                        icon: "error",
                    })
                })
              }else{
                Axios.post(`${process.env.VUE_APP_APIURL}/api/user/serial`,this.serial,config)
                .then(response => {
                    this.$swal({
                        title: "สำเร็จ",
                        text: "ทำการเพิ่มข้อมูลสำเร็จ",
                        icon: "success"
                    });
                    this.datauser.tbl_userserials.push(response.data.data);
                    this.close()
                }).catch(err => {
                    this.$swal({
                        title: "ไม่สำเร็จ",
                        text: err.response.data.message,
                        icon: "error",
                    })
                })
              }
          }
      },
      del(serial){
        const config = {
          headers: {
            Authorization:`Bearer ${localStorage.getItem("token")}`
          }
        };
        this.$swal({
          title: 'ต้องการลบข้อมูล',
          text: "คุณต้องการลบข้อมูลหรือไม่",
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'ยืนยัน',
          cancelButtonText: 'ยกเลิก'
          })
          .then((result) => {
              if (result.value) {
                  console.log(serial.id); 
                Axios.delete(`${process.env.VUE_APP_APIURL}/api/user/serial/${serial.id}`,config)
                .then(response => {
                    this.$swal({
                        title: "สำเร็จ",
                        text: "ทำการลบข้อมูลสำเร็จ",
                        icon: "success"
                    });
                    const index = this.datauser.tbl_userserials.indexOf(serial) 
                    this.datauser.tbl_userserials.splice(index, 1)
                }).catch(err => {
                    this.$swal({
                        title: "ไม่สำเร็จ",
                        text: err.response.data.message,
                        icon: "error",
                    })
                })
              }     
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
        .showserial{
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;

            .active{
                display: flex;
                align-content: center;
                justify-content: center;

                button{
                    margin-left: 30px;
                    font-size: 22px;
                    opacity: 0.8;
                }
                button:hover{
                    opacity: 1;
                    margin-left: 30px;
                    font-size: 22px;
                }
            }
        }
    }

    .edit{
      margin: 20px auto;
      font-size: 14px;

      .addbank{
            display: flex;
            justify-content: flex-end;

            button{
                margin: 0px !important;
            }
        }

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
      padding: 0px !important;
        }
    }

</style>