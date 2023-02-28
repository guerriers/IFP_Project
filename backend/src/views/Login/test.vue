
     <v-col
        cols="12"
      >

      <v-col cols="12" sm="5" lg="5">
        <div class="datawater">
          <card>
            <h1>Water</h1>
            <div class="data">
              <img src="/water.png" alt="" />
              <h1>{{ this.dbrealtime.water_level }}%</h1>
            </div>
          </card>
        </div>
      </v-col>
      <v-spacer />
      <v-col cols="12" sm="7" lg="7">
        <div class="datasensor">
          <card>
            <v-icon> mdi-water-percent </v-icon>
            <h1>{{ this.dbrealtime.temp }}%</h1>
            <p>Temp</p>
          </card>

          <card>
            <v-icon> mdi-water-percent </v-icon>
            <h1>{{ this.dbrealtime.humi }}%</h1>
            <p>Humi</p>
          </card>

          <card>
            <v-icon> mdi-water-percent </v-icon>
            <h1>
              {{ this.dbrealtime.light_int }}
            </h1>
            <p>light</p>
          </card>

          <card>
            <v-icon> mdi-water-percent </v-icon>
            <h1>
              {{ this.dbrealtime.ec }}
            </h1>
            <p>ec</p>
          </card>
        </div>
      </v-col>