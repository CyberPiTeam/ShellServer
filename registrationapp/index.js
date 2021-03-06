const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs');
const { spawn } = require('child_process');
const app = express();
const PORT = 8080;


app.use(bodyParser.json());

app.post('/register',async (req,res)=>{
	if(!('username' in req.body) || !('password' in req.body))
		return res.send({
			success:false,
			message:'Invalid request'
		});
	if(req.body.username === '')
		return res.send({
			success:false,
			message:'Username cannot be blank.'
		});
	if(req.body.password === '')
		return res.send({
			success:false,
			message:'Password cannot be blank.'
		});

	//validate username is alphanumeric
	if(!(/^[a-z0-9]+$/.test(req.body.username)))
		return res.send({
			success:false,
			message:'Invalid username. Must be alphanumeric and lowercase.'
		});
	/*if(!(/^[a-z0-9]+$/i.test(req.body.password)))
		return res.send({
			success:false,
			message:'Invalid password. Must be alphanumeric. Sorry.'
		});*/
	res.send(await addUser(req.body.username,req.body.password));
});



const callAddUser = (username,password)=>{
	return new Promise((resolve,reject)=>{
		const proc = spawn('adduser',['--add_extra_groups',username])
		proc.stdin.write(`${password}\n${password}\n\n\n\n\n\n\n`);
		proc.stdin.end();
		//proc.stdout.on('data',a=>console.log('stdout: ',a.toString()));
		//proc.stderr.on('data',a=>console.log('stderr: ',a.toString()));
		proc.on('close', (code) => {
			resolve();
		});
	});
}


const addUser = async (username, password)=>{
	const userExists = fs.readFileSync('/etc/passwd').toString().split('\n').map(line=>line.split(':')[0]).includes(username);
	if(userExists)
		return {
			success:false,
			message:'User already exists!'
		}
	await callAddUser(username,password);
	//execSync(`printf "${password}\n${password}\n\n\n\n\n\n\n" | adduser --add_extra_groups ${username}`);
	fs.writeFileSync(`/home/${username}/.hushlogin`,'');
	return {
		success: true,
		message: 'Registered user!'
	}


}

app.listen(PORT,()=>{
	console.log(`Listening on port ${PORT}.`);
});
