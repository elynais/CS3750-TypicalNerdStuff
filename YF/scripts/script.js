window.onload = function () {
	var success = emailSuccessful('success');
	var successDiv = document.getElementById("successDiv");
	
	if (success === "true") {
		var successStr = "<h2 class='red'>The message came back from the server correctly</h2>";
		successDiv.innerHTML = successDiv.innerHTML.replace(successDiv.innerHTML, successStr);
	}
	else {
		successDiv.innerHTML = "<h2 class='blue'>This text will be replaced when the server redirects sucessfully.</h2>";
	
		fName = document.querySelector("[name=firstName]");
		fName.addEventListener("keyup", myKeyupFunction);
		
		function myKeyupFunction() {
			fName.value = fName.value.toUpperCase();
		}
	}//move to wrap the rest of the code or point out the null reference error
	
	function emailSuccessful(field) {
		//Saves the URL of the current page to the variable
		var href = window.location.href;
		//RegEx to find the value of the querystring
		//[?&] - matches any characters in the character set between the []
		//=([^&#]*) - matches anything after the equals sign zero or more times that is NOT a & or #
		var reg = new RegExp( '[?&]' + field + '=([^&#]*)', 'i' );
		//Pass the URL to check the value of the querystring, returns a result array or null
		var string = reg.exec(href);
		//If there are results in the array, return the recond element, otherwise, return null
		return string ? string[1] : null;
	}
	
}