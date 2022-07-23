require("dotenv").config();
const express = require("express");
const cors = require("cors");
const app = express();

app.use(cors({ origin: process.env.REMOTE_CLIENT_APP, credentials: true }));
const port = 3000

app.post('/addnft', async(req, res) => {
    const { walletAddress, objName } = req.body
    
    res.json({success:true})
  })

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})