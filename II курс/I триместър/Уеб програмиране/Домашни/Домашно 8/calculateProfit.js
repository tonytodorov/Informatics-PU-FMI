function calculateProfit() {
        var sn1=document.getElementById("sn1").value;
        var sn2=document.getElementById("sn2").value;
        if (sn1 == "" || sn2 == ""){
        alert("Невалидни данни!");
        return false;
        }
        totalProfit=(Math.round((Number(sn1) - Number(sn2)) - (Number(sn1) - Number(sn2)) * 0.20));
        document.getElementById("sanswer").innerHTML=totalProfit;
}