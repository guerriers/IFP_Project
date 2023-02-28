<template>
  <v-container>
    <v-col cols="12">
      <base-material-card
        color="info"
        icon="fas fa-clipboard-list"
        title="คำสั่งซื้อสินค้า"
      >
  
        <!-- <formuser /> -->
        <v-card-title>
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
          <v-col cols="12" md="8">
            <v-btn-toggle
              class="fittingbutton"
              v-model="toggle_exclusive"
              mandatory
              borderless="none"
              cols="12"
              md="7"
            >
              <v-btn depressed text @click="order('all')" class="rounded-pill">
                <v-icon> mdi-clipboard-text </v-icon>
                <v-text class="ml-2"> ทั้งหมด </v-text>
              </v-btn>
              <v-btn
                depressed
                text
                @click="order('Order')"
                class="rounded-pill mx-1"
              >
                <v-icon> mdi-clipboard-arrow-down-outline </v-icon>
                <v-text class="ml-2"> ออเดอร์ </v-text>
              </v-btn>
              <v-btn
                depressed
                text
                @click="order('Delivery')"
                class="rounded-pill mx-1"
              >
                <v-icon> mdi-car </v-icon>
                <v-text class="ml-2"> ระหว่างส่ง </v-text>
              </v-btn>
              <v-btn
                depressed
                text
                @click="order('Success')"
                class="rounded-pill"
              >
                <v-icon> mdi-check-bold </v-icon>
                <v-text class="ml-2"> เสร็จสิ้น </v-text>
              </v-btn>
            </v-btn-toggle>
          </v-col>
        </v-card-title>
        <v-card-text>
          <v-data-table
            v-model="selected"
            :headers="headers"
            :items="filter"
            :search="search"
            :loading="loading"
            loader-height="2px"
            loading-text="Loading... Please wait"
            color="info"
          >
            <template v-slot:item.view="{ item }">
              <v-icon
                small
                clas
                s="mr-2"
                color="#FFBB29"
                @click="view(item)"
              >
                mdi-eye
              </v-icon>
            </template>
          </v-data-table>
        </v-card-text>
        <v-dialog v-model="dialog" max-width="500px">
          <v-card>
            <v-card-title>
              <v-icon> mdi-clipboard-arrow-down-outline </v-icon>
              <span>รายละเอียด</span>
            </v-card-title>
            <v-container>
              <v-row class="d-flex align-center">
                <v-col cols="3" class="font-weight-bold py-2"> สถานะ </v-col>
                <v-chip
                  :color="
                    onelistDelivery.orderStatus === 'Order'
                      ? '#F05347'
                      : onelistorder.orderStatus === 'Delivery'
                      ? '#fb8c00'
                      : '#4CAF50'
                  "
                  dark
                  small
                >
                  {{ onelistorder.status_order }}
                </v-chip>
              </v-row>
              <v-row>
                <v-col cols="3" class="font-weight-bold py-2">
                  รห้สการซื้อ
                </v-col>
                <v-col cols="9" class="py-2">
                  {{ onelistorder.id }}
                </v-col>
              </v-row>
              <v-row>
                <v-col cols="3" class="font-weight-bold py-2">
                  ชื่อผู้สั่ง
                </v-col>
                <v-col cols="3" class="py-2">
                  {{ onelistorder.fullName }}
                </v-col>
              </v-row>
              <v-row>
                <v-col class="font-weight-bold py-2">
                  ที่อยู่ที่ต้องจัดส่ง
                </v-col>
              </v-row>
              <v-col cols="12" class="py-2">
                {{ onelistorder.streetAddress }} {{ onelistorder.district }} {{ onelistorder.province }} {{ onelistorder.zipCode }}
              </v-col>
              <v-row>
                <v-col cols="3" class="font-weight-bold py-2"> เบอร์โทร </v-col>
                <v-col cols="9" class="py-2">
                  {{ onelistorder.phoneNumber }}
                </v-col>
              </v-row>
              <v-row>
                <v-col class="font-weight-bold py-2"> รายการสินค้า </v-col>
              </v-row>
              <v-data-table
                :headers="headerview"
                :items="listorder"
                :search="search"
                :loading="loading"
                loader-height="2px"
                loading-text="Loading... Please wait"
                color="info"
                hide-default-footer
                class="pa-0 table"
              />
              <div class="text-center my-5">
                <v-btn
                  v-if="onelistDelivery.orderStatus === 'Order'"
                  class="mx-0"
                  color="primary"
                  @click="changestatus(onelistDelivery.id)"
                >
                  <v-icon> mdi-car </v-icon>
                  ยืนยันการจัดส่ง
                </v-btn>
              </div>
            </v-container>
          </v-card>
        </v-dialog>
      </base-material-card>
    </v-col>
  </v-container>
