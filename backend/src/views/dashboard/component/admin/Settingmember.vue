<template>
  <v-container>
    <v-col cols="12">
      <base-material-card
        color="info"
        icon="mdi-card-account-details"
        title="ระบบจัดการสมาชิก"
      >
        <!-- <formuser /> -->
        <v-card-title>
          <v-row align="center">
            <v-col cols="12" lg="4" md="4">
              <v-text-field
                v-model="search"
                append-icon="mdi-magnify"
                label="Search"
                sort-by="calories"
                color="info"
              ></v-text-field>
            </v-col>
            <v-spacer></v-spacer>
            <v-col cols="12" lg="2" md="2">
              <v-dialog v-model="dialog" max-width="500px">
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    depressed
                    color="info"
                    width="100%"
                    class="rounded-pill"
                    v-bind="attrs"
                    v-on="on"
                  >
                    <v-icon>
                      mdi-plus
                    </v-icon>
                    <v-text class="ml-2 display-1">
                      เพิ่มสมาชิก
                    </v-text>
                  </v-btn>
                </template>
                <v-card>
                  <v-card-title class="headline">
                    <span>{{ formTitle }}</span>
                  </v-card-title>
                  <v-card-text>
                    <v-container>
                      <v-form
                        ref="form"
                        v-model="isValid"
                        @submit.prevent="onsubmit"
                      >
                        <v-text-field
                          v-model="editedItem.serial_number"
                          label="รห้สซีเรียล"
                          :disabled="editedIndex != -1"
                          required
                          prepend-icon="mdi-key"
                        ></v-text-field>

                        <v-text-field
                          v-model="editedItem.userName"
                          label="Username"
                          :rules="[v => !!v || 'กรุณาใส่ชื่อผู้ใช้']"
                          required
                          prepend-icon="mdi-pencil"
                        ></v-text-field>

                        <v-text-field
                          v-model="editedItem.password"
                          label="Password"
                          :rules="passwordRules"
                          maxlength="10"
                          :counter="10"
                          required
                          prepend-icon="mdi-account-key"
                        ></v-text-field>

                        <v-text-field
                          v-model="editedItem.email"
                          type="email"
                          label="Email"
                          :rules="rulesemail"
                          required
                          prepend-icon="mdi-email"
                        ></v-text-field>

                        <v-select
                          v-model="editedItem.status_level"
                          :items="itemsstatus"
                          :rules="[v => !!v || 'กรุณาเลือกสถานะ']"
                          label="สถานะ"
                          required
                          prepend-icon="mdi-text-account"
                        ></v-select>

                        <v-checkbox
                          v-model="checkbox"
                          :label="[`ยืนยันการ${formTitle}`]"
                          :rules="[v => !!v || `กรุณากดยืนยันการ${formTitle}`]"
                        ></v-checkbox>
                        <v-container>
                          <v-col cols="12" align="center">
                            <v-btn
                              depressed
                              color="success"
                              class="mr-4 rounded-pill"
                              type="submit"
                            >
                              บันทึกข้อมูล
                            </v-btn>

                            <v-btn
                              depressed
                              color="error"
                              class="mr-4 rounded-pill"
                              @click="close"
                            >
                              ยกเลิก 
                            </v-btn>
                          </v-col>
                        </v-container>
                      </v-form>
                    </v-container>
                  </v-card-text>
                </v-card>
              </v-dialog>
            </v-col>
          </v-row>
        </v-card-title>
        <v-card-text>
          <v-data-table
            :headers="headers"
            :items="listusers"
            :search="search"
            :loading="loading"
            loader-height="2px"
            loading-text="Loading... Please wait"
            color="info"
          >
            <template v-slot:item.edit="{ item }">
              <v-icon
                small
                clas
                s="mr-2"
                color="#FFBB29"
                @click="editItem(item)"
              >
                mdi-pencil
              </v-icon>
            </template>
            <template v-slot:item.del="{ item }">
              <v-icon small @click="del(item)" color="#FF6347">
                mdi-delete
              </v-icon>
            </template>
          </v-data-table>
        </v-card-text>
      </base-material-card>
    </v-col>
  </v-container>
</template>

<script>
import Axios from "axios";

