/* global jQuery */
(function ($) {
    'use strict';

    function peopleToPizzas(people) {
        return Math.ceil(people * 3 / 8);
    }

    function pluralize(count) {
        return count === 1 ?  '' : 's';
    }

    $('#people').on('change blur', function (e) {
        var count = parseInt($(this).val(), 10),
            required = peopleToPizzas(count);
        $('#result').text(required + ' pizza' + pluralize(required));
    });

})(jQuery);
