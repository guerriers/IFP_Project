<template>
  <v-navigation-drawer
    id="core-navigation-drawer"
    v-model="drawer"
    color="info"
    :expand-on-hover="expandOnHover"
    :right="$vuetify.rtl"
    :src="bar"
    :mini-variant.sync="mini"
    mobile-break-point="960"
    app
    width="250"
    dark
    v-bind="$attrs"
  >
    <!-- <template v-slot:img="props">
      <v-img
        :gradient="`to bottom, ${barColor}`"
        v-bind="props"
      />
    </template> -->

    <v-list-item class="logo_img">
        <v-img
          src="/engine.png"
          max-width="100%"
          mt-4
          ma-5
        />
    </v-list-item>

    <!-- <v-divider class="mb-2" /> -->

    <v-list  
      nav
      class="list_menu"
      rounded
      v-if="datauser.tbl_userdetail.status_level==='members'"
    >
      <v-list-group
        v-for="item in items"
        :key="item.title"
        :prepend-icon="item.icon"
        no-action
        color="#fff"
      >
        <template v-slot:activator>
          <v-list-item-content>
            <v-list-item-title class="haderlist" v-text="item.title"></v-list-item-title>
          </v-list-item-content>
        </template>

        <v-list-item 
          v-for="child in item.link"
          :key="child.title"
          class="listitem"
        >
          <v-list-item-content>
            <base-item
              :item="child"
              :v-if="items.check"
            />
          </v-list-item-content>
        </v-list-item>
      </v-list-group>
    </v-list>

  <v-list
      v-if="datauser.tbl_userdetail.status_level==='Admin'"
      nav
      class="list_menu"
      rounded
    >
      <v-list-group
        v-for="item in adminMenu"
        :key="item.title"
        :prepend-icon="item.icon"
        no-action
        color="#fff"
      >
        <template v-slot:activator>
          <v-list-item-content>
            <v-list-item-title class="haderlist" v-text="item.title"></v-list-item-title>
          </v-list-item-content>
        </template>

        <v-list-item 
          v-for="child in item.link"
          :key="child.title"
          class="listitem"
        >
          <v-list-item-content>
            <base-item
              :item="child"
              :v-if="items.check"
            />
          </v-list-item-content>
        </v-list-item>
      </v-list-group>
    </v-list>

  </v-navigation-drawer>
</template>

<script>
  // Utilities
  import {
    mapState,
  } from 'vuex'

  export default {
    name: 'DashboardCoreDrawer',

    props: {
      expandOnHover: {
        type: Boolean,
        default: false,
      },
    },

    data: () => ({
      items: [
        {
          title: 'จัดการระบบ',
          icon: 'fas fa-cogs',
          link: [
              {
                icon: 'mdi-view-dashboard',
                title: 'Dashboard',
                to: '/',
              },
              {
                icon: 'fas fa-cog',
                // icon: 'fas fa-sliders-h',
                title: 'Setting System',
                to: '/pages/Settingsystem',
              },
            ],
        },
        {
          title: 'จัดการขาย',
          icon: 'fas fa-shopping-cart',
          link: [
            {
              icon: 'fas fa-store',
              title: 'สินค้าของฉัน',
              to: '/pages/product/listproduct',
            },
            {
              icon: 'mdi-store-plus',
              title: 'เพิ่มสินค้าใหม่',
              to: '/pages/product/addproduct',
            },
            {
              icon: 'fas fa-clipboard-list',
              title: 'คำสั่งซื้อสินค้า',
              to: '/pages/product/order',
            },
            ],
        },
        {
          title: 'การเงิน',
          icon: 'fas fa-money-bill-alt',
          link: [
              // {
              //   icon: 'fas fa-hand-holding-usd',
              //   title: 'ยอดการขาย',
              //   to: '/pages/money/Dashboardsell',
              // },
              {
              icon: 'fas fa-money-check',
              title: 'บัญชีธนาคาร',
              to: '/pages/money/bankaccount',
              },
            ],
        },
        {
          title: 'บัญชีของฉัน',
          icon: 'fas fa-users-cog',
          lavel: 'number',
          link: [
            {
              icon: 'fas fa-user-edit',
              title: 'ข้อมูลส่วนตัว',
              to: '/pages/UserProfile/profile',
            },
            {
              icon: 'fas fa-key',
              title: 'รห้สซีเรียล',
              to: '/pages/UserProfile/serial',
            },

            {
              icon: 'fas fa-user-lock',
              title: 'ตั้งค่ารห้สผ่าน',
              to: '/pages/UserProfile/password',
            },
            ],
        },
      ],
      adminMenu:[{
          title: 'บริหารจัดการ',
          icon: 'fas fa-users-cog',
          lavel: 'admin',
          link: [
            // {
            //   icon: 'mdi-account-group',
            //   title: 'ตั้งค่าผู้ใช้งาน',
            //   to: '/pages/admin/settingmenber',
            // },
            {
              icon: 'mdi-account-group',
              title: 'เพิ่มซีเรียล',
              to: '/pages/admin/Addserial',
            },
            ],
        },]
    }),

    computed: {
      ...mapState(["datauser"]),
      drawer: {
        get () {
          return this.$store.state.drawer
        },
        set (val) {
          this.$store.commit('SET_DRAWER', val)
        },
      },
      computedItems () {
        return this.items.map(this.mapItem)
      },
      profile () {
        return {
          avatar: true,
          title: this.$t('avatar'),
        }
      },
    },

    methods: {
      mapItem (item) {
        return {
          ...item,
          children: item.children ? item.children.map(this.mapItem) : undefined,
          title: this.$t(item.title),
        }
      },
    },
  }
</script>

<style lang="sass" >
  @import '~vuetify/src/styles/tools/_rtl.sass'

  #core-navigation-drawer
    .haderlist
      font-weight: bold

    a
      height: 5px

    .v-list-item__icon
      margin: auto
    
    i
      font-size: 16px

    .v-list-item__content
      padding: 0

    .v-list-group--no-action > .v-list-group__items > .v-list-item
      padding-left:20px

    .v-list-item
      width: 100% !important

    .logo_img
      width: 100% !important
      justify-content: center
      margin-top: 10px

    .list_menu
      margin-top: 20px

    .menu
      margin-top: 10px

    .hader
      margin-bottom: 15px

    .v-list-item
      width: 80%
      justify-content: center
      &__icon--text,
      &__icon:first-child
        justify-content: center
        text-align: center
        width: 20px

        +ltr()
          margin-right: 24px
          margin-left: 12px !important

        +rtl()
          margin-left: 24px
          margin-right: 12px !important

    .v-list--dense
      .v-list-item
        &__icon--text,
        &__icon:first-child
          margin-top: 10px

    .v-list-group--sub-group
      .v-list-item
        +ltr()
          padding-left: 8px

        +rtl()
          padding-right: 8px

      .v-list-group__header
        +ltr()
          padding-right: 0

        +rtl()
          padding-right: 0

        .v-list-item__icon--text
          margin-top: 19px
          order: 0

        .v-list-group__header__prepend-icon
          order: 2

          +ltr()
            margin-right: 8px

          +rtl()
            margin-left: 8px
</style>