export default {
  name: "Settingmenber",
  data() {
    return {
      search: "",
      dialog: false,
      loading: true,
      isValid: {},
      passwordRules: [
        v => !!v || "กรุณากรอกรห้สผ่าน",
        v => (v && v.length == 10) || "กรุณากรอกรห้สผ่านให้ครบ 10 ตัว"
      ],
      rulesemail:[
        v => !!v || "กรุณากรอกอีเมล์",
        v => !v || /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/.test(v) || 'กรุณาใส่อีเมล์ให้ถูกต้อง'
      ],
      itemsstatus: ["Admin", "members"],
      editedIndex: -1,
      editedItem: {
        userName: "",
        password: "",
        email: "",
        status_level: "",
        serial_number:"",
        checkbox: false
      },
      defaultItem: {
        username: "",
        password: "",
        email: "",
        statususer: ""
      },
      headers: [
        // { text: "ลำดับ", value: "index", width: "6% ",sortable: false,  align: "center" },
        { text: "รห้ส", value: "id", width: "10% ", sortable: false, align: "center" },
        { text: "ชื่อผู้ใช้", value: "userName" },
        // { text: "รห้ส", value: "password" },
        { text: "อีเมล์", value: "tbl_userdetail.email" },
        { text: "ที่อยู่", value: "tbl_userdetail.address" },
        { text: "หมายเหตุ", value: "tbl_userdetail.detail" },
        {
          text: "สถานะ",
          align: "center",
          sortable: false,
          value: "tbl_userdetail.status_level",
          width: "15%"
        },
        {
          text: "แก้ไข",
          align: "center",
          sortable: false,
          value: "edit",
          width: "5%"
        },
        {
          text: "ลบ",
          align: "center",
          sortable: false,
          value: "del",
          width: "5%"
        }
      ],
      listusers: []
    };
  },
  computed: {
    formTitle() {
      return this.editedIndex === -1 ? "เพิ่มสมาชิก" : "แก้ไขข้อมูล";
    }
  },
  created() {
      const config = {
      headers: {
        Authorization:`Bearer ${localStorage.getItem("token")}`
      }
    };
    Axios.get(`${process.env.VUE_APP_APIURL}/api/user`,config)
      .then(response => {
        this.listusers = response.data.data;
        this.loading = false;
      })
      .catch(err => {
        console.log(err);
      });
  },
  methods: {

    del(item) {
      const config = {
        headers: {
          Authorization:`Bearer ${localStorage.getItem("token")}`
        }
      };
      this.$swal({
        title: "ต้องการลบข้อมูล",
        text: "คุณต้องการลบข้อมูลหรือไม",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "ยืนยัน",
        cancelButtonText: "ยกเลิก"
      }).then(result => {
        if (result.value) {
          Axios.delete(
            `${process.env.VUE_APP_APIURL}/api/user/${item.id}`,config)
            .then(response => {
              if (response.data.statusCode == 204) {
                this.$swal({
                  title: "ลบข้อมูลเสร์จสิ้น",
                  text: "ทำการลบข้อมูลสำเร็จ",
                  icon: "success",
                  showConfirmButton: false,
                  timer: 1000
                }).then(() => {
                  if (result.value) {
                    this.close();
                    const index = this.listusers.indexOf(item);
                    this.listusers.splice(index, 1);
                  }
                });
              } else {
                this.$swal({
                  title: "ลบข้อมูลไม่สำเร็จ",
                  text: "ทำการลบข้อมูลไม่สำเร็จ",
                  icon: "error"
                });
              }
            })
            .catch(err => console.log(err));
        }
      });
    },
    update(item) {
      const config = {
        headers: {
          Authorization:`Bearer ${localStorage.getItem("token")}`
        }
      };
      Axios.get(
        `${process.env.VUE_APP_APIURL}/api/user/${item.id}`,config)
        .then(response => {
          const data = response.data.data;
          this.editedItem.username = data.userName;
          this.editedItem.password = data.password;
          this.editedItem.email = data.email;
          this.editedItem.status_level = data.status_level;
          this.editedItem.serial_number = data.serial_number;

        })
        .catch(err => {
          console.log(err);
        });
    },
    close() {
      this.$nextTick(() => {
        this.editedItem = Object.assign({}, this.defaultItem);
        this.editedIndex = -1;
        this.dialog = false;
        this.$refs.form.reset();
      });
    },
    editItem(item) {
      this.editedIndex = this.listusers.indexOf(item);
      this.editedItem = Object.assign({}, item);
      // console.log(this.editItem);
      this.dialog = true;
    },
    onsubmit() {
      const config = {
        headers: {
          Authorization:`Bearer ${localStorage.getItem("token")}`
        }
      };
      if (this.$refs.form.validate()) {
        if (this.editedIndex > -1) {
          this.$swal({
            title: "ต้องการแก้ไขข้อมูล",
            text: "คุณต้องการแก้ไขข้อมูลหรือไม",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "ยืนยัน",
            cancelButtonText: "ยกเลิก"
          }).then(result => {
            if (result.value) {
              console.log(this.editedItem.id);
              Axios.put(
                `${process.env.VUE_APP_APIURL}/api/user/${this.editedItem.id}`,this.editedItem,config)
                .then(response => {
                  if (response.data.statusCode == 201) {
                    console.log(response);
                    this.$swal({
                      title: "เสร็จสิ้น",
                      text: "ทำการแก้ไขข้อมูลเสร็จสิ้น",
                      icon: "success",
                      showConfirmButton: false,
                      timer: 1000
                      // confirmButtonText: 'ยืนยัน'
                    }).then(() => {
                      Object.assign(
                        this.listusers[this.editedIndex],
                        this.editedItem
                      );
                      this.close();
                    });
                  } else {
                    this.$swal({
                      title: "ไม่สำเร็จ",
                      text: "ทำการแก้ไขข้อมูลไม่สำเร็จ",
                      icon: "error"
                    });
                  }
                })
                .catch(err => console.log(err));
            }
          });
        } else {
          this.$swal({
            title: "ต้องการเพิ่มข้อมูล",
            text: "คุณต้องการเพิ่มข้อมูลหรือไม",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "ยืนยัน",
            cancelButtonText: "ยกเลิก"
          }).then(result => {
            if (result.value) {
              Axios.post(  `${process.env.VUE_APP_APIURL}/api/user/`,this.editedItem,config)
                .then(response => {
                  if (response.data.statusCode == 201) {
                    this.$swal({
                      title: "เสร็จสิ้น",
                      text: "ทำการเพิ่มข้อมูลเสร็จสิ้น",
                      icon: "success",
                      showConfirmButton: false,
                      timer: 1000
                      // confirmButtonText: 'ยืนยัน'
                    }).then(() => {
                      console.log(response.data.data);
                      this.listusers.push(response.data.data);
                      this.close();
                    });
                  } else {
                    this.$swal({
                      title: "ไม่สำเร็จ",
                      text: "ทำการเพิ่มข้อมูลไม่สำเร็จ",
                      icon: "error"
                    });
                  }
                })
                .catch(err => console.log(err));
            }
          });
        }
      }
    }
  }
};
</script>
