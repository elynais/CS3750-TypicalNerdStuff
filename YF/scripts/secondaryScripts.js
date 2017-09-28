window.onload = function () {
	//Call the function to check the querystring value
	var success = emailSuccessful('success');
	var elem = document.getElementsByClassName("input_text");
	var sub = document.getElementById("submit"); 
	var fName, lName, email, message;
	//If the querystring value returns true
	if (success === "true") {
		//To something to let the user know the form sumitted successfully
		alert("Your form has been submitted. Thank You.");
	}
	else {
		//Do your regular code that happens when the page loads (not after returning from the server
			for(var i = 0; i < elem.length; i++) {
				elem[i].addEventListener("input", checker)			
		}
		
		
		for(var i = 0; i < elem.length; i++) {
				elem[i].addEventListener("blur", checker2)			
		}
		
		


		
		
		function checker() {
			var name = this.getAttribute("name");
			
			
			if(name === "firstName") {
							
				fName = true;
			}
			
			if(name === "lastName") {
				lName = true;
			}
			
			if(name === "email") {
				email = true;
			}
			
			if(name === "message") {
				
				var clean = scriptCheck();
				
				if(clean){				
					message = true;			
				}
				
				if(!clean){
					message = false;
				}
				
			}
			
			if(fName && lName && email && message) {
				sub.removeAttribute("disabled");
			}
			
			if(!message){
				sub.setAttribute("disabled", "disabled");
			}
			
			
		};
		
		function checker2() {
			var text_value = this.value;	

			if(text_value === ""){
				var name = this.getAttribute("name");
				
				if(name === "firstName") {				
					document.getElementById('fName_change').style.visibility = "visible";
					document.getElementsByName('firstName')[0].style.borderColor = "red";
				}
			
				if(name === "lastName") {
					document.getElementById('lName_change').style.visibility = "visible";
					document.getElementsByName('lastName')[0].style.borderColor = "red";
				}
				
				if(name === "email") {
					document.getElementById('email_change').style.visibility = "visible";
					document.getElementsByName('email')[0].style.borderColor = "red";
				}
				
				if(name === "message") {
					document.getElementById('message_change').style.visibility = "visible";
					document.getElementsByName('message')[0].style.borderColor = "red";
				}
					
			}
			
			
		};
		
		function scriptCheck(){
			var data = document.getElementsByName("message")[0].value;
			var result = data.search("<script>");
			var result2 = data.search("</script>");
			var pass = false;
			
			if((result === -1) && (result2 === -1)){
				pass = true			
			}
			
			return pass;		
		}
		
		
	}
	
	///This is a function that will parse the querystring and return a value or null
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