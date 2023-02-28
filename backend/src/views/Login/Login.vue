<template>
  <div class="login">
    <div class="back"></div>
    <div class="box">
      <div class="boxlogin">
        <div class="showimg">
          <img id="img" src="/farmer.jpg" alt="" />
        </div>
        <div class="login_wrap">
          <img src="/logo_ifp.png" alt="" />
          <h2>Sign In</h2>
          <v-form ref="form" v-model="isValid" @submit.prevent="login">
            <v-text-field
              v-model="formlogin.username"
              label="Username"
            ></v-text-field>
            <v-text-field
              v-model="formlogin.password"
              @click:append="() => (show1 = !show1)"
              label="Password"
              :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
              :type="show1 ? 'text' : 'password'"
            ></v-text-field>
            <v-btn rounded block type="submit">Login</v-btn>
          </v-form>
          <footer>
            <p>
              ยังไม่ได้ลงทะเบียนใช้งาน ? |
              <button @click="trigger('res')" class="register">
                ลงทะเบียน
              </button>
            </p>
          </footer>
        </div>
      </div>
      <!-- -----------------------end boxlogin-------------------------------- -->
      <div class="boxregister">
        <div class="login_wrap">
          <img src="/logo_ifp.png" alt="" />
          <h2>Sing Up</h2>
          <v-form @submit.prevent="res">
            <v-text-field
              v-model="formres.serial"
              label="SerialNumber "
            ></v-text-field>
            <v-text-field
              v-model="formres.username"
              label="Username"
            ></v-text-field>
            <v-text-field
              v-model="formres.password"
              :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
              :rules="[rules.required, rules.min]"
              :type="show1 ? 'text' : 'password'"
              name="input-10-1"
              label="Paaword"
              @click:append="show1 = !show1"
            ></v-text-field>
            <v-btn rounded block type="submit">Sing Up</v-btn>
          </v-form>
          <footer>
            <p>
              ยังไม่ได้ลงทะเบียนใช้งาน ? |
              <button @click="trigger('login')" class="register">
                เข้าสู่ระบบ
              </button>
            </p>
          </footer>
        </div>
        <div class="showimg">
          <img
            id="img"
            src="https://images.unsplash.com/photo-1505471768190-275e2ad7b3f9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=100"
            alt=""
          />
        </div>
      </div>
      <!-- ------------------------end boxres-------------------------------- -->
    </div>
    <div class="page-loader" v-if="isloaded">
      <div class="logo">
        <img src="/engine2.png" alt="">
      </div>
      <div class="boxloader">
        <div class="cube"></div>
        <div class="cube"></div>
        <div class="cube"></div>
        <div class="cube"></div>
        <div class="cube"></div>
      </div>
    </div>
    <!-- -----------end loder------------------------------------------------------ -->
    <v-snackbar
      v-model="snackbar"
      :color="color"
      timeout= 2000
      transition
    >
      {{ this.message }}
    </v-snackbar>
  </div>
</template>

<script>
import Axios from "axios";
import { mapState, mapMutations } from "vuex";
export default {
  name: "Login",
  data() {
    return {
      show1: false,
      isloaded:false,
      snackbar: false,
      message:'',
      color:'',
      formlogin: {
        username: "",
        password: ""
      },
      formres: {
        serial: "",
        username: "",
        password: ""
      },
      rules: {
        required: value => !!value || "กรุณากรอกรห้สผ่าน",
        min: v => v.length >= 8 || "รห้สอย่างน้อย 8 ตัวอักษร"
      }
    };
  },
  
  computed: {
  ...mapState(["datauser"]),
  },

  methods: {
    trigger(item) {
      const boxlogin = document.querySelector(".boxlogin");
      const boxregister = document.querySelector(".boxregister");
      if (item == "login") {
        boxlogin.style.transform = "perspective(10000px) rotateY(0deg)";
        boxregister.style.transform = "perspective(10000px) rotateY(180deg)";
      } else {
        boxlogin.style.transform = "perspective(10000px) rotateY(-180deg)";
        boxregister.style.transform = "perspective(10000px) rotateY(0deg)";
      }
    },
     login() {
      this.isloaded = true;
        Axios.post(`${process.env.VUE_APP_APIURL}/api/login/`, this.formlogin)
        .then (response => {
          if (response.status == 200) {
            this.snackbar = true;
            this.color = "#4CAF50"
            this.message = "เข้าสู่ระบบสำเร็จ";
            localStorage.setItem("token", response.data.token);
              setTimeout(() => { this.$router.replace("/"); }, 2000);    
          }
        })
        .catch(err => {
          this.color = "#cd1205"
          this.isloaded = false;
          this.message = err.response.data.message;
          this.snackbar = true;
        });
    },
    res() {
      this.isloaded = true;
      Axios.post(`${process.env.VUE_APP_APIURL}/api/login/res`,this.formres
      )
        .then(response => {
          if (response.status == 200) {
            this.snackbar = true;
            this.color = "#4CAF50"
            this.message = "ทำการสมัครสมาชิกสำเร็จ";
            localStorage.setItem("token", response.data.token);
            setTimeout(() => { this.$router.replace("/"); }, 2000);    
          }
        })
        .catch(err => {
          this.color = "#cd1205"
          this.isloaded = false;
          this.message = err.response.data.message;
          this.snackbar = true;
        });
    }
  }
};
</script>

