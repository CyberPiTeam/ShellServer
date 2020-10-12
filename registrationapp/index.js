const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const PORT = 8080;


app.use(bodyParser.json());

app.post('/login',(req,res)=>{
	if(!('username' in req.body.username) || !('password' in req.body.password))
		return res.send({
			success:false,
			error:'Invalid request'
		});
	//validate username is alphanumeric
	

});

app.listen(PORT,()=>{
	console.log(`Listening on port ${PORT}.`);
});
