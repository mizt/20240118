const { execSync } = require("child_process");

let err = false;
try {
	const result = execSync("ps -e | grep http-server");
	if(result&&result.length) {
		if(result[result.length-1]==="\n") result = result.slice(0,-1) ;
		const arr = result.toString().split("\n")
		for(var k=0; k<arr.length; k++) {
			if(!arr[k].match(/grep/)&&arr[k].match(/http-server/)) {
				const pid = +(arr[k].split(" ")[0]);
				if(pid) {
					execSync("kill -9 "+pid);
				}
			}
		}
	}
	execSync("./node_modules/http-server/bin/http-server ./docs -p 8080　& open http://localhost:8080/");
}
catch(e) {
	err = true;
}