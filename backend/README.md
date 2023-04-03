# update 
- New version 30/9/2563
# Readme

## Deploy Vue.js to Github 
- สร้าง repositiory โดย new repository ใน Github ตั้งชื่อว่า test
- ไปที่ command line โดยใช้คำสั่ง

          git clone https://github.com/guerriers/IFP_Project.git

  โดย HTTPS นี้ ดูได้จาก repository ที่เราสร้างขึ้นมา หลังจากนั้นจะได้ folder ที่ชื่อว่า test
- ให้ copy file และ folder ทั้งหมดที่อยู่ใน project งานของเรา `ยกเว้น folder ที่ชื่อว่า .git` จากนั้นนำไป paste ใน folder ที่ชื่อว่า test 
- ติดตั้ง `express` และ `serve-static` โดยใช้คำสั่ง

          npm install express serve-static --save
          
- สร้าง file ชื่อว่า `server.js` แล้ว copy ข้อความข้างล่างลงไป paste ใน `server.js`

          const express = require('express')
          const serveStatic = require('serve-static')
          const path = require('path')

          const app = express()

          //here we are configuring dist to serve app files
          app.use('/', serveStatic(path.join(__dirname, '/dist')))

          // this * route is to serve project on different page routes except root `/`
          app.get(/.*/, function (req, res) {
              res.sendFile(path.join(__dirname, '/dist/index.html'))
          })

          const port = process.env.PORT || 8080
          app.listen(port)
          console.log(`app is listening on port: ${port}`)

- ให้แก้ไข scripts ของ file ที่ชื่อว่า package.json โดยเพิ่มในส่วนของ scripts

          "scripts": {
             "start": "node server.js"
          },
          
- จากนั้นให้ใช้คำสั่งต่อไปนี้ เพื่ออัพ folder ลงไปใน Github 

          git add .
          git commit -m "Comment"
          git push   

## Sync Github - Heroku 
- สร้าง App บน Heroku โดยการ `Create New App`
- ไปยัง tab ของ `Settings` เลื่อนหาในส่วนของ `Buildpacks` ให้กดที่ `Add buildpack` แล้วเลือก `nodejs` จากนั้นให้กด Save changes
- จากนั้นให้ไปยัง tab ของ `Deploy` เลื่อนหาในส่วนของ `Deployment method` ให้กดที่ `Github Connected`
- ส่วนของ `Connect to GitHub` ให้ `Search` หา repo Github ที่เราต้องการ Deploy จากนั้นให้กด `Connect`
- ส่วนของ `Automatic deploys` ให้กดที่ `Enable Automatic Deploys`
- ส่วนของ `Manual deploy` ให้กดที่ `Deploy Branch`
- กดเปิด `Open App` เพื่อดูงานที่เรา Deploy มา (เป็นอันเสร็จสิ้น)

## Getting Started
- Install Nodejs from [Nodejs Official Page](https://nodejs.org/en/)
- Open your terminal
- Navigate to the project
- Run `npm install` or `yarn install` if you use [Yarn](https://yarnpkg.com/en/)
- Run `npm run dev` or `yarn serve` to start a local development server
- A new tab will be opened in your browser

You can also run additional npm tasks such as
- `npm run build` to build your app for production
- `npm run lint` to run linting.

## File Structure

Within the download you'll find the following directories and files:

```
