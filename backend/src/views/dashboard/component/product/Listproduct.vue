<template>
  <v-container>
    <v-col cols="12">
      <v-card>
        <!-- <v-card-text>
          <v-row>
            <v-tabs
              v-model="tab"
              background-color="transparent"
              color="basil"
              grow
              show-arrows
            >
              <v-tab cols="12" md="2" v-for="headers in header" :key="headers">
                {{ headers.namehad }}
                ({{ headers.count }})
              </v-tab>
            </v-tabs>
          </v-row>
        </v-card-text> -->
        <v-col>
          <v-card-title class="haderoption">
            <v-row>
              <v-col cols="12" md="5" class="hade">
                <h3>สินค้า {{ this.showproducts.length }} รายการ</h3>
              </v-col>
              <v-col class="option">
                <router-link to="/pages/product/addproduct">
                  <v-btn>
                    <v-icon size="55px" color="#ffffff"> mdi-plus </v-icon>
                    เพิ่มสินค้า
                  </v-btn>
                </router-link>
              </v-col>
            </v-row>
          </v-card-title>
          <div class="showproduct">
            <v-row>
              <v-col
                cols="12"
                sm="4"
                m="3"
                md="3"
                xl="2"
                v-for="items in showproducts"
                :key="items.id"
              >
                <v-card elevation="0" width="100%" class="product-card-item">
                  <div class="product-image">
                    <v-img
                      :src="`http://maims.cmtc.ac.th:3000/product/${items.productimg}`"
                    >
                      <div
                        class="product-image-overlay"
                        v-show="items.productstatus == '0'"
                      >
                        <v-icon>mdi-lock</v-icon>
                        <span>กำลังปลูก</span>
                        <v-btn small @click="editstatuspro(items)">ลงขาย</v-btn>
                      </div>
                    </v-img>
                  </div>
                  <div class="productdetail">
                    <div class="product-name T-dot">
                      {{ items.productname }}
                    </div>
                    <div class="product-info">
                      <div class="product-price">
                        ฿ {{ items.productprice }}
                      </div>
                      <div class="product-stock">
                        คลัง {{ items.productnumber }}
                      </div>
                    </div>
                    <div class="product-detail T-dot">
                      {{ items.productdetail }}
                    </div>
                  </div>
                  <div class="product-actions">
                    <v-icon @click="edit(items.id)" color="#FFBB29">mdi-pencil</v-icon>
                    <v-icon @click="del(items)" color="#FF6347"
                      >mdi-delete</v-icon
                    >
                  </div>
                </v-card>
              </v-col>
            </v-row>
          </div>
        </v-col>
      </v-card>
    </v-col>
  </v-container>
</template>

<script>
import Axios from "axios";
import { mapState, mapMutations } from "vuex";

