<template>
  <v-container>
    <v-col cols="12">
      <base-material-card
        color="info"
        icon="mdi-card-account-details"
        title="จัดการซีเรียล"
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
                    <v-icon> mdi-plus </v-icon>
                    <v-text class="ml-2 display-1"> เพิ่มซีเรียล </v-text>
                  </v-btn>
                </template>
                <v-card>
                  <v-card-title class="headline">
                    <span>เพิ่มซีเรียล</span>
                  </v-card-title>
                  <v-card-text>
                    <v-container>
                      <v-form
                        ref="form"
                        v-model="isValid"
                        @submit.prevent="save"
                      >
                        <v-text-field
                          v-model="serial.title"
                          label="ชื่อย่อ"
                          required
                          :rules="[rules.title, rules.min]"
                          prepend-icon="mdi-key"
                        ></v-text-field>

                        <v-text-field
                          v-model="serial.count"
                          label="จำนวน"
                          :rules="[rules.number, rules.numberRule]"
                          type="number"
                          required
                          prepend-icon="mdi-pencil"
                        ></v-text-field>
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
            :items="listserial"
            :search="search"
            :loading="loading"
            loader-height="2px"
            loading-text="Loading... Please wait"
            color="info"
          >
            <template v-slot:item.status="{ item }">
              {{ item.status == 1 ? "ถูกใช้งาน" : "ยังไม่ถูกใช้งาน" }}
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
import { mapState, mapMutations } from "vuex";
export default {
  name: "Addserial",
  data() {
    return {
      count: 0,
      dialog: false,
      listserial: [],
      headers: [
        { text: "รห้สซีเรียล", value: "serial" },

        {
          text: "สถานะ",
          align: "center",
          sortable: false,
          value: "status",
        },
        {
          text: "วัน/เดือน/ปี",
          align: "center",
          sortable: false,
          value: "createdAt",
          width: "15%",
        },
        {
          text: "ลบ",
          align: "center",
          sortable: false,
          value: "del",
          width: "5%",
        },
      ],
      serial: {
        title: "",
        count: "",
      },
      rules: {
        min: (v) => v.length <= 3 || "ใส่ได้สูงสุด 3 ตัว อักษร",
        title: (v) => !!v || "กรุณาใส่รห้สซีเรียล",
        numberRule: (v) =>
          (!isNaN(parseFloat(v)) && v >= 0 && v <= 25) ||
          "กรอกได้สูงสุด 25 ซีเรียล",
        number: (v) => !!v || "กรุณาใส่จำนวนซีเรียล",
      },
    };
  },
  computed: {
    ...mapState(["datauser"]),
  },
  created() {
    const config = {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
    };
    Axios.get(`${process.env.VUE_APP_APIURL}/api/user/admin/serialshow`, config)
      .then((response) => {
        this.listserial = response.data.data;
        this.loading = false;
      })
      .catch((err) => {
        console.log(err);
      });
  },
  methods: {
    close() {
      this.$nextTick(() => {
        this.editedIndex = -1;
        this.dialog = false;
        this.$refs.form.reset();
      });
    },

    save() {
      const config = {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      };
      Axios.post(
        `${process.env.VUE_APP_APIURL}/api/user/admin/addserial`,
        this.serial,
        config
      ).then((response) => {
        for (let index = 0; index < this.serial.count; index++) {
          this.listserial.push(response.data.data[index]);
        }
        this.$swal({
          title: "สำเร็จ",
          text: "Successfully Add Serial",
          icon: "success",
        });
        this.close();
      });
    },
    del(serial) {
      const config = {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      };
      this.$swal({
        title: "ต้องการลบข้อมูล",
        text: "คุณต้องการลบข้อมูลหรือไม่",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "ยืนยัน",
        cancelButtonText: "ยกเลิก",
      }).then((result) => {
        if (result.value) {
          Axios.delete(
            `${process.env.VUE_APP_APIURL}/api/user/serial/${serial.id}`,
            config
          )
            .then((response) => {
              this.$swal({
                title: "สำเร็จ",
                text: "ทำการลบข้อมูลสำเร็จ",
                icon: "success",
              });
              const index = this.datauser.tbl_userserials.indexOf(serial);
              this.datauser.tbl_userserials.splice(index, 1);
            })
            .catch((err) => {
              this.$swal({
                title: "ไม่สำเร็จ",
                text: err.response.data.message,
                icon: "error",
              });
            });
        }
      });
    },
  },
};
</script>
<style lang="scss" scoped>
.haderpeng {
  padding: 15px;
  border-bottom: 1px solid rgba(0, 0, 0, 0.11);
  width: 100%;

  .subtitle {
    font-size: 1rem;
  }
  .showserial {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;

    .active {
      display: flex;
      align-content: center;
      justify-content: center;

      button {
        margin-left: 30px;
        font-size: 22px;
        opacity: 0.8;
      }
      button:hover {
        opacity: 1;
        margin-left: 30px;
        font-size: 22px;
      }
    }
  }
}

.edit {
  margin: 20px auto;
  font-size: 14px;

  .addbank {
    display: flex;
    justify-content: flex-end;

    button {
      margin: 0px !important;
    }
  }

  .col-12 {
    text-align: left;
  }

  .col-md-3 {
    text-align: right;
  }
  .haderlist {
    color: #868686;
    font-size: 14px;
  }

  .v-input {
    height: 100%;
    font-size: 14px;
  }

  .v-text-field {
    padding: 0;
    margin: 0;
  }

  .col-xl,
  .col-xl-auto,
  .col-xl-12,
  .col-xl-11,
  .col-xl-10,
  .col-xl-9,
  .col-xl-8,
  .col-xl-7,
  .col-xl-6,
  .col-xl-5,
  .col-xl-4,
  .col-xl-3,
  .col-xl-2,
  .col-xl-1,
  .col-lg,
  .col-lg-auto,
  .col-lg-12,
  .col-lg-11,
  .col-lg-10,
  .col-lg-9,
  .col-lg-8,
  .col-lg-7,
  .col-lg-6,
  .col-lg-5,
  .col-lg-4,
  .col-lg-3,
  .col-lg-2,
  .col-lg-1,
  .col-md,
  .col-md-auto,
  .col-md-12,
  .col-md-11,
  .col-md-10,
  .col-md-9,
  .col-md-8,
  .col-md-7,
  .col-md-6,
  .col-md-5,
  .col-md-4,
  .col-md-3,
  .col-md-2,
  .col-md-1,
  .col-sm,
  .col-sm-auto,
  .col-sm-12,
  .col-sm-11,
  .col-sm-10,
  .col-sm-9,
  .col-sm-8,
  .col-sm-7,
  .col-sm-6,
  .col-sm-5,
  .col-sm-4,
  .col-sm-3,
  .col-sm-2,
  .col-sm-1,
  .col,
  .col-auto,
  .col-12,
  .col-11,
  .col-10,
  .col-9,
  .col-8,
  .col-7,
  .col-6,
  .col-5,
  .col-4,
  .col-3,
  .col-2,
  .col-1 {
    padding: 0px !important;
  }
}
</style>