const { execSync } = require("child_process");

let err = false;
try {
	const result = execSync("ps -e | grep http-server");
	if(result&&result.length) {
		if(result[result.length-1]==="\n") result = result.slice(0,-1);
		const arr = result.toString().split("\n")
		for(var k=0; k<arr.length; k++) {
			if(!arr[k].match(/grep/)&&arr[k].match(/http-server/)) {
				const pid = +(arr[k].split(" ")[0]);
				if(pid) execSync("kill -9 "+pid);
			}
		}
	}
	
	const date = new Date();
	const timestamp = date.getTime();
	
	execSync(`
cd ${__dirname}
set -eu
./app/build.sh
#./app/failure
#./app/success
#./app/argument
#./app/argument test
./app/argument 100
`)

execSync(`
sed -e "s/<p>test<\\/p>/<p>${date}<\\/p>/" ./index.html > ./docs/index.html
./node_modules/http-server/bin/http-server ./docs -p 8080　& sleep 1; open http://localhost:8080/?t=${timestamp}
`);
}
catch(e) {
	err = true;
}

console.log(err);