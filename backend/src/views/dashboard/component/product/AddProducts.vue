<template>
  <v-container>
    <v-col cols="12">
      <base-material-card
        color="#ee4d2d"
        icon="mdi-store-plus"
        title="เพิ่มสินค้าใหม่"
      >
        <v-card-title>
          <v-form ref="form" v-model="isValid" @submit.prevent="onsubmit">
            <v-row>
              <v-col cols="12" md="6">
                <v-card-title class="headline">
                  <span>ข้อมูลสินค้า</span>
                </v-card-title>
                <v-card-text>
                  <v-container>
                    <v-text-field
                      label="ชื่อผู้ใช้งาน"
                      prepend-icon="mdi-account"
                      v-model="products.nameseller"
                      disabled
                      required
                    ></v-text-field>
                    <v-text-field
                      v-model="products.productname"
                      label="ชื่่อสินค้า"
                      :rules="[(v) => !!v || 'กรุณาใส่ชื่อสินค้า']"
                      required
                      prepend-icon="mdi-tree"
                    ></v-text-field>
                    <v-textarea
                      v-model="products.productdetail"
                      label="ลายละเอียด"
                      rows="1"
                      auto-grow
                      :rules="rules"
                      required
                      prepend-icon="mdi-comment"
                    ></v-textarea>
                  </v-container>
                </v-card-text>
              </v-col>
              <v-col cols="12" md="6">
                <v-card-title class="headline">
                  <span>ข้อมูลการขาย</span>
                </v-card-title>
                <v-card-text>
                  <v-container>
                    <v-col>
                      <v-text-field
                        v-model="products.productprice"
                        label="ราคา"
                        type="number"
                        :rules="[(v) => !!v || 'กรุณาใส่ราคาสินค้า']"
                        required
                        prepend-icon="mdi-cash"
                        suffix="บาท"
                      ></v-text-field>

                      <v-text-field
                        v-model="products.productnumber"
                        label="จำนวน"
                        type="number"
                        :rules="[(v) => !!v || 'กรุณาใส่จำนวนสินค้า']"
                        required
                        prepend-icon="mdi-checkbox-multiple-blank"
                      ></v-text-field>
                    </v-col>
                  </v-container>
                </v-card-text>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12" md="6">
                <v-card-title class="headline">
                  <span>สื่อสินค้า</span>
                </v-card-title>
                <v-card-text>
                  <v-container>
                    <v-file-input
                      accept="image/*"
                      show-size
                      counter
                      label="รูปภาพสินค้า"
                      required
                      @change="upload"
                      prepend-icon="mdi-file-image"
                      :rules="this.editedIndex > -1 ? rulesimgedit : rulesimg"
                    ></v-file-input>
                  </v-container>
                </v-card-text>
              </v-col>
              <v-col cols="12" md="6">
                <v-card-title class="headline">
                  <span>อื่นๆ</span>
                </v-card-title>
                <v-card-text>
                  <v-container>
                    <v-col>
                      <v-radio-group
                        v-model="products.productstatus"
                        row
                        :rules="[(v) => !!v || 'กรุณาใส่สถานะสินค้า']"
                      >
                        <v-radio label="พร้อมขาย" value="1"></v-radio>
                        <v-radio label="กำลังปลูก" value="0"></v-radio>
                      </v-radio-group>
                    </v-col>
                  </v-container>
                </v-card-text>
              </v-col>
            </v-row>
            <v-row>
              <v-container>
                <v-col cols="12" align="center">
                  <v-btn
                    depressed
                    color="success"
                    class="rounded-pill"
                    type="submit"
                  >
                    บันทึกข้อมูล
                  </v-btn>

                  <v-btn
                    depressed
                    color="error"
                    class="rounded-pill"
                    @click="close"
                  >
                    ย้อนกลับ
                  </v-btn>
                </v-col>
              </v-container>
            </v-row>
          </v-form>
        </v-card-title>
      </base-material-card>
    </v-col>
  </v-container>
</template>

<script>
import Axios from "axios";
import { mapState, mapMutations } from "vuex";

