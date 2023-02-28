
<template>
  <v-container id="dashboard" fluid tag="section">
    <v-row class="showdata">
      <v-col>
        <v-row>
          <v-col cols="12" sm="5" lg="5">
            <div class="datawater">
              <v-card>
                <h1>Water</h1>
                <div class="data">
                  <img src="/water.png" alt="" />
                  <h1>{{ this.dbrealtime.water_level }}%</h1>
                </div>
              </v-card>
            </div>
          </v-col>
          <v-spacer />
          <v-col cols="12" sm="7" lg="7">
            <div class="datasensor">
              <v-card>
                <v-icon> fas fa-thermometer-empty </v-icon>
                <!-- <i class="fas fa-thermometer-empty"></i> -->
                <h1>{{ this.dbrealtime.temp }}%</h1>
                <p>Temp</p>
              </v-card>

              <v-card>
                <!-- <v-icon> fad fa-caravan-alt </v-icon> -->
                <v-icon> mdi-water-percent </v-icon>
                <h1>{{ this.dbrealtime.humi }}%</h1>
                <p>Humi</p>
              </v-card>

              <v-card>
                <v-icon> fas fa-sun </v-icon>
                <h1>
                  {{ this.dbrealtime.light_int }}
                </h1>
                <p>light</p>
              </v-card>


              <v-card>
                <!-- <v-icon> mdi-water-percent </v-icon> -->
                <v-icon> mdi-flask-empty-plus  </v-icon>
                <h1>
                  {{ this.dbrealtime.ec.toFixed(1) }}
                </h1>
                <p>ppm</p>
              </v-card>

              <v-card>
                <v-icon> fas fa-tint </v-icon>
                <h1>
                  {{ this.dbrealtime.ph.toFixed(1) }}
                </h1>
                <p>pH</p>
              </v-card>
            </div>
          </v-col>
        </v-row>

        <!----------------------------end showsirsor----------------- -->
        <v-col cols="12" class="statuspump">
          <v-card color="white">
            <v-card-text>
              <v-row>
                <v-col cols="12" sm="6" lg="3">
                  <base-material-stats-card
                    color="info"
                    icon="mdi-cup-water"
                    title="Pump A"
                    :value="dbrealtime.pump_a === 0 ? 'OFF' : 'ON'"
                    sub-icon="mdi-clock"
                    sub-value="aasds"
                    :sub-text="dateConvert"
                  />
                </v-col>

                <v-col cols="12" sm="6" lg="3">
                  <base-material-stats-card
                    color="info"
                    icon="mdi-water"
                    title="Pump B"
                    :value="dbrealtime.pump_b === 0 ? 'OFF' : 'ON'"
                    sub-icon="mdi-clock"
                    :sub-text="dateConvert"
                  />
                </v-col>
                <v-col cols="12" sm="6" lg="3">
                  <base-material-stats-card
                    color="info"
                    icon="mdi-water-plus"
                    title="Pump C"
                    :value="dbrealtime.pump_c === 0 ? 'OFF' : 'ON'"
                    sub-icon="mdi-clock"
                    :sub-text="dateConvert"
                  />
                </v-col>
                <v-col cols="12" sm="6" lg="3">
                  <base-material-stats-card
                    color="info"
                    icon="mdi-bitbucket"
                    title="Pump D"
                    :value="dbrealtime.pump_d === 0 ? 'OFF' : 'ON'"
                    sub-icon="mdi-clock"
                    :sub-text="dateConvert"
                  />
                </v-col>
              </v-row>
            </v-card-text>
          </v-card>
        </v-col>
      </v-col>

      <v-col cols="12" md="2" class="showserial">
        <base-material-card color="info" icon="mdi-rotate-orbit" title="Serial">
          <v-list>
            <v-list-item
              v-for="item in this.getdatauser.tbl_userserials"
              :key="item"
              class="justify-center"
            >
              <v-btn class="ma-0" @click="id_serial(item)">
                {{ item.name }}
              </v-btn>
            </v-list-item>
          </v-list>
        </base-material-card>
      </v-col>
    </v-row>
    <!-- --------------------------end สถานะปั้ม ------------------------- -->
    <v-col cols="12">
      <base-material-card color="info" class="px-5 py-3">
        <template v-slot:heading>
          <v-col cols="12">
            <div ><h1>รายการย้อนหลังสถานะ</h1> </div>
          </v-col>

          <!-- <div class="subtitle-1 font-weight-light">
              :
            </div> -->
        </template>
        <v-card-text>
          <v-data-table :headers="headers" :items="dblist" color="info">
            <template v-slot:item.createdAt="{ item }">
              {{ formatDate(item.updatedAt) }}
            </template>
            <template v-slot:item.pump_a="{ item }">
              <v-chip :color="item.pump_a === 1 ? '#4CAF50' : '#FF6347'">
                {{ item.pump_a === 0 ? "OFF" : "ON" }}
              </v-chip>
            </template>
            <template v-slot:item.pump_b="{ item }">
              <v-chip :color="item.pump_b === 1 ? '#4CAF50' : '#FF6347'">
                {{ item.pump_b === 0 ? "OFF" : "ON" }}
              </v-chip>
            </template>
            <template v-slot:item.pump_c="{ item }">
              <v-chip :color="item.pump_c === 1 ? '#4CAF50' : '#FF6347'">
                {{ item.pump_c === 0 ? "OFF" : "ON" }}
              </v-chip>
            </template>
            <template v-slot:item.pump_d="{ item }">
              <v-chip :color="item.pump_d === 1 ? '#4CAF50' : '#FF6347'">
                {{ item.pump_d === 0 ? "OFF" : "ON" }}
              </v-chip>
            </template>
          </v-data-table>
        </v-card-text>
      </base-material-card>
    </v-col>
  </v-container>
