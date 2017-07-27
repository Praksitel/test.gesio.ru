$( document ).ready(function() {

    refreshPage(); // и начались автоматические запросы

    function refreshPage() {
        $.ajax({
            /* прочие параметры */
            success: function () {
                setTimeout(refreshPage, 5000);
            }
        });

        $.ajax({
            url: "/api/getWeather",
            data: {
                zipcode: 97201
            },
            success: function (result) {
                $("#weather-temp").html("<strong>" + result + "</strong> degrees");
            }
        });
    }
});