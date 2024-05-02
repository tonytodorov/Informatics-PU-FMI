   min = 12;
   sec = 0;
setInterval(() => {
    //d = new Date(); //object of date()
    //hr = d.getHours();
    //min = d.getMinutes();
    //sec = d.getSeconds();
	sec++;

		min=sec/60; 
    
	 
    //hr_rotation = 30 * hr + min / 2; //converting current time
	
	hr_rotation = 30 * min + sec / 120;
    //min_rotation = 6* min;
    min_rotation = 6 * sec;
	
	
  
    hour.style.transform = `rotate(${hr_rotation}deg)`;
    minute.style.transform = `rotate(${min_rotation}deg)`;
    
}, 1000);


