const http = require("node:http");
const version = process.env.APP_VERSION || "local";
http.createServer((req, res) => {
  res.setHeader("content-type", "application/json");
  if (req.url === "/health") { res.writeHead(200); return res.end(JSON.stringify({status:"UP"})); }
  if (req.url === "/version") { res.writeHead(200); return res.end(JSON.stringify({version,arch:process.arch})); }
  res.writeHead(404); res.end(JSON.stringify({error:"not found"}));
}).listen(Number(process.env.PORT || 3000), "0.0.0.0");