</template>

<script>
import Axios from "axios";

export default {
  name: "order",
  data() {
    return {
      loading: true,
      arryitem: "",
      onelistorder: {},
      onelistDelivery: {},
      filter: [],
      dialog: false,
      listorder: [],
      search: "",
      items: ["Delivery", "Success", "Order"],
      headerview: [
        { text: "ลำดับ", sortable: false },
        { text: "รายการ", sortable: false },
        { text: "จำนวน", sortable: false },
        { text: "ราคา", sortable: false },
      ],
      headers: [
        { text: "รห้สสั่งซื้อ", value: "transaction.orderNo", align: "center", sortable: false },
        {
          text: "ชื่อผุ้สั่ง",
          value: "CustomerAddress.fullName",
          align: "center",
          sortable: false,
        },
        {
          text: "รายการ",
          value: "tbl_sellproduct.productname",
          align: "center",
          sortable: false,
        },
        {
          text: "ราคา",
          value: "CustomerOrder.totalPrice",
          align: "center",
          sortable: false,
        },
        {
          text: "สถานะ",
          align: "center",
          value: "CustomerDelivery.orderStatus",
          width: "15%",
          sortable: false,
        },
        {
          text: "ดูรายละเอียด",
          align: "center",
          sortable: false,
          value: "view",
          width: "10%",
        },
      ],
    };
  },
  created() {
    const config = {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
    };
    Axios.get(`${process.env.VUE_APP_APIURL}/api/order/showorder`, config).then(
      (response) => {
        this.listorder = response.data.order;
        this.filter = this.listorder;
        this.filter.reverse();
        this.loading = false;
      }
    );
    console.log(this.filter);
  },
  methods: {
    view(item) {
      this.arryitem = this.filter.indexOf(item);
      this.onelistorder = Object.assign({}, item.CustomerAddress);
      this.onelistDelivery = Object.assign({}, item.CustomerDelivery);
      this.dialog = true;
    },
    order(item) {
      let dataall = this.listorder;
      if (item == "all") {
        this.filter = this.listorder;
      } else {
        let datafilter = dataall.filter(
          (dataall) => dataall.CustomerDelivery.orderStatus == item
        );
        this.filter = datafilter;
      }
    },
    changestatus(item) {
      Axios.put(`${process.env.VUE_APP_APIURL}/api/order/${item}`).then(
        (response) => {
          if (response.data.statusCode == 201) {
            this.$swal({
              title: "เสร็จสิ้น",
              text: "ทำการเพิ่มข้อมูลเสร็จสิ้น",
              icon: "success",
              showConfirmButton: false,
              timer: 1000,
              // confirmButtonText: 'ยืนยัน'
            });
            this.dialog = false;
            Object.assign(
              (this.filter[this.arryitem].status_order = "Delivery")
            );
          } else {
            this.$swal({
              title: "ไม่สำเร็จ",
              text: "ทำการเพิ่มข้อมูลไม่สำเร็จ",
              icon: "error",
            });
          }
        }
      );
    },
  },
};
</script>

<style lang="css" scope>
.fittingbutton {
  display: flex;
  justify-content: flex-end !important;
}

.v-btn-toggle:not(.v-btn-toggle--dense) .v-btn.v-btn.v-size--default {
  width: 20%;
}

.v-dialog .v-card .v-card__title .v-icon {
  position: relative;
  top: 0;
  left: 0;
  opacity: 1;
  color: #000000;
  margin-right: 2px;
  font-size: 25px;
}

.v-ripple__content {
  display: none;
}

.fittingbutton .theme--light.v-btn--active::before,
.fittingbutton .theme--light.v-btn--active::before {
  opacity: 1;
  background-color: #629d25;
  transition: 1s;
}
.fittingbutton .theme--light.v-btn--active .v-btn__content {
  color: #fff;
}

.theme--light.v-btn-toggle:not(.v-btn-toggle--group)
  .v-btn.v-btn--active
  .v-icon {
  color: #fff;
}

.fittingbutton .theme--light.v-btn::before {
  transition: 0.5s;
}
.fittingbutton .theme--light.v-btn:active::before {
  opacity: 0.2;
  background-color: #629d25;
}

@media only screen and (max-width: 960px) {
  .fittingbutton {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-around !important;
    max-width: 100%;
  }
  .v-btn-toggle:not(.v-btn-toggle--dense) .v-btn.v-btn.v-size--default {
    width: 150px;
  }
}

@media only screen and (max-width: 440px) {
  .v-btn-toggle:not(.v-btn-toggle--dense) .v-btn.v-btn.v-size--default {
    width: 100%;
  }
}
</style>