export default {
  name: "Addproducts",
  data() {
    return {
      loading: "",
      dialog: false,
      products: {
        nameseller: "",
        productname: "",
        productprice: "",
        productnumber: "",
        productdetail: "",
        productstatus: "",
        productimg: [],
      },
      slelctedFile: null,
      showproducts: [],
      error: [],
      rulesimg: [
        (v) => !!v || "กรุณาเพิ่มรูปภาพ",
        (value) => !value || value.size < 20000000 || "ไฟลืมีขนาดเกิน 20 MB",
        (value) =>
          !value || value.type.startsWith("image") || "กรุณาเลือกไฟล์รูปภาพ",
      ],
      rulesimgedit: [
        (value) => !value || value.size < 20000000 || "ไฟลืมีขนาดเกิน 20 MB",
        (value) =>
          !value || value.type.startsWith("image") || "กรุณาเลือกไฟล์รูปภาพ",
      ],
      rules: [
        (v) => v.length >= 100 || "รห้สอย่างน้อย 100 ตัวอักษร",
        (v) => !!v || "กรุณาใส่ลายละเอียดสินค้า",
      ],
    };
  },
  computed: {
    ...mapState(["datauser"]),
    formTitle() {
      return this.editedIndex === -1 ? "เพิ่มสินค้า" : "แก้ไขข้อมูลสินค้า";
    },
  },

  mounted() {
    const config = {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
    };
    Axios.get(`${process.env.VUE_APP_APIURL}/api/sellproducts/${this.$route.params.id}`, config)
      .then((response) => {
        console.log("response", response);
        this.showproducts = response.data.data;
      })
      .catch((err) => {
        console.log(err);
      });
    this.products.nameseller = this.datauser.tbl_userdetail.name;
  },
  methods: {
    close() {
      this.$nextTick(() => {
        this.editedItem = Object.assign({}, this.defaultItem);
        this.editedIndex = -1;
        this.dialog = false;
        this.$refs.form.reset();
      });
    },
    editItem(item) {
      this.editedIndex = this.showproducts.indexOf(item);
      this.products = Object.assign({}, item);
      this.dialog = true;
    },
    upload() {
      this.slelctedFile = event.target.files[0];
      this.url = URL.createObjectURL(this.slelctedFile);
    },
    onsubmit() {
      const config = {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      };
      if (this.$refs.form.validate()) {
        if (this.editedIndex > -1) {
          Axios.put(
            `${process.env.VUE_APP_APIURL}/api/sellproducts/${this.products.id}`,
            this.products,
            config
          )
            .then((response) => {
              if (response.data.statusCode == 201) {
                if (this.slelctedFile == null) {
                  Object.assign(
                    this.showproducts[this.editedIndex],
                    this.products
                  );
                  this.$refs.form.reset();
                  this.close();
                  return;
                }
                const id = response.data.id;
                const formdata = new FormData();
                formdata.append(
                  "files",
                  this.slelctedFile,
                  this.slelctedFile.name
                );
                const configimg = {
                  headers: {
                    "Content-Type": "multipart/form-data",
                  },
                };
                console.log(configimg);
                Axios.put(
                  `${process.env.VUE_APP_APIURL}/api/sellproducts/img/${id}`,
                  formdata,
                  configimg
                )
                  .then((response) => {
                    if (response.data.statusCode == 201) {
                      console.log(response);
                      const namefile = response.data.namefile;
                      Object.assign(
                        this.showproducts[this.editedIndex],
                        this.products
                      );
                      this.close();
                      location.reload();
                    }
                  })
                  .catch((err) => {
                    this.$swal({
                      title: "ไม่สำเร็จ",
                      text: err.response.data.message,
                      icon: "error",
                      showConfirmButton: true,
                      confirmButtonText: "ยืนยัน",
                    }).then(() => {
                      this.slelctedFile = null;
                      this.products.productimg.value = "";
                    });
                  });
              }
            })
            .catch((err) => {
              this.$swal({
                title: "ไม่สำเร็จ",
                text: err.response.data.message,
                icon: "error",
                showConfirmButton: true,
                confirmButtonText: "ยืนยัน",
              });
              this.slelctedFile = null;
            });
        } else {
          Axios.post(
            `${process.env.VUE_APP_APIURL}/api/sellproducts`,
            this.products,
            config
          )
            .then((response) => {
              if (response.data.statusCode == 201) {
                const id = response.data.data.id;
                const dataresponse = response.data.data;
                const formdata = new FormData();
                formdata.append(
                  "files",
                  this.slelctedFile,
                  this.slelctedFile.name
                );
                const configimg = {
                  headers: {
                    "Content-Type": "multipart/form-data",
                  },
                };
                Axios.put(
                  `${process.env.VUE_APP_APIURL}/api/sellproducts/img/${id}`,
                  formdata,
                  configimg
                )
                  .then((response) => {
                    if (response.data.statusCode == 201) {
                      this.$swal({
                        title: "สำเร็จ",
                        text: "ทำการเพิ่มสินค้าสำเร็จ",
                        icon: "success",
                      });
                      dataresponse.productimg = response.data.namefile; //dataresponse คืออะไร #ff0000
                      this.showproducts.push(dataresponse);
                      this.close();
                    }
                  })
                  .catch((err) => {
                    this.$swal({
                      title: "ไม่สำเร็จ",
                      text: err.response.data.message,
                      icon: "error",
                      showConfirmButton: true,
                      // timer: 1000
                      confirmButtonText: "ยืนยัน",
                    });
                    this.slelctedFile = null;
                  });
              }
            })
            .catch((err) => {
              this.$swal({
                title: "ไม่สำเร็จ",
                text: err.response.data.message,
                icon: "error",
                showConfirmButton: true,
                // timer: 1000
                confirmButtonText: "ยืนยัน",
              });
              this.slelctedFile = null;
            });
        }
      }
    },
    //   del(item){
    //     const config = {
    //       headers: {
    //         Authorization:`Bearer ${localStorage.getItem("token")}`
    //       }
    //     };
    //     this.$swal({
    //       title: 'ต้องการลบข้อมูล',
    //       text: "คุณต้องการลบข้อมูลหรือไม่",
    //       icon: 'warning',
    //       showCancelButton: true,
    //       confirmButtonColor: '#3085d6',
    //       cancelButtonColor: '#d33',
    //       confirmButtonText: 'ยืนยัน',
    //       cancelButtonText: 'ยกเลิก'
    //       })
    //       .then((result) => {
    //           if (result.value) {
    //             Axios.delete(`${process.env.VUE_APP_APIURL}/api/sellproducts/${item.id}`,config)
    //                 .then(response => {
    //                     if(response.data.statusCode == 204){
    //                         console.log(response);
    //                             this.$swal({
    //                             title: "เสร็จสิ้น",
    //                             text: "ทำการลบสินค้าเสร็จสิ้น",
    //                             icon: "success",
    //                             showConfirmButton: false,
    //                             timer: 1000
    //                             })
    //                         Axios.delete(`${process.env.VUE_APP_APIURL}/api/sellproducts/img/${item.productimg}`,config)
    //                             .then(response => {
    //                                 if(response.data.statusCode == 204){
    //                                     this.$swal({
    //                                     title: "เสร็จสิ้น",
    //                                     text: "ทำการลบสินค้าเสร็จสิ้น",
    //                                     icon: "success",
    //                                     showConfirmButton: false,
    //                                     timer: 1000
    //                                     })
    //                                     const index = this.showproducts.indexOf(item)
    //                                     this.showproducts.splice(index, 1)
    //                                 }
    //                             }).catch((err) => {
    //                                 this.$swal({
    //                                 title: "ไม่สำเร็จ",
    //                                 text: "ไม่สามารถลบสินค้าได้",
    //                                 icon: "error",
    //                                 showConfirmButton: true,
    //                                 confirmButtonText: 'ยืนยัน'
    //                                 })
    //                             });

    //                     }
    //                 }).catch((err) => {
    //                     this.$swal({
    //                         title: "ไม่สำเร็จ",
    //                         text: "ไม่สามารถลบสินค้าได้",
    //                         icon: "error",
    //                         showConfirmButton: true,
    //                         confirmButtonText: 'ยืนยัน'
    //                         })
    //                 });
    //           }
    //       })
    //   }
  },
};
</script>

<style scss scoped>
.v-form {
  width: 100%;
}

.detailproducts,
.tabproducts {
  font-size: 15px;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 1;
  height: inherit;
  text-overflow: ellipsis;
  overflow: hidden;
}

.newcardproducts {
  opacity: 0.5;
  transition: 0.5s;
}
.newcardproducts:hover {
  opacity: 1;
}

.boxactions {
  position: absolute;
  bottom: 5px;
  width: 100%;
}
</style>