<style lang="scss" scoped>
@import url("https://fonts.googleapis.com/css2?family=Kanit");
$colors: #8CC271, #69BEEB, #F5AA39, #E9643B, #8CC271, #69BEEB,;
.login {
  font-family: "Kanit", sans-serif;
  position: absolute;
  width: 100%;
  height: 100%;


  .back {
    height: 100%;
    background-image: url("https://images.unsplash.com/photo-1472133530746-ae9b21e91c41?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1051&q=80");
    background-position: center;
    // background-repeat: no-repeat;
    background-size: cover;
  }

  .box {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    display: flex;
    width: 50%;
    height: 70%;

    .boxlogin {
      background: #ffffff;
      transform: perspective(600px) rotateY(0deg);
      box-shadow: -6px 3px 70px 0px rgba(0, 0, 0, 0.75);
    }

    .boxregister {
      background: #ffffff;
      transform: perspective(600px) rotateY(180deg);
      box-shadow: -6px 3px 70px 0px rgba(0, 0, 0, 0.75);

      .showimg {
        box-shadow: -17px 3px 44px -32px rgba(0, 0, 0, 0.75);
      }
    }

    .boxlogin,
    .boxregister {
      width: 100%;
      height: 100%;
      overflow: hidden;
      backface-visibility: hidden;
      position: absolute;
      transition: transform 0.6s linear;
      display: flex;

      .showimg {
        width: 50%;
        img {
          height: 100%;
          width: 100%;
          box-shadow: 11px 3px 19px -10px rgba(0, 0, 0, 0.75);
        }
      }
      .login_wrap {
        width: 50%;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;

        form {
          padding: 0px 15px 15px 15px;
          width: 70%;

          label {
            margin-left: 5px;
          }

          .v-label--active {
            margin-left: 0px !important;
          }

          .primary--text {
            color: #629d25 !important;
          }

          .v-input {
            margin-top: 5px;
          }

          button[type="submit"] {
            margin-top: 15px;
            background: #629d25;
            color: #ffffff;
            font-weight: 200;
          }
          button[type="button"] {
            color: #629d25;
            font-weight: 200;
          }
        }

        footer {
          margin-top: 20px;
          p {
            padding: 0px;
            margin: 0px;
            text-align: center;

            .register {
              color: #629d25 !important;
            }
          }
        }
        img {
          width: 60%;
          margin-bottom: 5px;
        }

        p {
          font-size: 12px;
          button {
            outline: none;
          }
        }
      }
    }
  }
   .page-loader {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    background-color: #1f1f1fcb;
    z-index: 99;
  }
  // -----------------------------------------------------
  .logo{
    margin-bottom: 15px;
    
    img{
      animation: img 7.5s infinite;
      width: 100px;
      height: 100px;
    }
  }
  .boxloader{
    width: 10%;
    display: flex;
    justify-content: space-between;
    .cube{
      width: 15px;
      height: 15px;
      border-radius: 100%;
  
       @for $i from 1 through length($colors) {
        &:nth-child(#{$i}) {
          background-color: nth($colors, $i);
        }
      }
   
      &:first-child {
        animation: left 1.5s infinite;
      }
      &:nth-last-child(4) {
        animation: left 1.5s infinite;
        animation-delay: 0.3s;
      }
      &:nth-last-child(3) {
        animation: left 1.5s infinite;
        animation-delay: 0.5s;
      }
      &:nth-last-child(2) {
        animation: left 1.5s infinite;
        animation-delay: 0.7s;
      }
      &:last-child {
        animation: left 1.5s infinite;
        animation-delay: 0.9s;
      }
    }
  }
  // -----------------------------------------------------
  @keyframes left {
    40% {
      transform: translateX(-10px);
    }
    50% {
      transform: translateX(0);     
    }
    75%{
      transform: translateY(-5px);
    }
    100%{
      transform: translateY(-0px);
    }
  }
  @keyframes img {
    0% {
      
    }
    50% {
      opacity: 0;
    }
  }
}

@media only screen and (max-width: 750px) {
  .showimg {
    display: none;
  }
  .box {
    width: 80% !important;
    .login_wrap {
      width: 100% !important;
    }
  }
}
</style>