</template>

<script>
import Axios from "axios";
import { mapState, mapMutations, mapGetters } from "vuex";
import moment, * as MOMENT from "moment";
import '@fortawesome/fontawesome-free/css/all.css'

export default {
  name: "DashboardDashboard",

  data() {
    return {
      headers: [
        { text: "ID", value: "id", sortable: false, align: "center" },
        { text: "อุณหภูมิ", value: "temp" },
        { text: "ความชื้น", value: "humi" },
        { text: "ความเข้มของแสง", value: "light_int" },
        { text: "ความเข้มของปุ๋ย", value: "ec" },
        { text: "ph", value: "ph" },
        { text: "Pump A", value: "pump_a", sortable: false },
        { text: "Pump B", value: "pump_b", sortable: false },
        { text: "Pump C", value: "pump_c", sortable: false },
        { text: "Pump D", value: "pump_d", sortable: false },
        { text: "วันที่/เวลา", value: "createdAt" },
        { text: "Serial", value: "serial_id" },
      ],
      dbrealtime: [],
      dblist: [],
      loading: true,
      dateConvert: "",
      updatedAtConvert: "",
    };
  },
  mounted() {
    
    const config = {
      headers: {
        Authorization: `Bearer ${localStorage.getItem("token")}`,
      },
    };

    Axios.post(
      `${process.env.VUE_APP_APIURL}/api/dbrealtime`,
      { serial : "1" },
      config
    ).then((response) => {
      this.dbrealtime = response.data.data;
      this.dateConvert = MOMENT(this.dbrealtime.updatedAt).format(
        "DD/MM/YYYY  HH:mm:ss"
      );
      console.log("dataLoad", this.dbrealtime);
    });

    Axios.post(
      `${process.env.VUE_APP_APIURL}/api/dblist`,
      { serial: "1" },
      config
    ).then((response) => {
      this.dblist = response.data.data;
      this.createdAtConvert = MOMENT(this.dblist.updatedAt).format(
        "YYYY-MM-DD  HH:mm:ss"
      );
      this.loading = false;
      console.log("dataLoad", this.dblist);
    });
  },
  computed: {
    ...mapGetters(["getdatauser"]),
  },

  methods: {

    id_serial(item) {
      let serial = item.id;

      const config = {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("token")}`,
        },
      };
      Axios.post(
        `${process.env.VUE_APP_APIURL}/api/dbrealtime`,
        { serial: serial },
        config
      ).then((response) => {
        this.dbrealtime = response.data.data;
      });
      Axios.post(
        `${process.env.VUE_APP_APIURL}/api/dblist`,
        { serial: serial },
        config
      ).then((response) => {
        this.dblist = response.data.data;
      });
    },

    formatDate(value) {
      return MOMENT(value).format("DD/MM/YYYY  HH:mm:ss");
    },
  },
};
</script>

<style lang="scss" scoped>
.v-card {
  background-color: #fff;
  border-radius: 4px;
  box-shadow: 0px 3px 1px -2px rgba(0, 0, 0, 0.2),
    0px 2px 2px 0px rgba(0, 0, 0, 0.14), 0px 1px 5px 0px rgba(0, 0, 0, 0.12);
}
.showdata {
  padding: 0px 14px;

  .datawater {
    height: 100%;

    .v-card {
      margin: 0px;
      text-align: center;
      display: flex;
      justify-content: center;
      flex-direction: column;
      width: 100%;
      height: 100%;

      .data {
        position: relative;

        img {
          width: 200px;
          height: 200px;
          opacity: 0.5;
        }

        h1 {
          font-size: 35px;
          position: absolute;
          top: 50%;
          left: 50%;
          transform: translate(-50%, -50%);
        }
      }
    }
  }
  .datasensor {
    display: flex;
    flex-wrap: wrap;
    margin: -10px;
    height: 100%;

    .v-card {
      width: 50%;
      flex: 1 1 200px;
      margin: 10px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      text-align: center;
      padding: 10px;

      .v-icon {
        font-size: 45px;
      }

      h1 {
        margin-top: 10px;
      }

      p {
        margin: 10px 0px 0px 0px;
      }
    }
  }
  .showserial {
    padding: 25px 10px;
    .v-card {
      margin-top: 0px;
      // margin: 0px;
      height: 100%;
    }
  }
}

.statuspump {
  padding: 0px;
}

@media screen and (min-width: 2200px) {
  .datasensor {
    margin: 0px !important;

    card {
      margin: 0px 10px !important;
    }
  }
}

@media screen and (max-width: 958px) {
  .showdata {
    display: flex;
    flex-direction: column-reverse;
    padding: 0px;
    .showserial {
      width: 100%;
    }
  }
}

// @keyframes img {
//   0% {
//     transform: rotateZ(0deg);
//   }
//   100% {
//     transform: rotateZ(360deg);
//   }
// }
</style>