export default {
  name: "Listproduct",
  data() {
    return {
      show: "1",
      header: [
        {
          namehad: "ทั้งหมด",
          count: "1",
        },
        {
          namehad: "หมด",
          count: "2",
        },
        {
          namehad: "กำลังปลูก",
          count: "3",
        },
      ],
      showproducts: [],
      productstatus: "",
    };
  },
  created() {
    const config = {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
    };
    Axios.get(`${process.env.VUE_APP_APIURL}/api/sellproducts`, config)
      .then((response) => {
        console.log("response", response);
        this.showproducts = response.data.data;
      })
      .catch((err) => {
        console.log(err);
      });
  },
  methods: {
    edit(items){
      this.$router.replace(`/pages/product/listproduct/edit/${items}`);
    },
    editstatuspro(items) {
      const config = {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      };
      const index = this.showproducts.indexOf(items);
      console.log(index);
      this.$swal({
        title: "เปลี่ยนสถานะสินค้า",
        text: "คุณต้องการเปลี่ยนสถานะสินค้าหรือไม่",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "ยืนยัน",
        cancelButtonText: "ยกเลิก",
      }).then((result) => {
        if (result.value) {
          Axios.put(
            `${process.env.VUE_APP_APIURL}/api/sellproducts/statusproduct/${items.id}`,
            { productstatus: 1 },
            config
          )
            .then((response) => {
              if (response.data.statusCode == 201) {
                console.log(response.data);
                this.$swal({
                  title: "เสร็จสิ้น",
                  text: "ทำการเปลี่ยนสถานะสินค้าเสร็จสิ้น",
                  icon: "success",
                  showConfirmButton: false,
                  timer: 1000,
                });
                Object.assign(this.showproducts[index], response.data.data);
              }
            })
            .catch((err) => {
              this.$swal({
                title: "ไม่สำเร็จ",
                text: "ไม่สามารถลบสินค้าได้",
                icon: "error",
                showConfirmButton: true,
                confirmButtonText: "ยืนยัน",
              });
            });
        }
      });
    },
    del(items) {
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
            `${process.env.VUE_APP_APIURL}/api/sellproducts/${items.id}`,
            config
          )
            .then((response) => {
              if (response.data.statusCode == 204) {
                console.log(response);
                this.$swal({
                  title: "เสร็จสิ้น",
                  text: "ทำการลบสินค้าเสร็จสิ้น",
                  icon: "success",
                  showConfirmButton: false,
                  timer: 1000,
                });
                Axios.delete(
                  `${process.env.VUE_APP_APIURL}/api/sellproducts/img/${items.productimg}`,
                  config
                )
                  .then((response) => {
                    if (response.data.statusCode == 204) {
                      this.$swal({
                        title: "เสร็จสิ้น",
                        text: "ทำการลบสินค้าเสร็จสิ้น",
                        icon: "success",
                        showConfirmButton: false,
                        timer: 1000,
                      });
                      const index = this.showproducts.indexOf(items);
                      this.showproducts.splice(index, 1);
                    }
                  })
                  .catch((err) => {
                    this.$swal({
                      title: "ไม่สำเร็จ",
                      text: "ไม่สามารถลบสินค้าได้",
                      icon: "error",
                      showConfirmButton: true,
                      confirmButtonText: "ยืนยัน",
                    });
                  });
              }
            })
            .catch((err) => {
              this.$swal({
                title: "ไม่สำเร็จ",
                text: "ไม่สามารถลบสินค้าได้",
                icon: "error",
                showConfirmButton: true,
                confirmButtonText: "ยืนยัน",
              });
            });
        }
      });
    },
  },
};
</script>

<style lang="scss" scoped>
.T-dot {
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
  height: inherit;
  text-overflow: ellipsis;
  overflow: hidden;
}
.haderoption {
  .hade {
    display: flex;
    align-items: center;
  }

  .option {
    display: flex;
    justify-content: flex-end;

    i {
      font-size: 30px !important;
    }
  }
}

.showproduct {
  // display: flex;
  padding: 0px 50px;

  .product-card-item:hover {
    border: 1px solid #00000029;
    box-shadow: 10px 10px 106px -77px rgba(0, 0, 0, 0.77) !important;
  }
  .product-card-item {
    background-color: #fff;
    // border-radius: 15px;
    border: 1px solid #00000029;
    transition: 0.5s ease-out;

    .product-image {
      display: flex;
      //   padding: 10px;
      height: 150px;
      background-size: cover;

      .product-image-overlay {
        width: 100%;
        height: 100%;
        position: relative;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        text-align: center;
        background-color: #00000054;
      }
      .v-icon {
        font-size: 25px;
        color: #ffffff;
      }
      span {
        font-size: 18px;
        color: #ffffff;
      }

      button {
        margin: 0px !important;
        width: 50%;
      }
    }
    .productdetail {
      margin-top: 5px;
      padding: 15px;

      .product-name {
        font-weight: bold;
      }

      .product-info {
        display: flex;
        justify-content: space-between;
        .product-price {
          color: #ff6347;
        }
      }
    }
    .product-detail {
      margin-top: 5px;
    }
    .product-actions {
      bottom: 1px;
      width: 100%;
      display: flex;
      justify-content: center;
      padding: 5px 0px;
      margin-top: 15px;
      border-top: 1px solid #00000033;

      .v-icon {
        margin: auto;
      }
    }
  }
}
</style>
