<template>
    <v-card-title class="box">
        <div class="haderpeng">
            <span>บัญชีธนาคารของฉัน</span><br>
            <span class="subtitle">จัดการบัญชีธนาคารเพื่อเป็นบัญชีในการถอนเงินจากระบบ</span>
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
                เพิ่มบัญชีธนาคาร
                </v-btn>
            </v-col> 
            <v-row class="boxaccountbank">
                <v-col cols="12" md="6" v-for="accountbank in datauser.tbl_useraccountbanks" :key="accountbank.id" >
                    <v-card class="my-5  pa-3 showaccountbank ">
                        <v-col cols="12" md="9">
                            <div class="data">
                                <label for="">ธนาคาร: {{accountbank.namebank}}</label><br>
                                <label for="">ชื่อบัญชี(ภาษาไทย): {{accountbank.nameaccountTH}}</label><br>
                                <label for="">ชื่อบัญชี(ภาษาอังกฤษ): {{accountbank.nameaccountEN}}</label><br>
                                <label for="">เลขบัญชี: {{accountbank.numberaccount}}</label>
                            </div>
                        </v-col>
                        <v-col cols="12" md="3" class="active">
                            <v-icon @click="editItem(accountbank)" color="#FFBB29" >mdi-pencil</v-icon>
                            <v-icon @click="del(accountbank)" color="#FF6347" >mdi-delete</v-icon>
                        </v-col>
                    </v-card>
            </v-col>
            </v-row>
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
                                v-model="isValid"
                                ref="form"
                                @submit.prevent="save"
                            >  
                            <v-row>
                                   
                                <v-col
                                    cols="12"
                                    md="4"
                                >
                                    <v-select
                                        v-model="accountbank.namebank"
                                        :items="namebank"
                                        menu-props="auto"
                                        label="ธนาคาร"
                                        hide-details
                                        single-line
                                        :rules="[(v) => !!v || '']"
                                        required
                                    ></v-select>
                                </v-col>
                                <v-col
                                    cols="12"
                                    md="8"
                                >
                                <v-text-field
                                    v-model="accountbank.numberaccount"
                                    label="เลขบัญชี"
                                    :rules="[(v) => !!v || 'กรุณากรอกข้อมูล']"
                                    required
                                ></v-text-field>
                                </v-col>
                            </v-row>
                            <v-row>
                                <v-col
                                    cols="12"
                                >
                                <v-text-field
                                    v-model="accountbank.nameaccountTH"
                                    label="ชื่อบัญชี(ภาษาไทย)"
                                    :rules="[(v) => !!v || 'กรุณากรอกข้อมูล']"
                                    required
                                ></v-text-field>
                                <v-text-field
                                :rules="[(v) => !!v || 'กรุณากรอกข้อมูล']"
                                    v-model="accountbank.nameaccountEN"
                                    label="ชื่อบัญชี(ภาษาอังกฤษ)"
                                    required
                                ></v-text-field>
                                </v-col>
                            </v-row>
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
      show1: "",
      dialog: false,
      editedIndex: -1,
      password: "Password",
      rules: {
        required: (value) => !!value || "กรุณากรอกข้อมูล",
      },
      accountbank:{
          namebank:'',
          nameaccountTH:'',
          nameaccountEN:'',
          numberaccount:''
      },
      namebank:[
        'กรุงเทพ',
        'กรุงไทย',
        'กรุงศรีอยุธยา',
        'กสิกรไทย',
        'ไทยพาณิชย์',
        'เกียรตินาคินภัทร',
        'ทหารไทย',
        'ซีไอเอ็มบี',
        'ยูโอบี',
        'พร้อมเพย์',
      ],
      listbank:[]
    };
  },
  computed: {
    formTitle () {
        return this.editedIndex === -1 ? 'เพิ่มบัญชีธนาคาร' : 'แก้ไขข้อมูลบัญชีธนาคาร'
    },
  ...mapState(["datauser"]),
  },
  methods: { 
    editItem (accountbank) {
        this.editedIndex = this.datauser.tbl_useraccountbanks.indexOf(accountbank);
        this.accountbank = Object.assign({},accountbank);
        this.dialog = true;   
    },

    close() {
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
                Axios.put(`${process.env.VUE_APP_APIURL}/api/user/accountbank`,this.accountbank,config)
                .then(response => {
                    this.$swal({
                        title: "สำเร็จ",
                        text: "ทำการแก้ไขข้อมูลสำเร็จ",
                        icon: "success"
                    });
                    Object.assign(this.datauser.tbl_useraccountbanks[this.editedIndex], this.accountbank)
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
                Axios.post(`${process.env.VUE_APP_APIURL}/api/user/accountbank`,this.accountbank,config)
                .then(response => {
                    this.$swal({
                        title: "สำเร็จ",
                        text: "ทำการเพิ่มข้อมูลสำเร็จ",
                        icon: "success"
                    });
                    this.datauser.tbl_useraccountbanks.push(response.data.data);
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
      del(accountbank){
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
                Axios.delete(`${process.env.VUE_APP_APIURL}/api/user/accountbank/${accountbank.id}`,config)
                .then(response => {
                    this.$swal({
                        title: "สำเร็จ",
                        text: "ทำการลบข้อมูลสำเร็จ",
                        icon: "success"
                    });
                    const index = this.datauser.tbl_useraccountbanks.indexOf(accountbank) 
                    this.datauser.tbl_useraccountbanks.splice(index, 1)
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
.box{
    margin: 48px;
    background-color: #ffffff;
    border-radius: 5px;
    box-shadow: 0px 3px 1px -2px rgba(0, 0, 0, 0.2),
        0px 2px 2px 0px rgba(0, 0, 0, 0.14), 0px 1px 5px 0px rgba(0, 0, 0, 0.12);
}
.boxaccountbank{
    display: flex;
    justify-content: center;
    border-bottom: 1px solid rgba(0, 0, 0, 0.11);
    
    
        .showaccountbank{
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            margin: auto 10px;

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

      .addbank{
            display: flex;
            justify-content: flex-end;

            button{
                margin: 0px !important;
            }
        }

      .col-12 {
         text-align: left;
         padding: 0px 12px !important;
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