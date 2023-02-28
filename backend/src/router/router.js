import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
    mode: 'hash',
    base: process.env.BASE_URL,
    mode: 'history',
    routes: [{
            path: '/',
            component: () =>
                import('@/views/dashboard/Index'),
            children: [
                // Dashboard
                {
                    name: 'Dashboard',
                    path: '',
                    component: () =>
                        import('@/views/dashboard/pages/Dashboard'),
                },
                // Pages
                {
                    name: 'ตั้งค่าระบบ',
                    path: 'pages/Settingsystem',
                    component: () =>
                        import('@/views/dashboard/pages/Settingsystem'),
                },
                {
                    path: 'pages/UserProfile',
                    component: () =>
                        import('@/views/dashboard/pages/UserProfile'),
                    children: [{
                            name: 'ข้อมูลส่วนตัว',
                            path: '/pages/UserProfile/profile',
                            component: () =>
                                import('@/views/dashboard/component/userprofile/Profile')
                        },
                        {
                            name: 'เปลี่ยนรห้สผ่าน',
                            path: '/pages/UserProfile/password',
                            component: () =>
                                import('@/views/dashboard/component/userprofile/Password')
                        },
                        {
                            name: 'รห้สซีเรียล',
                            path: '/pages/UserProfile/serial',
                            component: () =>
                                import('@/views/dashboard/component/userprofile/Serial')
                        },

                    ],
                },

                {
                    path: 'pages/money',
                    component: () =>
                        import('@/views/dashboard/pages/money'),
                    children: [{
                            name: 'ยอดรวมการขาย',
                            path: '/pages/money/Dashboardsell',
                            component: () =>
                                import('@/views/dashboard/component/money/Dashboardsell'),
                        },
                        {
                            name: 'บัญชีธนาคาร',
                            path: '/pages/money/bankaccount',
                            component: () =>
                                import('@/views/dashboard/component/money/Bankaccount')
                        },
                    ],
                },

                {
                    path: 'pages/product',
                    component: () =>
                        import('@/views/dashboard/pages/product'),
                    children: [{
                            name: 'สินค้าทั้งหมด',
                            path: 'product/listproduct',
                            component: () =>
                            import('@/views/dashboard/pages/listproduct'),
                        },
                        {
                            name: 'สินค้าทั้งหมด',
                            path: '/pages/product/listproduct',
                            component: () =>
                                import('@/views/dashboard/component/product/Listproduct'),

                        },
                        {
                            name: 'แก้ไขสินค้า',
                            path: '/pages/product/listproduct/edit/:id',
                            component: () =>
                                import('@/views/dashboard/component/product/Editproduct'),
                        },
                        {
                            name: 'Sell Products',
                            path: '/pages/product/addproduct',
                            component: () =>
                                import('@/views/dashboard/component/product/AddProducts'),
                        },
                        {
                            name: 'คำสั่งซื้อ',
                            path: '/pages/product/order',
                            component: () =>
                                import('@/views/dashboard/component/product/Order'),
                        },
                    ],
                },

                {
                    path: 'pages/admin',
                    component: () =>
                        import('@/views/dashboard/pages/admin'),
                    children: [{
                            name: 'Setting Members',
                            path: '/pages/admin/settingmenber',
                            component: () =>
                                import('@/views/dashboard/component/admin/Settingmember'),
                        },
                        {
                            name: 'Add Serial',
                            path: '/pages/admin/addserial',
                            component: () =>
                                import('@/views/dashboard/component/admin/Addserial')
                        },
                    ],
                },
            ],
        },
        {
            name: 'login',
            path: '/login',
            component: () =>
                import('@/views/Login/Login'),
        },
        {
            path: '*',
            component: () =>
                import('@/views/Error/Error404'),
        },
    ],
})