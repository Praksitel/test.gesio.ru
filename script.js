$( document ).ready(function() {

    refreshPage(); // и начались автоматические запросы

    function refreshPage() {
        var appvalue = new Date().getTime();
        $.ajax({
            type:   "POST",
            url:    'test.gesio.ru:8080/set/' + appvalue
            });

        setTimeout(refreshPage, 1000);
    };
});